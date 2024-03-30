using Caterers.Models;
using Newtonsoft.Json;

namespace Caterers.Services
{
    public class CartServiceImpl : ICartService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private const string CartSessionKey = "Cart";

        public CartServiceImpl(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public void AddToCart(CartItem item)
        {
            var cart = GetCartItems().ToList();
            var existingItem = cart.FirstOrDefault(i => i.MenuItemId == item.MenuItemId);
            if (existingItem != null)
            {
                existingItem.Quantity += item.Quantity;
            }
            else
            {
                cart.Add(item);
            }
            SaveCart(cart);
        }

        public void RemoveFromCart(int menuItemId)
        {
            var cart = GetCartItems().ToList();
            var item = cart.FirstOrDefault(i => i.MenuItemId == menuItemId);
            if (item != null)
            {
                cart.Remove(item);
            }
            SaveCart(cart);
        }

        public IEnumerable<CartItem> GetCartItems()
        {
            var session = _httpContextAccessor.HttpContext.Session;
            var json = session.GetString(CartSessionKey);
            return json == null ? new List<CartItem>() : JsonConvert.DeserializeObject<List<CartItem>>(json);
        }

        public void ClearCart()
        {
            _httpContextAccessor.HttpContext.Session.Remove(CartSessionKey);
        }

        public decimal GetTotalPrice()
        {
            return GetCartItems().Sum(item => item.Price * item.Quantity);
        }

        private void SaveCart(IEnumerable<CartItem> cart)
        {
            var session = _httpContextAccessor.HttpContext.Session;
            var json = JsonConvert.SerializeObject(cart);
            session.SetString(CartSessionKey, json);
        }
    }
}