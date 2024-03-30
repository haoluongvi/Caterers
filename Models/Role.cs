using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class Role
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public bool? Status { get; set; }

    public virtual ICollection<RoleUser> RoleUsers { get; set; } = new List<RoleUser>();
}
