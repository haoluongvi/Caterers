using System;
using System.Collections.Generic;

namespace Caterers.Models;

public partial class Order
{
    public int Id { get; set; }

    public int? UserId { get; set; }

    public int? CatererId { get; set; }

    public double? Total { get; set; }

    public string? PaymentMethod { get; set; }

    public string? PaymentStatus { get; set; }

    public string? OrderStatus { get; set; }

    public DateTime? Created { get; set; }

    public int? BookingId { get; set; }

    public virtual Booking? Booking { get; set; }

    public virtual Caterer? Caterer { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual UserTable? User { get; set; }
}
