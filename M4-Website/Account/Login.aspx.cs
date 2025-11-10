using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using M4_Website.Models;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Security.Claims;

namespace M4_Website.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            //ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    string username = Email.Text.Trim();
                    string password = Password.Text.Trim();

                    // First, check if this is a receptionist login
                    if (AuthenticateReceptionist(username, password))
                    {
                        System.Diagnostics.Debug.WriteLine("Receptionist authenticated successfully, setting up Forms Authentication...");
                        
                        // Create forms authentication ticket with Receptionist role
                        FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                            1,
                            username,
                            DateTime.Now,
                            DateTime.Now.AddMinutes(30),
                            RememberMe.Checked,
                            "Receptionist",
                            FormsAuthentication.FormsCookiePath
                        );

                        string encryptedTicket = FormsAuthentication.Encrypt(ticket);
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        
                        if (RememberMe.Checked)
                        {
                            authCookie.Expires = DateTime.Now.AddDays(30);
                        }
                        
                        Response.Cookies.Add(authCookie);
                        
                        System.Diagnostics.Debug.WriteLine($"Cookie '{FormsAuthentication.FormsCookieName}' added to response");
                        System.Diagnostics.Debug.WriteLine($"Redirecting to ~/Receptionist/ReceptionistDashboard.aspx");

                        // Use Server.Transfer or direct redirect
                        string redirectUrl = ResolveUrl("~/Receptionist/ReceptionistDashboard.aspx");
                        System.Diagnostics.Debug.WriteLine($"Resolved URL: {redirectUrl}");
                        
                        Response.Redirect(redirectUrl, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }

                    // If not a receptionist, proceed with normal ASP.NET Identity authentication
                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                    // This doen't count login failures towards account lockout
                    // To enable password failures to trigger lockout, change to shouldLockout: true
                    var result = signinManager.PasswordSignIn(username, password, RememberMe.Checked, shouldLockout: false);

                    switch (result)
                    {
                        case SignInStatus.Success:
                            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                            break;
                        case SignInStatus.LockedOut:
                            Response.Redirect("/Account/Lockout");
                            break;
                        case SignInStatus.RequiresVerification:
                            Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}", 
                                                            Request.QueryString["ReturnUrl"],
                                                            RememberMe.Checked),
                                              true);
                            break;
                        case SignInStatus.Failure:
                        default:
                            FailureText.Text = "Invalid login attempt. Please check your email and password.";
                            ErrorMessage.Visible = true;
                            break;
                    }
                }
                catch (Exception ex)
                {
                    FailureText.Text = "An error occurred during login: " + ex.Message;
                    ErrorMessage.Visible = true;
                    System.Diagnostics.Debug.WriteLine("Login error: " + ex.ToString());
                }
            }
        }

        private bool AuthenticateReceptionist(string username, string password)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // First, let's check if the table exists and what data is in it
                    string checkQuery = "SELECT Username FROM RECPTLOGINmj";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        using (SqlDataReader reader = checkCmd.ExecuteReader())
                        {
                            System.Diagnostics.Debug.WriteLine("=== RECPTLOGINmj Table Contents ===");
                            while (reader.Read())
                            {
                                System.Diagnostics.Debug.WriteLine("Username in DB: " + reader["Username"].ToString());
                            }
                        }
                    }
                    
                    // Now try authentication
                    string query = "SELECT COUNT(*) FROM RECPTLOGINmj WHERE Username = @Username AND Password = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        int count = (int)cmd.ExecuteScalar();

                        System.Diagnostics.Debug.WriteLine($"Receptionist auth check for '{username}' with password '{password}': Found {count} matches");
                        
                        if (count == 0)
                        {
                            // Try to find just by username to see if password is the issue
                            string usernameOnlyQuery = "SELECT Password FROM RECPTLOGINmj WHERE Username = @Username";
                            using (SqlCommand userCmd = new SqlCommand(usernameOnlyQuery, conn))
                            {
                                userCmd.Parameters.AddWithValue("@Username", username);
                                object dbPassword = userCmd.ExecuteScalar();
                                if (dbPassword != null)
                                {
                                    System.Diagnostics.Debug.WriteLine($"Username found but password mismatch. Expected: '{dbPassword}', Provided: '{password}'");
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"Username '{username}' not found in database");
                                }
                            }
                        }
                        
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Receptionist authentication error: " + ex.ToString());
                // Show error to user for debugging
                FailureText.Text = "Database connection error: " + ex.Message;
                ErrorMessage.Visible = true;
                return false;
            }
        }
    }
}