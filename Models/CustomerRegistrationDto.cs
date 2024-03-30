namespace Caterers.Models
{
	public class CustomerRegistrationDto
	{
		// Assuming these are the fields you want for registration
		public string Username { get; set; }
		public string Password { get; set; }
		public string ConfirmPassword { get; set; } // For verifying the password on the backend
		public string Name { get; set; }
		public string Address { get; set; }
		public string Phone { get; set; }
		public string Email { get; set; }

		// Additional fields can be added if required
	}
}
