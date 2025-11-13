using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class InstructorDB : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["CurrentControl"] != null)
            {
                string controlPath = Session["CurrentControl"].ToString();
                LoadUserControl(controlPath);

            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["CurrentControl"] == null)
            {
                Session["CurrentControl"] = "~/Instructor/Dash.ascx";
                
                Response.Redirect(Request.RawUrl);
            }
        }

        

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Session["CurrentControl"] = "~/Instructor/Dash.ascx";
           
            Response.Redirect(Request.RawUrl);

        }

        protected void btnAttendance_Click(object sender, EventArgs e)
        {
            
            Session["CurrentControl"] = "~/Instructor/Attendance.ascx";
            
            Response.Redirect(Request.RawUrl);


        }

        protected void btnProgress_Click(object sender, EventArgs e)
        {
            
            Session["CurrentControl"] = "~/Instructor/StudentProgress.ascx";
           
            Response.Redirect(Request.RawUrl);


        }
        private void LoadUserControl(string controlPath)
        {
            pnlMain.Controls.Clear();

            Control ctrl = LoadControl(controlPath);
            ctrl.ID = "DynamicControl"; 

            pnlMain.Controls.Add(ctrl);

           
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            
            Session.Clear(); 
            Session.Abandon(); 
            Response.Redirect("~/Default.aspx"); /
       
    }
    }
}