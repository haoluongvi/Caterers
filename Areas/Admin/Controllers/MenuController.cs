using Caterers.Helpers;
using Caterers.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Caterers.Areas.Admin.Controllers
{
	[Authorize(Roles = "Admin")]
	[Area("admin")]
	[Route("admin/menu")]
	public class MenuController : Controller
	{
		private readonly IMenuService _menuService;
		private readonly IWebHostEnvironment _environment;

		public MenuController(IMenuService menuService, IWebHostEnvironment environment)
		{
			_menuService = menuService;
			_environment = environment;
		}

		// Actions for managing menus

		[Route("")]
		[Route("index")]
		public IActionResult Index()
		{
			var menus = _menuService.GetMenus();
			return View(menus);
		}

		[HttpGet]
		[Route("create")]
		public IActionResult Create()
		{
			var caterers = _menuService.GetAllCaterers();
			ViewBag.Caterers = new SelectList(caterers, "Id", "Name");
			return View();
		}

		[HttpPost]
		[Route("create")]
		public IActionResult Create(Menu menu, IFormFile file)
		{
			if (file != null && file.Length > 0)
			{
				var fileName = FileHelper.generateFileName(file.FileName);
				var path = Path.Combine(_environment.WebRootPath, "images", fileName);

				using (var fileStream = new FileStream(path, FileMode.Create))
				{
					file.CopyTo(fileStream);
				}

				menu.Image = fileName;
			}
			else
			{
				menu.Image = "no-image.jpg";
			}

			if (ModelState.IsValid)
			{
				_menuService.AddMenu(menu);
				return RedirectToAction("Index");
			}

			ViewBag.Menus = _menuService.GetMenus();
			return View(menu);
		}

		[HttpGet]
		[Route("edit/{id}")]
		public IActionResult Edit(int id)
		{
			var caterers = _menuService.GetAllCaterers();
			ViewBag.Caterers = new SelectList(caterers, "Id", "Name");
			var menu = _menuService.GetMenuById(id);
			if (menu == null)
			{
				return NotFound();
			}

			return View("Edit", menu);
		}

		[HttpPost]
		[Route("edit/{id}")]
		public IActionResult Edit(Menu menu, IFormFile file)
		{
			if (file != null && file.Length > 0)
			{
				var fileName = FileHelper.generateFileName(file.FileName);
				var path = Path.Combine(_environment.WebRootPath, "images", fileName);

				using (var fileStream = new FileStream(path, FileMode.Create))
				{
					file.CopyTo(fileStream);
				}

				menu.Image = fileName;
			}

			if (ModelState.IsValid)
			{
				_menuService.UpdateMenu(menu);
				return RedirectToAction("Index");
			}

			var caterers = _menuService.GetAllCaterers();
			ViewBag.Caterers = new SelectList(caterers, "Id", "Name");
			return View(menu);
		}


		[Route("delete/{id}")]
		public IActionResult Delete(int id)
		{
			try
			{
				if (_menuService.Delete(id))
				{
					TempData["msg"] = "Done!";
				}
				else
				{
					TempData["msg"] = "Failed";

				}
				return RedirectToAction("index");
			}
			catch (Exception)
			{

				return NotFound();
			}

		}
	}
}