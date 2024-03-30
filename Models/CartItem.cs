namespace Caterers.Models
{
    [Serializable] // Needed for storing in session
    public class CartItem
    {
        public int MenuItemId { get; set; }
        public string Title { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
    }
}