namespace Caterers.Helpers
{
	public class FileHelper
	{
		public static string generateFileName(string fileName)
		{
			int lastIndex = fileName.LastIndexOf('.');
			string ext = fileName.Substring(lastIndex);
			return Guid.NewGuid().ToString().Replace("-", "") + ext;
		}
	}
}
