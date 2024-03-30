using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class Category
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Caterer> Caterers { get; set; } = new List<Caterer>();
}
