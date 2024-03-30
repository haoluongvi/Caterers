using Caterers.Models;

namespace Caterers.Services
{
    public interface ISearchCatererService
    {
        IEnumerable<Caterer> SearchCaterers(string address, int? categoryId, int? minimumGuestCount);
        Caterer GetCatererDetails(int catererId);
        IEnumerable<Category> GetCategories(); // Add this method signature

        IEnumerable<Category> GetCategoriesByAddress(string address);

        IEnumerable<string> GetAddresses();

        Task<IEnumerable<Menu>> GetCatererMenu(int catererId);
    }
}