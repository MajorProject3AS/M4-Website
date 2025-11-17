//using System;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using Microsoft.AspNet.Identity;
//using Microsoft.AspNet.Identity.Owin;
//using Owin;
//using M4_Website.Models;

//namespace M4_Website.Account
//{
//    public partial class ResetPassword : Page
//    {
//        protected string StatusMessage
//        {
//            get;
//            private set;
//        }

//        protected void Reset_Click(object sender, EventArgs e)
//        {
//            string code = IdentityHelper.GetCodeFromRequest(Request);
//            if (code != null)
//            {
//                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

//                var user = manager.FindByName(Email.Text);
//                if (user == null)
//                {
//                    ErrorMessage.Text = "No user found";
//                    return;
//                }
//                var result = manager.ResetPassword(user.Id, code, Password.Text);
//                if (result.Succeeded)
//                {
//                    Response.Redirect("~/Account/ResetPasswordConfirmation");
//                    return;
//                }
//                ErrorMessage.Text = result.Errors.FirstOrDefault();
//                return;
//            }

//            ErrorMessage.Text = "An error has occurred";
//        }
//    }
//}


using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using M4_Website.Models;

namespace M4_Website.Account
{
    public partial class ResetPassword : Page
    {
        protected void Reset_Click(object sender, EventArgs e)
        {
            string code = Request.QueryString["code"];
            string userId = Request.QueryString["userId"];

            if (code == null || userId == null)
            {
                ErrorMessage.Text = "Invalid password reset link.";
                return;
            }

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var result = manager.ResetPassword(userId, code, Password.Text);

            if (result.Succeeded)
            {
                Response.Redirect("~/Account/ResetPasswordConfirmation.aspx");
            }
            else
            {
                ErrorMessage.Text = "The reset link is invalid or expired.";
            }
        }

    }
}