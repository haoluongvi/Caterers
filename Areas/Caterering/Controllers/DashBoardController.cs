using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Caterering.Controllers
{
	[Authorize(Roles = "Caterer")]
	[Area("Caterering")]
	[Route("caterer/dashboard")]
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
