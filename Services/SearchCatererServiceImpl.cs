using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
    public class SearchCatererServiceImpl : ISearchCatererService
    {
        private readonly DatabaseContext db;

        public SearchCatererServiceImpl(DatabaseContext _db)
        {
            db = _db;
        }

        public IEnumerable<Caterer> SearchCaterers(string address, int? categoryId, int? minimumGuestCount)
        {
            var query = db.Caterers.AsQueryable();

            if (!string.IsNullOrWhiteSpace(address))
            {
                query = query.Where(c => c.Address.Contains(address));
            }

            if (categoryId.HasValue)
            {
                query = query.Where(c => c.CategoryId == categoryId);
            }

            if (minimumGuestCount.HasValue)
            {
                query = query.Where(c => !c.MinimumGuestCount.HasValue || c.MinimumGuestCount <= minimumGuestCount);
            }

            // Remove or correct the following line if 'Status' is not a property of Caterer
            // query = query.Where(c => c.Status.HasValue && c.Status.Value);

            return query.ToList();
        }



        public Caterer GetCatererDetails(int catererId)
        {
            return db.Caterers.FirstOrDefault(c => c.Id == catererId);
        }

        // Implement the GetCategories method
        public IEnumerable<Category> GetCategories()
        {
            return db.Categories.ToList();
        }

        public IEnumerable<Category> GetCategoriesByAddress(string address)
        {
            return db.Caterers
        .Where(c => c.Address.Contains(address))
        .Select(c => c.Category)
        .Distinct()
        .ToList();
        }

        public IEnumerable<string> GetAddresses()
        {
            return db.Caterers.Select(c => c.Address).Distinct().ToList();
        }

        public async Task<IEnumerable<Menu>> GetCatererMenu(int catererId)
        {
            return await db.Menus
                                 .Where(m => m.CatererId == catererId)
                                 .ToListAsync();
        }
    }
}