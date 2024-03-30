using Caterers.Models;
using Caterers.Security;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Caterers.Areas.Customer.Controllers
{
    [Area("Customer")]
    [Route("customer/login")]
    public class LoginController : Controller
    {
        private readonly DatabaseContext db;
        private readonly SecurityManager securityManager;

        public LoginController(DatabaseContext _db, SecurityManager _securityManager)
        {
            db = _db;
            securityManager = _securityManager;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("process")]
        public IActionResult Process(string username, string password)
        {
            var userTable = processLogin(username, password);

            if (userTable != null)
            {
                // Get the roles associated with the user
                var roles = userTable.RoleUsers
                    .Where(ru => ru.Status == true)
                    .Select(ru => ru.Role.Name)
                    .ToList();

                // Sign in the user with the SecurityManager
                securityManager.SignIn(this.HttpContext, userTable, roles);

                // Redirect user based on their role
                if (roles.Contains("Admin"))
                {
                    return RedirectToAction("index", "dashboard", new { area = "Admin" });
                }
                else if (roles.Contains("Caterer"))
                {
                    return RedirectToAction("index", "dashboard", new { area = "Caterering" });
                }
                else if (roles.Contains("Customer"))
                {
                    return RedirectToAction("index", "dashboard", new { area = "Customer" });
                }
                else
                {
                    return RedirectToAction("AccessDenied");
                }
            }
            else
            {
                ViewBag.error = "Invalid Account";
                return View("Index");
            }
        }

        private UserTable processLogin(string username, string password)
        {
            var userTable = db.UserTables.SingleOrDefault(u => u.Username.Equals(username) && u.Status == true);
            if (userTable != null && BCrypt.Net.BCrypt.Verify(password, userTable.Password))
            {
                return userTable;
            }
            return null;
        }

        [Route("signout")]
        public async Task<IActionResult> SignOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("index", "login", new { area = "admin" });
        }

        [HttpGet]
        [Route("profile")]
        public IActionResult Profile()
        {
            var username = User.FindFirstValue(ClaimTypes.Name);
            var userTable = db.UserTables.SingleOrDefault(a => a.Username.Equals(username));
            return View("Profile", userTable);
        }

        [HttpPost]
        [Route("profile")]
        public IActionResult Profile(UserTable userTable)
        {
            var currentAccount = db.UserTables.SingleOrDefault(u => u.Id == userTable.Id);
            if (!string.IsNullOrEmpty(userTable.Password))
            {
                currentAccount.Password = BCrypt.Net.BCrypt.HashPassword(userTable.Password);
            }
            currentAccount.Username = userTable.Username;
            currentAccount.Email = userTable.Email;
            currentAccount.Name = userTable.Name;
            currentAccount.Address = userTable.Address;
            currentAccount.Phone = userTable.Phone;
            db.SaveChanges();
            ViewBag.msg = "Profile updated successfully.";
            return View("Profile", currentAccount);
        }

        [Route("accessdenied")]
        public IActionResult AccessDenied()
        {
            return View("AccessDenied");
        }
    }
}