using Caterers.Models;

namespace Caterers.Areas.Admin.ViewModels
{
    public class AssignRoleViewModel
    {
        public int UserId { get; set; }
        public IEnumerable<Role> Roles { get; set; } = new List<Role>();
        public IEnumerable<int> AssignedRoles { get; set; }
        public IEnumerable<int> SelectedRoles { get; set; }
    }
}
