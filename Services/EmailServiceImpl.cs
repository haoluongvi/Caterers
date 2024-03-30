using Caterers.Services;
using System.Net;
using System.Net.Mail;

public class EmailServiceImpl : IEmailService
{
    private readonly IConfiguration _configuration;

    public EmailServiceImpl(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public async Task SendEmailAsync(string to, string subject, string body)
    {
        var emailConfig = _configuration.GetSection("Gmail");

        using (var client = new SmtpClient(emailConfig["Host"], int.Parse(emailConfig["Port"])))
        {
            client.Credentials = new NetworkCredential(emailConfig["Username"], emailConfig["Password"]);
            client.EnableSsl = emailConfig.GetSection("SMTP:starttls")["enable"].ToLower() == "true";

            var mailMessage = new MailMessage
            {
                From = new MailAddress(emailConfig["Username"]),
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            };
            mailMessage.To.Add(to);

            try
            {
                await client.SendMailAsync(mailMessage);
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                throw ex;
            }
        }
    }
}