using Caterers.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;

namespace Caterers.Security
{
    public class SecurityManager
    {
        public void SignIn(HttpContext httpContext, UserTable userTable, IList<string> roles)
        {
            var claims = new List<Claim>
    {
        new Claim(ClaimTypes.NameIdentifier, userTable.Id.ToString()),
        new Claim(ClaimTypes.Name, userTable.Username)
    };

            // Add a claim for each role
            foreach (var role in roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role));
            }

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var authProperties = new AuthenticationProperties
            {
                // Set additional properties as needed
            };

            httpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity),
                authProperties).Wait();
        }

        public async void SignOut(HttpContext httpContext)
        {
            await httpContext.SignOutAsync();
        }

        private IEnumerable<Claim>? getUserClaims(UserTable userTable)
        {
            List<Claim> claims = new List<Claim>();
            claims.Add(new Claim(ClaimTypes.Name, userTable.Username)); ;
            userTable.RoleUsers.ToList().ForEach(ra =>
            {
                claims.Add(new Claim(ClaimTypes.Role, ra.Role.Name));
            });
            return claims;
        }
    }
}
