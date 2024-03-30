using Caterers.Models;

public interface IMenuService
{
    IEnumerable<Menu> GetMenus();
    IEnumerable<Caterer> GetAllCaterers();
    Menu GetMenuById(int menuId);
    void AddMenu(Menu menu);
    void UpdateMenu(Menu menu);
    public bool Delete(int id);

    IEnumerable<Menu> GetCatererMenu(int catererId);


}