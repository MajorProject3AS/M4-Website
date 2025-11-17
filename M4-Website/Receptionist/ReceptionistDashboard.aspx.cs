using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace M4_Website.Receptionist
{
    public partial class ReceptionistDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("=== ReceptionistDashboard Page_Load ===");
            System.Diagnostics.Debug.WriteLine($"User.Identity.IsAuthenticated: {User.Identity.IsAuthenticated}");
            System.Diagnostics.Debug.WriteLine($"User.Identity.Name: {User.Identity.Name}");
            
            if (User.Identity.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine($"User is in Receptionist role: {User.IsInRole("Receptionist")}");
            }
            
            if (!IsPostBack)
            {
                LoadDashboardStats();
                LoadRecentActivity();
            }
        }

        private void LoadDashboardStats()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Pending Payments (Bank Transfer only - Credit Card is auto-processed)
                    string pendingPaymentsQuery = "SELECT COUNT(*) FROM PaymentMJ WHERE Status = 'Processing' AND PaymentMethod = 'Bank Transfer'";
                    using (SqlCommand cmd = new SqlCommand(pendingPaymentsQuery, conn))
                    {
                        lblPendingPayments.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Today's Bookings
                    string todayBookingsQuery = @"SELECT COUNT(*) FROM LessonBookingMJ 
                                                 WHERE CONVERT(date, Date) = CONVERT(date, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(todayBookingsQuery, conn))
                    {
                        lblTodayBookings.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Active Students
                    string activeStudentsQuery = "SELECT COUNT(*) FROM StudentMJ WHERE Status = 'Active'";
                    using (SqlCommand cmd = new SqlCommand(activeStudentsQuery, conn))
                    {
                        lblActiveStudents.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Total Bookings
                    string totalBookingsQuery = "SELECT COUNT(*) FROM LessonBookingMJ WHERE Status != 'Cancelled'";
                    using (SqlCommand cmd = new SqlCommand(totalBookingsQuery, conn))
                    {
                        lblTotalBookings.Text = cmd.ExecuteScalar().ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading statistics: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

        private void LoadRecentActivity()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT TOP 10 
                            ActivityDate,
                            ActivityType,
                            StudentName,
                            Details,
                            Status
                        FROM (
                            SELECT 
                                CAST(p.PaymentDate as DATETIME2) as ActivityDate,
                                'Payment' as ActivityType,
                                s.Name + ' ' + s.Surname as StudentName,
                                'Amount: R' + CAST(p.AmountPaid as VARCHAR) as Details,
                                p.Status as Status
                            FROM PaymentMJ p
                            INNER JOIN StudentMJ s ON p.StudentID = s.StudentID
                            
                            UNION ALL
                            
                            SELECT 
                                CAST(lb.Date as DATETIME2) as ActivityDate,
                                'Booking' as ActivityType,
                                s.Name + ' ' + s.Surname as StudentName,
                                'Lesson with ' + i.FirstName + ' ' + i.LastName as Details,
                                lb.Status as Status
                            FROM LessonBookingMJ lb
                            INNER JOIN StudentMJ s ON lb.StudentID = s.StudentID
                            INNER JOIN InstructorMJ i ON lb.InstructorID = i.InstructorID
                        ) AS RecentActivity
                        ORDER BY ActivityDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvRecentActivity.DataSource = dt;
                        gvRecentActivity.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading recent activity: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

        protected void btnGoToPayments_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Receptionist/ProcessPayments.aspx");
        }

        protected void btnGoToBookings_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Receptionist/ManageBookings.aspx");
        }

        protected void btnGoToStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Receptionist/ManageStudents.aspx");
        }
    }
}
