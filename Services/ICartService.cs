using Caterers.Models;

namespace Caterers.Services
{
    public interface ICartService
    {
        void AddToCart(CartItem item);
        void RemoveFromCart(int menuItemId);
        IEnumerable<CartItem> GetCartItems();
        void ClearCart();
        decimal GetTotalPrice();
    }
}