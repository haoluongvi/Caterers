using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class PasswordResetToken
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public string Token { get; set; } = null!;

    public DateTime ExpiryDate { get; set; }

    public virtual UserTable User { get; set; } = null!;
}
