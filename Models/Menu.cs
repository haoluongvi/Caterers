using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class Menu
{
    public int Id { get; set; }

    public int? CatererId { get; set; }

    public string? Title { get; set; }

    public string? Description { get; set; }

    public double? Price { get; set; }

    public string? Image { get; set; }

    public bool? Status { get; set; }

    public virtual Caterer? Caterer { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
