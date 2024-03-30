using Caterers.Models;
using Caterers.Security;
using Caterers.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews();

// Configure the database context with lazy loading
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<DatabaseContext>(options =>
    options.UseLazyLoadingProxies().UseSqlServer(connectionString));

// Configure cookie authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        // Set a default login path
        options.LoginPath = "/account/login";
        options.LogoutPath = "/account/logout";
        options.AccessDeniedPath = "/account/accessdenied";

        // Handle redirection for login dynamically based on the area
        options.Events.OnRedirectToLogin = context =>
        {
            var requestPath = context.Request.Path;
            if (requestPath.StartsWithSegments("/admin"))
            {
                context.RedirectUri = "/admin/login/Index";
            }
            else if (requestPath.StartsWithSegments("/caterer"))
            {
                context.RedirectUri = "/caterer/login/Index";
            }
            else if (requestPath.StartsWithSegments("/customer"))
            {
                context.RedirectUri = "/customer/login/Index";
            }

            context.Response.Redirect(context.RedirectUri);
            return Task.CompletedTask;
        };
    });
builder.Services.AddSession();

// Register services
builder.Services.AddScoped<SecurityManager>();
builder.Services.AddScoped<ICategoryService, CategoryServiceImpl>();
builder.Services.AddScoped<ICatererService, CatererServiceImpl>();
builder.Services.AddScoped<IMenuService, MenuServiceImpl>();
builder.Services.AddScoped<IBookingService, BookingServiceImpl>();
builder.Services.AddScoped<IMessageService, MessageServiceImpl>();
builder.Services.AddScoped<ISearchCatererService, SearchCatererServiceImpl>();
builder.Services.AddScoped<IAccountService, AccountServiceImpl>();
builder.Services.AddScoped<IRoleService, RoleServiceImpl>();
builder.Services.AddScoped<IEmailService, EmailServiceImpl>();
builder.Services.AddScoped<ICartService, CartServiceImpl>();

// Register IHttpContextAccessor
builder.Services.AddHttpContextAccessor();
builder.Services.AddControllers().AddNewtonsoftJson();

var app = builder.Build();

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseSession();
app.UseAuthentication(); // Ensure authentication middleware is called
app.UseAuthorization();

// Define routes
app.MapControllerRoute(
    name: "Admin",
    pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}"
);
app.MapControllerRoute(
    name: "Caterering",
    pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}"
);
app.MapControllerRoute(
    name: "Customer",
    pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}"
);

app.Run();