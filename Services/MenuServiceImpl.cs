using Caterers.Models;

public class MenuServiceImpl : IMenuService
{
	private readonly DatabaseContext _db;

	public MenuServiceImpl(DatabaseContext db)
	{
		_db = db;
	}

	public IEnumerable<Menu> GetMenus()
	{
		return _db.Menus.ToList();
	}

	public Menu GetMenuById(int menuId)
	{
		return _db.Menus.FirstOrDefault(menu => menu.Id == menuId);
	}

	public void AddMenu(Menu menu)
	{
		_db.Menus.Add(menu);
		_db.SaveChanges();
	}

	public void UpdateMenu(Menu menu)
	{
		//_db.Menus.Update(menu);
		//_db.SaveChanges();
		try
		{
			_db.Entry(menu).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
			_db.SaveChanges();
		}
		catch (Exception)
		{

			throw;
		}
	}


	public IEnumerable<Caterer> GetAllCaterers()
	{
		return _db.Caterers.ToList();
	}

	public bool Delete(int id)
	{
		_db.Menus.Remove(GetMenuById(id));
		return _db.SaveChanges() > 0;

	}

	public IEnumerable<Menu> GetCatererMenu(int catererId)
	{
		return _db.Menus.Where(m => m.CatererId == catererId && m.Status.HasValue && m.Status.Value).ToList();
	}
}