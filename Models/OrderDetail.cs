using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class OrderDetail
{
    public int Id { get; set; }

    public int? OrderId { get; set; }

    public int? MenuId { get; set; }

    public int? Quantity { get; set; }

    public double? Price { get; set; }

    public virtual Menu? Menu { get; set; }

    public virtual Order? Order { get; set; }
}
