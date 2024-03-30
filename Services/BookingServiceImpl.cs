using Caterers.Models;
using Microsoft.EntityFrameworkCore;

namespace Caterers.Services
{
	public class BookingServiceImpl : IBookingService
	{
		private readonly DatabaseContext db;

		public BookingServiceImpl(DatabaseContext _db)
		{
			db = _db;
		}

		public async Task CreateBookingAsync(Booking booking)
		{
			db.Bookings.Add(booking);
			await db.SaveChangesAsync();
		}

		public async Task<IEnumerable<dynamic>> GetBookingDetailsAsync()
		{
			var bookingDetails = await db.Bookings
				.Select(b => new
				{
					Id = b.Id,
					UserName = b.User.Name,
					UserAddress = b.User.Address,
					UserPhone = b.User.Phone,
					CatererName = b.Caterer.Name,
					EventDate = b.EventDate,
					NumberOfGuests = b.NumberOfGuests,
					BookingDate = b.BookingDate,
					Status = b.Status
				}).ToListAsync();

			return bookingDetails;
		}
	}
}