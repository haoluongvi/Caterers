using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Controllers
{
    [Route("Account")]
    public class AccountController : Controller
    {
        private readonly IAccountService _accountService;
        private readonly IEmailService _emailService;

        public AccountController(IAccountService accountService, IEmailService emailService)
        {
            _accountService = accountService;
            _emailService = emailService;
        }

        // GET: Account/Register
        [HttpGet]
        [Route("register")]
        public IActionResult Register()
        {
            // Display the registration form
            return View(new CustomerRegistrationDto());
        }

        // POST: Account/Register
        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> Register(CustomerRegistrationDto registration)
        {
            if (!ModelState.IsValid)
            {
                return View(registration);
            }

            if (registration.Password != registration.ConfirmPassword)
            {
                ModelState.AddModelError("", "The passwords do not match.");
                return View(registration);
            }

            var result = await _accountService.RegisterCustomerAsync(registration);
            if (result)
            {
                // Registration was successful, send an email
                string emailSubject = "Welcome to Caterers!";
                string emailBody = $"Dear {registration.Name},<br/>Welcome to Caterers. Your account has been successfully created.";

                await _emailService.SendEmailAsync(registration.Email, emailSubject, emailBody);

                return RedirectToAction("Login", "Customer");
            }
            else
            {
                ModelState.AddModelError("", "Registration failed. Please try again.");
                return View(registration);
            }
        }

        [HttpGet]
        [Route("forgot-password")]
        public IActionResult ForgotPassword()
        {

            return View();
        }

        [HttpPost]
        [Route("forgot-password")]
        public async Task<IActionResult> ForgotPassword(ForgotPasswordDto model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var token = await _accountService.GeneratePasswordResetTokenAsync(model.Email);
            if (string.IsNullOrEmpty(token))
            {
                // Handle the case where the email was not found in the database
                ModelState.AddModelError("", "Email address not found.");
                return View(model);
            }

            // Assuming token generation was successful, send a password reset email
            var callbackUrl = Url.Action("ResetPassword", "Account",
                new { token = token, email = model.Email }, protocol: HttpContext.Request.Scheme);

            string emailSubject = "Reset Password";
            string emailBody = $"Please reset your password by clicking <a href='{callbackUrl}'>here</a>.";

            await _emailService.SendEmailAsync(model.Email, emailSubject, emailBody);

            // Redirect the user to the ForgotPasswordConfirmation view after sending the email
            return RedirectToAction("ForgotPasswordConfirmation");
        }

        [HttpGet]
        [Route("reset-password")]
        public IActionResult ResetPassword(string token, string email)
        {
            var model = new ResetPasswordDto { Token = token, Email = email };
            return View(model);
        }

        [HttpPost]
        [Route("reset-password")]
        public async Task<IActionResult> ResetPassword(ResetPasswordDto model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var result = await _accountService.ResetPasswordAsync(model.Email, model.Token, model.NewPassword);
            if (result)
            {
                return RedirectToAction("ResetPasswordConfirmation");
            }
            else
            {
                ModelState.AddModelError("", "Error resetting password.");
                return View(model);
            }
        }

        [HttpGet]
        [Route("ForgotPasswordConfirmation")]
        public IActionResult ResetPasswordConfirmation()
        {
            // Display a confirmation message or view to the user
            return View();
        }

        // ... other actions ...
    }
}
