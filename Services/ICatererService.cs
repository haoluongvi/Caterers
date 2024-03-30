using Caterers.Models;

namespace Caterers.Services
{
    public interface ICatererService
    {
        Task<IEnumerable<Caterer>> GetAllCaterersAsync();
        Task<IEnumerable<Category>> GetAllCategoriesAsync();
        Task<Caterer> GetCatererByIdAsync(int id);
        Task<int> CreateCatererAsync(Caterer caterer);
        Task<int> UpdateCatererAsync(Caterer caterer);
        Task<int> DeleteCatererAsync(int id);

    }
}
