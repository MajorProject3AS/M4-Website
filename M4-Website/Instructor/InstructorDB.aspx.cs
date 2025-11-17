using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class InstructorDB : System.Web.UI.Page
    {
        public string InstructorName;
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
            string username = HttpContext.Current.User.Identity.Name;
              InstructorName = GetStaffIdByUsername(username);   
                Hlbl.Text= "Welcome " + InstructorName;
            if (!IsPostBack && Session["CurrentControl"] == null)
            {
                Session["CurrentControl"] = "~/Instructor/Dash.ascx";
                
                Response.Redirect(Request.RawUrl);
            
            }
        }
        private string GetStaffIdByUsername(string username)
        {
            //int InstructorId = -1;
            string FirstName = " ";
            string connStr = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT FirstName FROM InstructorMJ WHERE Email = @Username", con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                     FirstName = Convert.ToString(result);
                }
            }

            return FirstName;
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
            Response.Redirect("~/Default.aspx"); 
       
        }
    }
}