using Caterers.Models;

namespace Caterers.Services
{
	public interface IAccountService
	{
		UserTable GetUserById(int id); // Add this method
		UserTable GetUserByUsername(string username);
		IEnumerable<UserTable> GetAllUsers();
		void CreateUser(UserTable user);
		void UpdateUser(UserTable user);
		bool VerifyUserCredentials(string username, string password);
		void DeleteUser(int userId);
		Task<bool> RegisterCustomerAsync(CustomerRegistrationDto registration);

		Task<string> GeneratePasswordResetTokenAsync(string email);
		Task<bool> ResetPasswordAsync(string email, string token, string newPassword);
		Task AssignRoleToUser(int userId, string roleName);

	}
}