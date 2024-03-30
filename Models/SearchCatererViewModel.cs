namespace Caterers.Models
{
	public class SearchCatererViewModel
	{
		// Include properties for search criteria
		public string Address { get; set; }
		public int? CategoryId { get; set; }
		public int? MinimumGuestCount { get; set; }

		// Include collections for dropdowns
		public IEnumerable<string> Addresses { get; set; }
		public IEnumerable<Category> Categories { get; set; }

		// Search results
		public IEnumerable<Caterer> Caterers { get; set; }

		// Indicates whether a search has been performed
		public bool SearchPerformed { get; set; }
	}
}