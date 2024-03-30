using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
	public class CatererServiceImpl : ICatererService
	{
		private readonly DatabaseContext db;

		public CatererServiceImpl(DatabaseContext _db)
		{
			db = _db;
		}

		public async Task<IEnumerable<Caterer>> GetAllCaterersAsync()
		{
			return await db.Caterers.ToListAsync();
		}

		public async Task<IEnumerable<Category>> GetAllCategoriesAsync()
		{
			return await db.Categories.ToListAsync();
		}

		public async Task<Caterer> GetCatererByIdAsync(int id)
		{
			return await db.Caterers.FindAsync(id);
		}

		//public async Task<IEnumerable<Caterer>> SearchCaterersAsync(string location, string foodType, int numberOfPeople)
		//{
		//    // Implement search logic based on location, foodType, and numberOfPeople
		//    // Return matching caterers
		//}

		public async Task<int> CreateCatererAsync(Caterer caterer)
		{
			db.Caterers.Add(caterer);
			return await db.SaveChangesAsync();
		}

		public async Task<int> UpdateCatererAsync(Caterer caterer)
		{
			db.Entry(caterer).State = EntityState.Modified;
			return await db.SaveChangesAsync();
		}

		public async Task<int> DeleteCatererAsync(int id)
		{
			var caterer = await db.Caterers.FindAsync(id);
			db.Caterers.Remove(caterer);
			return await db.SaveChangesAsync();
		}

	}
}
