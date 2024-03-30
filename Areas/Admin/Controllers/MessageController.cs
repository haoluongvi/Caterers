using Caterers.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Areas.Admin.Controllers
{
	[Authorize(Roles = "Admin")]
	[Area("admin")]
	[Route("admin/message")]
	public class MessageController : Controller
	{
		private readonly IMessageService _messageService;

		public MessageController(IMessageService messageService)
		{
			_messageService = messageService;
		}

		// GET: Message
		[Route("")]
		[Route("index")]
		public async Task<IActionResult> Index()
		{
			return View(await _messageService.GetAllMessagesAsync());
		}

		[HttpGet]
		[Route("details/{id:int}")]
		public async Task<IActionResult> Details(int id)
		{
			var message = await _messageService.GetMessageByIdAsync(id);
			if (message == null)
			{
				return NotFound();
			}
			return View(message);
		}

		[Route("delete/{id}")]
		public async Task<IActionResult> Delete(int id)
		{
			await _messageService.DeleteMessageAsync(id);
			return RedirectToAction("Index");
		}
	}
}
