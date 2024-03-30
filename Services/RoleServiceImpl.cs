using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
	public class RoleServiceImpl : IRoleService
	{
		private readonly DatabaseContext db;

		public RoleServiceImpl(DatabaseContext _db)
		{
			db = _db;
		}

		public IEnumerable<Role> GetAllRoles()
		{
			return db.Roles.ToList();
		}

		public Role GetRoleById(int id)
		{
			return db.Roles.Find(id);
		}

		public Role CreateRole(Role role)
		{
			db.Roles.Add(role);
			db.SaveChanges();
			return role;
		}

		public void UpdateRole(Role role)
		{
			db.Roles.Update(role);
			db.SaveChanges();
		}

		public void DeleteRole(int roleId)
		{
			var role = db.Roles.Find(roleId);
			if (role != null)
			{
				db.Roles.Remove(role);
				db.SaveChanges();
			}
		}

		public IEnumerable<RoleUser> GetRoleUsers(int roleId)
		{
			return db.RoleUsers
					 .Where(ru => ru.RoleId == roleId)
					 .Include(ru => ru.User) // Eager loading the User navigation property
					 .ToList();
		}

		public void AddUserToRole(int roleId, int userId)
		{
			var existingRoleUser = db.RoleUsers.FirstOrDefault(ru => ru.RoleId == roleId && ru.UserId == userId);
			if (existingRoleUser != null)
			{
				// Relationship already exists, handle accordingly (e.g., display an error message)
				return;
			}

			var roleUser = new RoleUser
			{
				RoleId = roleId,
				UserId = userId,
				Status = true
			};
			db.RoleUsers.Add(roleUser);
			db.SaveChanges();
		}

		public void RemoveUserFromRole(int roleId, int userId)
		{
			var roleUser = db.RoleUsers.FirstOrDefault(ru => ru.RoleId == roleId && ru.UserId == userId);
			if (roleUser != null)
			{
				db.RoleUsers.Remove(roleUser);
				db.SaveChanges();
			}
		}
	}
}