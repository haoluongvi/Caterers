using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Customer.Controllers
{
	[Authorize(Roles = "Customer")]
	[Area("Customer")]
	[Route("customer/dashboard")]
	public class DashBoardController : Controller
	{
		[Route("")]
		[Route("index")]
		public IActionResult Index()
		{
			return View();
		}
	}
}
