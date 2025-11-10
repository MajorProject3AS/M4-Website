using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace M4_Website.Receptionist
{
    public partial class ManageBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            lb.BookingID,
                            lb.Date,
                            ISNULL(CAST(lb.Time AS VARCHAR(50)), '') AS Time,
                            ISNULL(CAST(lb.VehicleID AS VARCHAR(50)), 'N/A') AS VehicleID,
                            ISNULL(lb.Status, 'Pending') AS Status,
                            ISNULL(s.Name + ' ' + s.Surname, 'Unknown') AS StudentName,
                            ISNULL(s.Email, '') AS Email,
                            ISNULL(s.PhoneNumber, '') AS PhoneNumber,
                            ISNULL(s.PackageName, 'N/A') AS PackageName,
                            ISNULL(i.FirstName + ' ' + i.LastName, 'Unknown') AS InstructorName
                        FROM LessonBookingMJ lb
                        LEFT JOIN StudentMJ s ON lb.StudentID = s.StudentID
                        LEFT JOIN InstructorMJ i ON lb.InstructorID = i.InstructorID
                        WHERE 1=1";

                    // Apply status filter
                    string statusFilter = ddlStatusFilter.SelectedValue;
                    if (statusFilter != "All")
                    {
                        query += " AND lb.Status = @Status";
                    }

                    // Apply date filter
                    string dateFilter = ddlDateFilter.SelectedValue;
                    switch (dateFilter)
                    {
                        case "Today":
                            query += " AND CONVERT(date, lb.Date) = CONVERT(date, GETDATE())";
                            break;
                        case "Tomorrow":
                            query += " AND CONVERT(date, lb.Date) = CONVERT(date, DATEADD(day, 1, GETDATE()))";
                            break;
                        case "Week":
                            query += " AND lb.Date >= CONVERT(date, GETDATE()) AND lb.Date < CONVERT(date, DATEADD(week, 1, GETDATE()))";
                            break;
                        case "Month":
                            query += " AND MONTH(lb.Date) = MONTH(GETDATE()) AND YEAR(lb.Date) = YEAR(GETDATE())";
                            break;
                    }

                    // Apply search filter
                    string searchText = txtSearchStudent.Text.Trim();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        query += " AND (s.Name LIKE @SearchText OR s.Surname LIKE @SearchText)";
                    }

                    query += " ORDER BY lb.Date DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (statusFilter != "All")
                        {
                            cmd.Parameters.AddWithValue("@Status", statusFilter);
                        }

                        if (!string.IsNullOrEmpty(searchText))
                        {
                            cmd.Parameters.AddWithValue("@SearchText", "%" + searchText + "%");
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvBookings.DataSource = dt;
                        gvBookings.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading bookings: " + ex.Message + " | Stack: " + ex.StackTrace, "danger");
                System.Diagnostics.Debug.WriteLine("ManageBookings Error: " + ex.ToString());
            }
        }

        protected string GetStatusColor(string status)
        {
            switch (status)
            {
                case "Confirmed":
                    return "primary";
                case "Completed":
                    return "success";
                case "Cancelled":
                    return "danger";
                default:
                    return "secondary";
            }
        }

        protected bool IsBookingDatePassed(object bookingDate)
        {
            try
            {
                if (bookingDate == null || bookingDate == DBNull.Value)
                    return false;

                DateTime date = Convert.ToDateTime(bookingDate);
                DateTime today = DateTime.Today;

                // Return true if booking date is today or in the past
                return date.Date <= today;
            }
            catch
            {
                return false;
            }
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "CompleteBooking")
            {
                UpdateBookingStatus(bookingId, "Completed");
                ShowMessage("Booking marked as completed successfully!", "success");
                LoadBookings();
            }
            else if (e.CommandName == "CancelBooking")
            {
                UpdateBookingStatus(bookingId, "Cancelled");
                ShowMessage("Booking cancelled.", "warning");
                LoadBookings();
            }
            else if (e.CommandName == "ViewDetails")
            {
                ShowBookingDetails(bookingId);
            }
        }

        private void UpdateBookingStatus(int bookingId, string status)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string updateQuery = "UPDATE LessonBookingMJ SET Status = @Status WHERE BookingID = @BookingID";
                    
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@BookingID", bookingId);
                        
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating booking status: " + ex.Message, "danger");
            }
        }

        private void ShowBookingDetails(int bookingId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            lb.BookingID,
                            lb.Date,
                            lb.Time,
                            lb.VehicleID,
                            lb.Status,
                            s.Name + ' ' + s.Surname AS StudentName,
                            s.Email,
                            s.PhoneNumber,
                            s.PackageName,
                            i.FirstName + ' ' + i.LastName AS InstructorName
                        FROM LessonBookingMJ lb
                        INNER JOIN StudentMJ s ON lb.StudentID = s.StudentID
                        INNER JOIN InstructorMJ i ON lb.InstructorID = i.InstructorID
                        WHERE lb.BookingID = @BookingID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BookingID", bookingId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblDetailBookingID.Text = reader["BookingID"].ToString();
                                lblDetailDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                                lblDetailTime.Text = reader["Time"].ToString();
                                lblDetailStatus.Text = reader["Status"].ToString();
                                lblDetailVehicle.Text = reader["VehicleID"].ToString();
                                lblDetailStudentName.Text = reader["StudentName"].ToString();
                                lblDetailEmail.Text = reader["Email"].ToString();
                                lblDetailPhone.Text = reader["PhoneNumber"].ToString();
                                lblDetailPackage.Text = reader["PackageName"].ToString();
                                lblDetailInstructor.Text = reader["InstructorName"].ToString();

                                pnlBookingDetails.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading booking details: " + ex.Message, "danger");
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlBookingDetails.Visible = false;
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadBookings();
        }

        protected void ddlDateFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadBookings();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadBookings();
        }

        protected void btnBackToDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Receptionist/ReceptionistDashboard.aspx");
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-" + type;
            lblMessage.Visible = true;
        }
    }
}
