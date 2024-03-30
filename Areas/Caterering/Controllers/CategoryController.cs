using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Caterering.Controllers
{

	[Authorize(Roles = "Caterer")]
	[Area("Caterering")]
	[Route("caterer/category")]
	public class CategoryController : Controller
	{
		private readonly ICategoryService categoryService;

		public CategoryController(ICategoryService _categoryService)
		{
			categoryService = _categoryService;
		}

		// Action to display the category list
		[Route("")]
		[Route("index")]
		public IActionResult Index()
		{
			var categories = categoryService.GetAllCategories();
			return View(categories);
		}

		// Action to add a new category
		[HttpGet]
		[Route("create")]
		public IActionResult Create()
		{
			return View();
		}

		[HttpPost]
		[Route("create")]
		public IActionResult Create(Category category)
		{
			if (ModelState.IsValid)
			{
				categoryService.AddCategory(category);
				return RedirectToAction(nameof(Index));
			}
			return View(category);
		}

		// Action to edit an existing category
		[HttpGet]
		[Route("edit/{id}")]
		public IActionResult Edit(int id)
		{
			var category = categoryService.GetCategoryById(id);
			if (category == null)
			{
				return NotFound();
			}
			return View(category);
		}

		[HttpPost]
		[Route("edit/{id}")]
		public IActionResult Edit(Category category)
		{
			if (ModelState.IsValid)
			{
				categoryService.UpdateCategory(category);
				return RedirectToAction(nameof(Index));
			}
			return View(category);
		}

		// Action to delete a category
		[Route("delete/{id}")]
		public IActionResult Delete(int id)
		{
			categoryService.DeleteCategory(id);
			return RedirectToAction(nameof(Index));
		}
	}
}