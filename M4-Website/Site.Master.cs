using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.AspNet.Identity;

namespace M4_Website
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Context.User.Identity.IsAuthenticated)
            //{
            //    PrivateManager.Visible = true;
            //}
            //if (Context.User.IsInRole("Instructor"))
            //{
            //    PrivateInstructor.Visible = true;
            //    PrivateManager.Visible = false;
            //}
            if (Context.User.Identity.IsAuthenticated)
            {
                // Reset both first
                PrivateManager.Visible = false;
                PrivateInstructor.Visible = false;
                PrivateReceptionist.Visible = false;
                StudentDashboard.Visible = false;
                // Show public pages by default for authenticated users
                HomeNavItem.Visible = true;
                CoursesNavItem.Visible = true;
                FAQNavItem.Visible = true;
                AboutNavItem.Visible = true;
                ContactNavItem.Visible = true;

                // Then set based on roles
                if (Context.User.IsInRole("Manager"))
                {
                    PrivateManager.Visible = true;
                    // Hide public pages for Manager
                    HomeNavItem.Visible = false;
                    CoursesNavItem.Visible = false;
                    FAQNavItem.Visible = false;
                    AboutNavItem.Visible = false;
                    ContactNavItem.Visible = false;
                }
                else if (Context.User.IsInRole("Instructor"))
                {
                    PrivateInstructor.Visible = true;
                    // Hide public pages for Instructor
                    HomeNavItem.Visible = false;
                    CoursesNavItem.Visible = false;
                    FAQNavItem.Visible = false;
                    AboutNavItem.Visible = false;
                    ContactNavItem.Visible = false;
                }
                else if (Context.User.IsInRole("Receptionist"))
                {
                    PrivateReceptionist.Visible = true;
                }
                else
                {
                    // Regular logged-in user (student) - show dashboard
                    StudentDashboard.Visible = true;
                }
            }
            else
            {
                PrivateManager.Visible = false;
                PrivateInstructor.Visible = false;
                PrivateReceptionist.Visible = false;
                StudentDashboard.Visible = false;
            }

            // Set active nav item based on current page
            SetActiveNavItem();
        }

        private void SetActiveNavItem()
        {
            string currentPage = Request.Url.AbsolutePath.ToLower();

            // Check for Receptionist pages
            if (currentPage.Contains("/receptionist/"))
            {
                if (PrivateReceptionist != null)
                {
                    PrivateReceptionist.Attributes["class"] = "nav-link active";
                }
            }
            // Check for Manager pages
            else if (currentPage.Contains("/manager/"))
            {
                if (PrivateManager != null)
                {
                    PrivateManager.Attributes["class"] = "nav-link active";
                }
            }
            // Check for Instructor pages
            else if (currentPage.Contains("/instructor/"))
            {
                if (PrivateInstructor != null)
                {
                    PrivateInstructor.Attributes["class"] = "nav-link active";
                }
            }
            // Check for Student pages
            else if (currentPage.Contains("/student/"))
            {
                if (StudentDashboard != null)
                {
                    StudentDashboard.Attributes["class"] = "nav-link active";
                }
            }
            // Check public pages
            else if (currentPage.EndsWith("/") || currentPage.Contains("/default"))
            {
                if (HomeNavItem != null)
                {
                    var homeLink = HomeNavItem.FindControl("HomeLink") as HtmlAnchor;
                    if (homeLink == null)
                    {
                        // Find the anchor tag within the li
                        foreach (System.Web.UI.Control ctrl in HomeNavItem.Controls)
                        {
                            if (ctrl is HtmlAnchor)
                            {
                                ((HtmlAnchor)ctrl).Attributes["class"] = "nav-link active";
                                break;
                            }
                        }
                    }
                }
            }
            else if (currentPage.Contains("/courses"))
            {
                if (CoursesNavItem != null)
                {
                    foreach (System.Web.UI.Control ctrl in CoursesNavItem.Controls)
                    {
                        if (ctrl is HtmlAnchor)
                        {
                            ((HtmlAnchor)ctrl).Attributes["class"] = "nav-link active";
                            break;
                        }
                    }
                }
            }
            else if (currentPage.Contains("/faq"))
            {
                if (FAQNavItem != null)
                {
                    foreach (System.Web.UI.Control ctrl in FAQNavItem.Controls)
                    {
                        if (ctrl is HtmlAnchor)
                        {
                            ((HtmlAnchor)ctrl).Attributes["class"] = "nav-link active";
                            break;
                        }
                    }
                }
            }
            else if (currentPage.Contains("/about"))
            {
                if (AboutNavItem != null)
                {
                    foreach (System.Web.UI.Control ctrl in AboutNavItem.Controls)
                    {
                        if (ctrl is HtmlAnchor)
                        {
                            ((HtmlAnchor)ctrl).Attributes["class"] = "nav-link active";
                            break;
                        }
                    }
                }
            }
            else if (currentPage.Contains("/contact"))
            {
                if (ContactNavItem != null)
                {
                    foreach (System.Web.UI.Control ctrl in ContactNavItem.Controls)
                    {
                        if (ctrl is HtmlAnchor)
                        {
                            ((HtmlAnchor)ctrl).Attributes["class"] = "nav-link active";
                            break;
                        }
                    }
                }
            }
        }
            

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            // Sign out from OWIN Identity
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            
            // Also sign out from Forms Authentication (for receptionist login)
            FormsAuthentication.SignOut();
            
            // Clear session
            Session.Clear();
            Session.Abandon();
        }
    }

}