using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Security.Principal;

namespace M4_Website
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // Handle Forms Authentication for role-based access
            if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (HttpContext.Current.User.Identity is FormsIdentity)
                {
                    FormsIdentity identity = (FormsIdentity)HttpContext.Current.User.Identity;
                    FormsAuthenticationTicket ticket = identity.Ticket;

                    // Get the roles from the ticket
                    string[] roles = ticket.UserData.Split(',');

                    // Create a GenericPrincipal with the roles
                    HttpContext.Current.User = new GenericPrincipal(identity, roles);
                }
            }
        }
    }
}