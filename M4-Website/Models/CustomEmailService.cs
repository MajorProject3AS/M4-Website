using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace M4_Website.Models
{
    public static class CustomEmailService
    {
        /// <summary>
        /// Sends a payment receipt email to the student
        /// </summary>
        /// <param name="studentEmail">Student's email address</param>
        /// <param name="studentName">Student's full name</param>
        /// <param name="studentId">Student ID</param>
        /// <param name="packageName">Package name</param>
        /// <param name="amountPaid">Amount paid</param>
        /// <param name="paymentMethod">Payment method used</param>
        /// <param name="paymentDate">Date of payment</param>
        /// <param name="paymentId">Payment ID for reference</param>
        /// <returns>True if email sent successfully, false otherwise</returns>
        public static bool SendPaymentReceipt(
            string studentEmail, 
            string studentName, 
            int studentId, 
            string packageName, 
            decimal amountPaid, 
            string paymentMethod, 
            DateTime paymentDate,
            int paymentId)
        {
            try
            {
                // Email configuration
                string smtpHost = ConfigurationManager.AppSettings["SmtpHost"] ?? "smtp.gmail.com";
                int smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"] ?? "587");
                string smtpUsername = ConfigurationManager.AppSettings["SmtpUsername"] ?? "";
                string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"] ?? "";
                string fromEmail = ConfigurationManager.AppSettings["FromEmail"] ?? smtpUsername;
                string fromName = ConfigurationManager.AppSettings["FromName"] ?? "TLG Driving School";
                bool enableSsl = bool.Parse(ConfigurationManager.AppSettings["SmtpEnableSsl"] ?? "true");

                // Create email message
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, fromName);
                mail.To.Add(studentEmail);
                mail.Subject = $"Payment Receipt - TLG Driving School (Ref: {paymentId})";
                mail.IsBodyHtml = true;

                // Create email body
                StringBuilder emailBody = new StringBuilder();
                emailBody.AppendLine("<!DOCTYPE html>");
                emailBody.AppendLine("<html>");
                emailBody.AppendLine("<head>");
                emailBody.AppendLine("<style>");
                emailBody.AppendLine("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }");
                emailBody.AppendLine(".container { max-width: 600px; margin: 0 auto; padding: 20px; }");
                emailBody.AppendLine(".header { background-color: #007bff; color: white; padding: 20px; text-align: center; }");
                emailBody.AppendLine(".content { background-color: #f9f9f9; padding: 20px; border: 1px solid #ddd; }");
                emailBody.AppendLine(".receipt-table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
                emailBody.AppendLine(".receipt-table td { padding: 10px; border-bottom: 1px solid #ddd; }");
                emailBody.AppendLine(".receipt-table td:first-child { font-weight: bold; width: 40%; }");
                emailBody.AppendLine(".total-row { background-color: #007bff; color: white; font-size: 1.2em; }");
                emailBody.AppendLine(".footer { text-align: center; margin-top: 20px; padding: 10px; font-size: 0.9em; color: #666; }");
                emailBody.AppendLine("</style>");
                emailBody.AppendLine("</head>");
                emailBody.AppendLine("<body>");
                emailBody.AppendLine("<div class='container'>");
                
                // Header
                emailBody.AppendLine("<div class='header'>");
                emailBody.AppendLine("<h1>TLG Driving School</h1>");
                emailBody.AppendLine("<h2>Payment Receipt</h2>");
                emailBody.AppendLine("</div>");
                
                // Content
                emailBody.AppendLine("<div class='content'>");
                emailBody.AppendLine($"<p>Dear {studentName},</p>");
                emailBody.AppendLine("<p>Thank you for your payment. This email confirms that we have successfully received your payment.</p>");
                
                // Receipt details table
                emailBody.AppendLine("<table class='receipt-table'>");
                emailBody.AppendLine($"<tr><td>Receipt Number:</td><td>#{paymentId:D6}</td></tr>");
                emailBody.AppendLine($"<tr><td>Student ID:</td><td>STU{studentId}</td></tr>");
                emailBody.AppendLine($"<tr><td>Student Name:</td><td>{studentName}</td></tr>");
                emailBody.AppendLine($"<tr><td>Package:</td><td>{packageName}</td></tr>");
                emailBody.AppendLine($"<tr><td>Payment Method:</td><td>{paymentMethod}</td></tr>");
                emailBody.AppendLine($"<tr><td>Payment Date:</td><td>{paymentDate:dddd, MMMM dd, yyyy HH:mm}</td></tr>");
                emailBody.AppendLine($"<tr class='total-row'><td>Amount Paid:</td><td>R{amountPaid:N2}</td></tr>");
                emailBody.AppendLine("</table>");
                
                // Next steps
                emailBody.AppendLine("<h3>What's Next?</h3>");
                emailBody.AppendLine("<p>Your account is now active! You can now:</p>");
                emailBody.AppendLine("<ul>");
                emailBody.AppendLine("<li>Book your driving lessons through the student portal</li>");
                emailBody.AppendLine("<li>View your lesson schedule</li>");
                emailBody.AppendLine("<li>Track your progress</li>");
                emailBody.AppendLine("</ul>");
                
                // Contact information
                emailBody.AppendLine("<h3>Contact Us</h3>");
                emailBody.AppendLine("<p>If you have any questions about your payment or need assistance, please contact us:</p>");
                emailBody.AppendLine("<ul>");
                emailBody.AppendLine("<li><strong>Email:</strong> info@tlgdrivingschool.co.za</li>");
                emailBody.AppendLine("<li><strong>Phone:</strong> +27 XX XXX XXXX</li>");
                emailBody.AppendLine("<li><strong>Address:</strong> TLG Driving School, South Africa</li>");
                emailBody.AppendLine("</ul>");
                
                emailBody.AppendLine("<p>Thank you for choosing TLG Driving School!</p>");
                emailBody.AppendLine("<p>Best regards,<br/>TLG Driving School Team</p>");
                emailBody.AppendLine("</div>");
                
                // Footer
                emailBody.AppendLine("<div class='footer'>");
                emailBody.AppendLine("<p>This is an automated email. Please do not reply to this message.</p>");
                emailBody.AppendLine($"<p>&copy; {DateTime.Now.Year} TLG Driving School. All rights reserved.</p>");
                emailBody.AppendLine("</div>");
                
                emailBody.AppendLine("</div>");
                emailBody.AppendLine("</body>");
                emailBody.AppendLine("</html>");

                mail.Body = emailBody.ToString();

                // Configure SMTP client
                SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = enableSsl;

                // Send email
                smtp.Send(mail);
                
                return true;
            }
            catch (Exception ex)
            {
                // Log the error (you might want to add proper logging here)
                System.Diagnostics.Debug.WriteLine($"Error sending email: {ex.Message}");
                return false;
            }
        }
    }
}
