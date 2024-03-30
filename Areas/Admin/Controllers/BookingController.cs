using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Security.Claims;

namespace Caterers.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("Admin")]
    [Route("admin/booking")]
    public class BookingController : Controller
    {
        private readonly IBookingService bookingService;
        private readonly IAccountService accountService;
        private readonly ICatererService catererService;
        private readonly DatabaseContext db;

        public BookingController(IBookingService _bookingService, IAccountService _accountService, ICatererService _catererService, DatabaseContext _db)
        {
            bookingService = _bookingService;
            accountService = _accountService;
            catererService = _catererService;
            db = _db;
        }

        [Route("")]
        [Route("index")]
        public async Task<IActionResult> Index()
        {
            var bookingDetails = await bookingService.GetBookingDetailsAsync();
            return View(bookingDetails);
        }

        [HttpGet]
        [Route("create")]
        public async Task<IActionResult> Create()
        {
            var caterers = await catererService.GetAllCaterersAsync();

            // Retrieve the current logged-in user's ID
            var userIdStringValue = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (int.TryParse(userIdStringValue, out int userId))
            {
                // Assume GetUserById is an existing async method to fetch user details
                var currentUser = accountService.GetUserById(userId);

                ViewBag.Caterers = new SelectList(caterers, "Id", "Name");
                // Pass the current user to the view
                ViewBag.CurrentUserId = currentUser.Id;
                ViewBag.CurrentUserName = currentUser.Name;
            }
            else
            {
                // Handle the error appropriately if the user ID cannot be parsed
                // Redirect to an error page or add a model error
            }

            return View();
        }

        [HttpPost]
        [Route("create")]
        public async Task<IActionResult> Create(Booking booking)
        {
            // Check if the number of guests is less than 50
            if (booking.NumberOfGuests < 50)
            {
                ModelState.AddModelError("NumberOfGuests", "The number of guests must be at least 50.");
            }

            // Check if the event date is less than 7 days away
            if (booking.EventDate.HasValue && (booking.EventDate.Value - DateTime.Now).TotalDays < 7)
            {
                ModelState.AddModelError("EventDate", "The event date must be at least 7 days from today.");
            }

            if (ModelState.IsValid)
            {
                var userIdStringValue = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStringValue, out int userId))
                {
                    booking.UserId = userId;
                    // The status is already set to "Pending" by default in the model
                    await bookingService.CreateBookingAsync(booking);
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    ModelState.AddModelError("", "There was an error getting the User ID.");
                }
            }

            // Repopulate ViewData for dropdowns in case of an error
            var caterers = await catererService.GetAllCaterersAsync();
            ViewBag.Caterers = new SelectList(caterers, "Id", "Name", booking.CatererId);

            return View(booking);
        }


        [HttpPost]
        [Route("updatestatus/{id}")]
        public async Task<IActionResult> UpdateStatus(int id, bool confirmed)
        {
            var booking = await db.Bookings.FindAsync(id);
            if (booking != null)
            {
                booking.Status = confirmed ? "Confirmed" : "Pending";
                await db.SaveChangesAsync();
                return Json(new { success = true, status = booking.Status });
            }
            return Json(new { success = false });
        }
    }
}