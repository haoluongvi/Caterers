using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Controllers
{
    [Route("searchcaterer")]
    public class SearchCatererController : Controller
    {
        private readonly ISearchCatererService _searchCatererService;

        public SearchCatererController(ISearchCatererService searchCatererService)
        {
            _searchCatererService = searchCatererService;
        }

        // GET: SearchCaterer
        [Route("")]
        [Route("index")]
        [Route("~/")]
        public IActionResult Index(string address, int? categoryId, int? minimumGuestCount)
        {
            var categories = _searchCatererService.GetCategories();
            var addresses = _searchCatererService.GetAddresses();
            bool searchPerformed = false;

            if (minimumGuestCount.HasValue && minimumGuestCount <= 0)
            {
                ModelState.AddModelError(string.Empty, "Minimum guest count must be greater than 0.");
            }

            List<Caterer> caterers = new List<Caterer>();

            // Check if any search parameters are provided
            if (!string.IsNullOrEmpty(address) || categoryId.HasValue || minimumGuestCount.HasValue)
            {
                searchPerformed = true;
                caterers = _searchCatererService.SearchCaterers(address, categoryId, minimumGuestCount).ToList();
            }

            if (!caterers.Any() && searchPerformed && ModelState.IsValid)
            {
                ModelState.AddModelError(string.Empty, "No caterers found matching the criteria.");
            }

            var viewModel = new SearchCatererViewModel
            {
                Caterers = caterers,
                Categories = categories,
                Addresses = addresses,
                Address = address,
                CategoryId = categoryId,
                MinimumGuestCount = minimumGuestCount ?? 0,
                SearchPerformed = searchPerformed
            };

            return View(viewModel);
        }

        [HttpGet]
        [Route("getcategoriesbyaddress")]
        public IActionResult GetCategoriesByAddress(string address)
        {
            var categories = _searchCatererService.GetCategoriesByAddress(address);
            return Json(categories.Select(c => new { c.Id, c.Name }));
        }

        [HttpGet]
        [Route("details/{catererId}")]
        public IActionResult Details(int catererId)
        {
            var caterer = _searchCatererService.GetCatererDetails(catererId);
            if (caterer == null)
            {
                return NotFound();
            }

            // Asynchronous call to get menu items
            var menuItemsTask = _searchCatererService.GetCatererMenu(catererId);

            var viewModel = new CatererDetailsViewModel
            {
                Caterer = caterer,
                MenuItems = menuItemsTask.Result // Synchronously waiting for the task result (consider using async/await for better performance)
            };

            return View(viewModel);
        }

        [HttpGet]
        [Route("menudetails/{catererId}")]
        public async Task<IActionResult> MenuDetails(int catererId)
        {
            var menuItems = await _searchCatererService.GetCatererMenu(catererId);
            if (menuItems == null || !menuItems.Any())
            {
                return NotFound();
            }

            return View(menuItems);
        }
    }
}