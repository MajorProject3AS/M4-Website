using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class Dash : System.Web.UI.UserControl
    {
        //string username = HttpContext.Current.User.Identity.Name;
        public int InstructorId;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
                string username = HttpContext.Current.User.Identity.Name;
                InstructorId = GetStaffIdByUsername(username);
                //Label1.Text = InstructorId.ToString();
                Session["InstructorID"] = InstructorId; // Store for later use
            


            string instructorID = InstructorId.ToString() ;
            if (string.IsNullOrEmpty(instructorID)) return;

            BindTodaySummary(instructorID);
            BindMonthlySummary(instructorID);
            BindStudentSummary(instructorID);
            DSBookings.SelectParameters["instructorId"].DefaultValue = instructorID;
        }

        private int GetStaffIdByUsername(string username)
        {
            int InstructorId = -1;
            string connStr = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT InstructorID FROM InstructorMJ WHERE Email = @Username", con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    InstructorId = Convert.ToInt32(result);
                }
            }

            return InstructorId;
        }

        private void BindTodaySummary(string instructorID)
        {
            string query = @"
        SELECT COUNT(*) AS BookingsToday
        FROM LessonBookingMJ
        WHERE CAST(Date AS DATE) = CAST(GETDATE() AS DATE)
        AND InstructorID = @InstructorID";

            DetailsViewToday.DataSource = GetSummary(query, instructorID);
            DetailsViewToday.DataBind();
        }

        private void BindMonthlySummary(string instructorID)
        {
            string query = @"
        SELECT 
            COUNT(*) AS BookingsThisMonth
        FROM LessonBookingMJ
        WHERE MONTH(Date) = MONTH(GETDATE())
        AND YEAR(Date) = YEAR(GETDATE())
        AND InstructorID = @InstructorID";

            DetailsViewMonthly.DataSource = GetSummary(query, instructorID);
            DetailsViewMonthly.DataBind();
        }

        private void BindStudentSummary(string instructorID)
        {
            string query = @"
        SELECT COUNT(DISTINCT StudentID) AS TotalStudents
        FROM LessonBookingMJ
        WHERE InstructorID = @InstructorID";

            DetailsViewStudents.DataSource = GetSummary(query, instructorID);
            DetailsViewStudents.DataBind();
        }

        private DataTable GetSummary(string query, string instructorID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InstructorID", instructorID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

    }
}