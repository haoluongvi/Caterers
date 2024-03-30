using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/account")]
    public class AccountController : Controller
    {
        private readonly IAccountService accountService;

        public AccountController(IAccountService _accountService)
        {
            accountService = _accountService;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var users = accountService.GetAllUsers();
            return View(users);
        }

        [HttpGet]
        [Route("create")]
        public IActionResult Create()
        {
            var newUser = new UserTable(); // Create a new instance of UserTable
            return View(newUser); // Pass the new instance to the view
        }

        [HttpPost]
        [Route("create")]
        public IActionResult Create(UserTable user)
        {
            accountService.CreateUser(user);
            return RedirectToAction("Index");
        }

        [HttpGet]
        [Route("edit/{id}")]
        public IActionResult Edit(int id)
        {
            var user = accountService.GetUserById(id);
            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        [HttpPost]
        [Route("edit/{id}")]
        public IActionResult Edit(UserTable user)
        {
            if (ModelState.IsValid)
            {
                accountService.UpdateUser(user);

            }
            return RedirectToAction("Index");
        }

        [HttpGet]
        [Route("delete/{id}")]
        public IActionResult Delete(int id)
        {
            accountService.DeleteUser(id);
            return RedirectToAction("Index");
        }
    }
}