using Caterers.Models;
using Caterers.Services;
using Microsoft.AspNetCore.Mvc;

namespace Caterers.Controllers
{
    [Route("cart")]
    public class CartController : Controller
    {
        private readonly ICartService _cartService;

        public CartController(ICartService cartService)
        {
            _cartService = cartService;
        }

        [Route("")]
        [Route("index")]

        public IActionResult Index()
        {
            var cartItems = _cartService.GetCartItems();
            return View(cartItems);
        }

        [HttpPost]
        [Route("AddToCart")]
        public IActionResult AddToCart(int menuItemId, string title, decimal price)
        {
            var cartItem = new CartItem
            {
                MenuItemId = menuItemId,
                Title = title,
                Price = price,
                Quantity = 1
            };
            _cartService.AddToCart(cartItem);
            return RedirectToAction("Index");
        }

        [HttpPost]
        [Route("RemoveFromCart")]
        public IActionResult RemoveFromCart(int menuItemId)
        {
            _cartService.RemoveFromCart(menuItemId);
            return RedirectToAction("Index");
        }

        [HttpGet("checkout")]
        public IActionResult Checkout()
        {
            return View();
        }

        [HttpPost("process-checkout")]
        public IActionResult ProcessCheckout(/* parameters matching your form inputs */)
        {
            // Process the checkout information here
            // Save order, process payment, etc.

            // Redirect to a confirmation page or display a success message
            return RedirectToAction("OrderConfirmation");
        }
    }
}