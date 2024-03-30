namespace Caterers.Models;

public partial class Booking
{
    public int Id { get; set; }

    public int? UserId { get; set; }

    public int? CatererId { get; set; }

    public DateTime? EventDate { get; set; }

    public int? NumberOfGuests { get; set; }

    public DateTime? BookingDate { get; set; }

    public string? Status { get; set; } = "Pending";

    public virtual Caterer? Caterer { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual UserTable? User { get; set; }
}
