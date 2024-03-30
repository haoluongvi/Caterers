using Caterers.Models;

namespace Caterers.Services
{
    public interface IRoleService
    {
        IEnumerable<Role> GetAllRoles();
        Role GetRoleById(int id);
        Role CreateRole(Role role);
        void UpdateRole(Role role);
        void DeleteRole(int roleId);
        IEnumerable<RoleUser> GetRoleUsers(int roleId);
        void AddUserToRole(int roleId, int userId);
        void RemoveUserFromRole(int roleId, int userId);
    }
}