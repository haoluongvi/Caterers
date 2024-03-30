using System.ComponentModel.DataAnnotations;

namespace Caterers.Models
{
    public class ForgotPasswordDto
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }
}
