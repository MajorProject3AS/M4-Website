using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using M4_Website.Models;

namespace M4_Website.Student
{
    public partial class MyProgress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    LoadProgressComments();
                }
                else
                {
                    Response.Redirect("~/Account/Login");
                }
            }
        }

        private int? GetStudentIdByEmail(string email)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT StudentID FROM StudentMJ WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            return Convert.ToInt32(result);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error retrieving student information: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }

            return null;
        }

        private void LoadProgressComments()
        {
            try
            {
                string email = User.Identity.Name;
                int? studentId = GetStudentIdByEmail(email);

                if (!studentId.HasValue)
                {
                    lblMessage.Text = "No student record found. Please complete your registration.";
                    lblMessage.CssClass = "alert alert-warning";
                    lblMessage.Visible = true;
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Query to get student progress records
                    string query = @"SELECT 
                                        StudentName,
                                        StudentSurname,
                                        PreTripChecks,
                                        VehicleControl,
                                        SpeedNGearControl,
                                        ObservationalNDefensive,
                                        ControlledIntersections,
                                        UncontrolledIntersections,
                                        HillStartsNGradientControl,
                                        ParkingNReversing,
                                        LaneChangingNOvertaking,
                                        FreewayDriving,
                                        MockTest,
                                        Comments
                                    FROM StudentProgress
                                    WHERE StudentID = @StudentID
                                    ORDER BY StudentID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId.Value);
                        
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Combine StudentName and StudentSurname into one column
                        if (dt.Rows.Count > 0)
                        {
                            dt.Columns.Add("StudentFullName", typeof(string));
                            foreach (DataRow row in dt.Rows)
                            {
                                row["StudentFullName"] = row["StudentName"].ToString() + " " + row["StudentSurname"].ToString();
                            }
                            dt.Columns.Remove("StudentSurname");
                            dt.Columns["StudentFullName"].SetOrdinal(0);
                            dt.Columns["StudentFullName"].ColumnName = "StudentName";
                        }

                        gvProgressComments.DataSource = dt;
                        gvProgressComments.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading progress comments: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }
    }
}
