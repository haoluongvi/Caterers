using Caterers.Models;

namespace Caterers.Services
{
    public interface IBookingService
    {
        Task<IEnumerable<dynamic>> GetBookingDetailsAsync();
        Task CreateBookingAsync(Booking booking);
    }
}