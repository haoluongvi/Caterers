using Caterers.Models;

namespace Caterers.Services
{
	public class CategoryServiceImpl : ICategoryService
	{
		private readonly DatabaseContext db;

		public CategoryServiceImpl(DatabaseContext _db)
		{
			db = _db;
		}

		public IEnumerable<Category> GetAllCategories()
		{
			return db.Categories;
		}

		public Category GetCategoryById(int id)
		{
			return db.Categories.Find(id);
		}

		public void AddCategory(Category category)
		{
			db.Categories.Add(category);
			db.SaveChanges();
		}

		public void UpdateCategory(Category category)
		{
			db.Categories.Update(category);
			db.SaveChanges();
		}

		public void DeleteCategory(int id)
		{
			var category = GetCategoryById(id);
			if (category != null)
			{
				db.Categories.Remove(category);
				db.SaveChanges();
			}
		}
	}
}