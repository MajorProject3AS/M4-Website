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
        public int InstructorId = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
           

            string instructorID = InstructorId.ToString() ;
            if (string.IsNullOrEmpty(instructorID)) return;

            BindTodaySummary(instructorID);
            BindMonthlySummary(instructorID);
            BindStudentSummary(instructorID);
            DSBookings.SelectParameters["instructorId"].DefaultValue = instructorID;
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