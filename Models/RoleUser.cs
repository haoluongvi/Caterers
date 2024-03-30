using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class RoleUser
{
    public int RoleId { get; set; }

    public int UserId { get; set; }

    public bool? Status { get; set; }

    public virtual Role Role { get; set; } = null!;

    public virtual UserTable User { get; set; } = null!;
}
