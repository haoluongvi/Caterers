using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Admin.Controllers
{
	[Authorize(Roles = "Admin")]
	[Area("admin")]
	[Route("admin/role")]
	public class RoleController : Controller
	{
		private readonly IRoleService roleService;

		private readonly IAccountService accountService;

		public RoleController(IRoleService _roleService, IAccountService _accountService)
		{
			roleService = _roleService;
			accountService = _accountService;
		}

		[Route("")]
		[Route("index")]
		public IActionResult Index()
		{
			var roles = roleService.GetAllRoles();
			return View(roles);
		}

		[HttpGet]
		[Route("create")]
		public IActionResult Create()
		{
			var newRole = new Role();
			return View(newRole);
		}

		[HttpPost]
		[Route("create")]
		public IActionResult Create(Role role)
		{
			roleService.CreateRole(role);
			return RedirectToAction("Index");
		}

		[HttpGet]
		[Route("edit/{id}")]
		public IActionResult Edit(int id)
		{
			var role = roleService.GetRoleById(id);
			if (role == null)
			{
				return NotFound();
			}
			return View(role);
		}

		[HttpPost]
		[Route("edit/{id}")]
		public IActionResult Edit(Role role)
		{
			if (ModelState.IsValid)
			{
				roleService.UpdateRole(role);
			}
			return RedirectToAction("Index");
		}

		[HttpGet]
		[Route("delete/{id}")]
		public IActionResult Delete(int id)
		{
			roleService.DeleteRole(id);
			return RedirectToAction("Index");
		}

		// In RoleController
		[HttpGet]
		[Route("users/{id}")]
		public IActionResult Users(int id)
		{
			var role = roleService.GetRoleById(id);
			if (role == null)
			{
				return NotFound();
			}

			var roleUsers = roleService.GetRoleUsers(id);
			var allUsers = accountService.GetAllUsers().ToList(); // Assuming accountService is available

			ViewBag.RoleName = role.Name;
			ViewBag.Users = roleUsers.Select(ru => ru.User).ToList();
			ViewBag.AllUsers = allUsers;
			ViewBag.RoleId = id;

			return View(roleUsers);
		}

		[HttpPost]
		[Route("adduser")]
		public IActionResult AddUser(int roleId, int userId)
		{
			roleService.AddUserToRole(roleId, userId);
			return RedirectToAction("Users", new { id = roleId });
		}

		[HttpPost]
		[Route("removeuser")]
		public IActionResult RemoveUser(int roleId, int userId)
		{
			roleService.RemoveUserFromRole(roleId, userId);
			return RedirectToAction("Users", new { id = roleId });
		}
	}
}