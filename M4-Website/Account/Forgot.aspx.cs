//using System;
//using System.Web;
//using System.Web.UI;
//using Microsoft.AspNet.Identity;
//using Microsoft.AspNet.Identity.Owin;
//using Owin;
//using M4_Website.Models;

//namespace M4_Website.Account
//{
//    public partial class ForgotPassword : Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//        }

//        protected void Forgot(object sender, EventArgs e)
//        {
//            if (IsValid)
//            {
//                // Validate the user's email address
//                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
//                ApplicationUser user = manager.FindByEmail(Email.Text);
//                if (user == null || !manager.IsEmailConfirmed(user.Id))
//                {
//                    FailureText.Text = "The user either does not exist or is not confirmed.";
//                    ErrorMessage.Visible = true;
//                    return;
//                }
//                // For more information on how to enable account confirmation and password reset please visit https://go.microsoft.com/fwlink/?LinkID=320771
//                // Send email with the code and the redirect to reset password page
//                string code = manager.GeneratePasswordResetToken(user.Id);
//                string callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request);
//                manager.SendEmail(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>.");
//                loginForm.Visible = false;
//                DisplayEmail.Visible = true;
//            }
//        }
//    }
//}

using M4_Website.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Diagnostics;
using System.Web;
using System.Web.UI;

namespace M4_Website.Account
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void Forgot(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    Debug.WriteLine($"=== FORGOT PASSWORD PROCESS STARTED ===");
                    Debug.WriteLine($"Email entered: {Email.Text}");

                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    ApplicationUser user = manager.FindByEmail(Email.Text);

                    if (user == null)
                    {
                        Debug.WriteLine($"❌ USER NOT FOUND for email: {Email.Text}");
                        // Don't reveal that the user doesn't exist
                        loginForm.Visible = false;
                        DisplayEmail.Visible = true;
                        return;
                    }

                    Debug.WriteLine($"✅ USER FOUND: {user.UserName} (ID: {user.Id})");

                    // Generate reset token
                    string code = manager.GeneratePasswordResetToken(user.Id);
                    Debug.WriteLine($"✅ RESET TOKEN GENERATED");

                    // Build reset URL
                    string callbackUrl = Request.Url.GetLeftPart(UriPartial.Authority)
                         + "/Account/ResetPassword.aspx?code="
                         + HttpUtility.UrlEncode(code)
                         + "&userId="
                         + HttpUtility.UrlEncode(user.Id);

                    Debug.WriteLine($"✅ RESET URL BUILT: {callbackUrl}");

                    Debug.WriteLine($"📧 ATTEMPTING TO SEND EMAIL...");

                    // Send email (correct)
                    manager.SendEmailAsync(user.Id, "Reset Password",
                        $"Please reset your password by clicking <a href='{callbackUrl}'>here</a>.").Wait();

                    Debug.WriteLine($"✅ EMAIL SENT SUCCESSFULLY");


                    // Swap UI
                    loginForm.Visible = false;
                    DisplayEmail.Visible = true;

                    Debug.WriteLine($"✅ UI UPDATED - SHOWING SUCCESS MESSAGE");

                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"❌ ERROR: {ex.Message}");
                    Debug.WriteLine($"❌ STACK TRACE: {ex.StackTrace}");

                    // Show error to user
                    FailureText.Text = $"Error: {ex.Message}";
                    ErrorMessage.Visible = true;
                }
            }
        }
    }
}
