using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Caterers.Areas.Caterering.Controllers
{
	[Authorize(Roles = "Caterer")]
	[Area("Caterering")]
	[Route("caterering/caterer")]

	public class CatererController : Controller
	{
		private readonly ICatererService _catererService;

		public CatererController(ICatererService catererService)
		{
			_catererService = catererService;
		}

		[Route("")]
		[Route("index")]

		public async Task<IActionResult> Index()
		{
			var caterers = await _catererService.GetAllCaterersAsync();
			return View(caterers);
		}

		[HttpGet]
		[Route("create")]
		public async Task<IActionResult> Create()
		{
			var categories = await _catererService.GetAllCategoriesAsync();
			ViewBag.Categories = new SelectList(categories, "Id", "Name");
			return View();
		}

		[HttpPost]
		[Route("create")]
		public async Task<IActionResult> Create(Caterer caterer)
		{
			if (ModelState.IsValid)
			{
				await _catererService.CreateCatererAsync(caterer);
				return RedirectToAction("Index");
			}

			var categories = await _catererService.GetAllCategoriesAsync();
			ViewBag.Categories = new SelectList(categories, "Id", "Name");
			return View(caterer);
		}

		[HttpGet]
		[Route("edit/{id}")]
		public async Task<IActionResult> Edit(int id)
		{
			var caterer = await _catererService.GetCatererByIdAsync(id);
			if (caterer == null)
			{
				return NotFound();
			}

			var categories = await _catererService.GetAllCategoriesAsync();
			ViewBag.Categories = new SelectList(categories, "Id", "Name");
			return View(caterer);
		}

		[HttpPost]
		[Route("edit/{id}")]
		public async Task<IActionResult> Edit(int id, Caterer caterer)
		{
			if (id != caterer.Id)
			{
				return NotFound();
			}

			if (ModelState.IsValid)
			{
				await _catererService.UpdateCatererAsync(caterer);
				return RedirectToAction("Index");
			}

			var categories = await _catererService.GetAllCategoriesAsync();
			ViewBag.Categories = new SelectList(categories, "Id", "Name");
			return View(caterer);
		}

		[Route("delete/{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			await _catererService.DeleteCatererAsync(id);
			return RedirectToAction("Index");
		}

	}
}
