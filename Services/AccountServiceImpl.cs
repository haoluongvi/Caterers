using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
	public class AccountServiceImpl : IAccountService
	{
		private readonly DatabaseContext db;
		private readonly IEmailService emailService;
		public AccountServiceImpl(DatabaseContext _db, IEmailService _emailService)
		{
			db = _db;
			emailService = _emailService;
		}

		public UserTable GetUserById(int id) // Implement this method
		{
			return db.UserTables.Find(id);
		}

		public UserTable GetUserByUsername(string username)
		{
			return db.UserTables.FirstOrDefault(u => u.Username == username);
		}

		public IEnumerable<UserTable> GetAllUsers()
		{
			return db.UserTables.ToList();
		}

		public void CreateUser(UserTable user)
		{
			user.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);
			db.UserTables.Add(user);
			db.SaveChanges();
		}

		public void UpdateUser(UserTable user)
		{
			var existingUser = db.UserTables.Find(user.Id);
			if (existingUser != null)
			{
				existingUser.Username = user.Username;
				existingUser.Name = user.Name;
				existingUser.Address = user.Address;
				existingUser.Phone = user.Phone;
				existingUser.Email = user.Email;
				existingUser.Status = user.Status;

				if (!string.IsNullOrEmpty(user.Password))
				{
					existingUser.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);
				}
				db.SaveChanges();
			}
		}

		public bool VerifyUserCredentials(string username, string password)
		{
			var user = GetUserByUsername(username);
			return user != null && BCrypt.Net.BCrypt.Verify(password, user.Password);
		}

		public void DeleteUser(int userId)
		{
			var user = db.UserTables.Find(userId);
			if (user != null)
			{
				db.UserTables.Remove(user);
				db.SaveChanges();
			}
		}

		public async Task<bool> RegisterCustomerAsync(CustomerRegistrationDto registration)
		{
			var hashedPassword = BCrypt.Net.BCrypt.HashPassword(registration.Password);

			var user = new UserTable
			{
				Username = registration.Username,
				Password = hashedPassword,
				Name = registration.Name,
				Address = registration.Address,
				Phone = registration.Phone,
				Email = registration.Email,
				Status = true
			};

			// Add the user to the context
			db.UserTables.Add(user);

			// Save the user to the database so that it gets an Id
			await db.SaveChangesAsync();

			// Now that the user has been saved and has an Id, assign the role
			await AssignRoleToUser(user.Id, "Customer");

			// Note: No need to call SaveChangesAsync() here again if AssignRoleToUser does it internally

			return true;
		}

		public async Task<string> GeneratePasswordResetTokenAsync(string email)
		{
			var user = db.UserTables.FirstOrDefault(u => u.Email == email);
			if (user == null) return null;

			// Generate a reset token - in a real application, use a secure random token generator
			var token = Guid.NewGuid().ToString();

			// Store the token in your database with an expiration date
			var passwordResetToken = new PasswordResetToken
			{
				UserId = user.Id,
				Token = token,
				ExpiryDate = DateTime.UtcNow.AddHours(24) // Token expires after 24 hours
			};

			db.PasswordResetTokens.Add(passwordResetToken);
			await db.SaveChangesAsync();

			//// The base URL of the link in the email, read from configuration or hardcoded
			//var passwordResetLink = $"http://localhost:5277/reset-password?token={token}&email={email}";

			//// Email content
			//string emailSubject = "Password Reset Request";
			//string emailBody = $"Please click on the following link to reset your password: {passwordResetLink}";

			//// Send the email
			//await emailService.SendEmailAsync(email, emailSubject, emailBody);

			return token;
		}

		public async Task<bool> ResetPasswordAsync(string email, string token, string newPassword)
		{
			var user = db.UserTables.FirstOrDefault(u => u.Email == email);
			if (user == null) return false;

			var passwordResetToken = db.PasswordResetTokens.FirstOrDefault(t => t.Token == token && t.ExpiryDate > DateTime.UtcNow);
			if (passwordResetToken == null) return false;

			// Reset the password
			user.Password = BCrypt.Net.BCrypt.HashPassword(newPassword);
			db.UserTables.Update(user);

			// Remove the token so it can't be used again
			db.PasswordResetTokens.Remove(passwordResetToken);

			await db.SaveChangesAsync();

			return true;
		}


		public async Task AssignRoleToUser(int userId, string roleName)
		{
			// Fetch the user and role from the database asynchronously
			var user = await db.UserTables.FindAsync(userId);
			var role = await db.Roles.FirstOrDefaultAsync(r => r.Name == roleName);

			if (user == null || role == null)
			{
				// Handle the case when the user or role doesn't exist
				// You might want to throw an exception or handle this case appropriately
				return;
			}

			// Check if the user already has the role assigned to prevent duplicates
			var existingRoleUser = await db.RoleUsers
										   .AnyAsync(ru => ru.UserId == userId && ru.RoleId == role.Id);
			if (existingRoleUser)
			{
				// The user already has this role assigned, so we don't need to do anything further
				return;
			}

			// Create the RoleUser association since it doesn't exist
			var roleUser = new RoleUser
			{
				UserId = userId,
				RoleId = role.Id,
				Status = true
			};

			// Add the new roleUser to the context and save the changes
			db.RoleUsers.Add(roleUser);
			await db.SaveChangesAsync();
		}

	}
}
