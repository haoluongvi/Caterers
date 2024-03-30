namespace Caterers.Models
{
    public class CatererDetailsViewModel
    {
        public Caterer Caterer { get; set; }
        public IEnumerable<Menu> MenuItems { get; set; }
    }
}
