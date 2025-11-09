using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace M4_Website.Student
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    LoadStudentData();
                    LoadBookings();
                    LoadPackageProgress();
                    LoadPaymentInfo();
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
            }

            return null;
        }

        private void LoadStudentData()
        {
            try
            {
                string email = User.Identity.Name;
                int? studentId = GetStudentIdByEmail(email);

                if (!studentId.HasValue)
                {
                    lblMessage.Text = "No student record found. Please complete your registration.";
                    lblMessage.CssClass = "alert alert-warning";
                    btnEdit.Visible = false; // Disable edit button when no record found
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT StudentID, Name, Surname, Email, PhoneNumber, IDNo, Gender, 
                                    StreetNumber, StreetName, City, PostalCode, PackageName, Status
                                    FROM StudentMJ WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId.Value);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Store StudentID in ViewState
                                ViewState["StudentID"] = reader["StudentID"];

                                // Display data
                                lblName.Text = reader["Name"].ToString();
                                lblSurname.Text = reader["Surname"].ToString();
                                lblEmail.Text = reader["Email"].ToString();
                                lblPhone.Text = reader["PhoneNumber"].ToString();
                                lblIDNo.Text = reader["IDNo"].ToString();
                                lblGender.Text = reader["Gender"].ToString();
                                
                                string address = reader["StreetNumber"].ToString() + " " + 
                                                reader["StreetName"].ToString() + ", " + 
                                                reader["City"].ToString() + ", " + 
                                                reader["PostalCode"].ToString();
                                lblAddress.Text = address;
                                
                                lblPackage.Text = reader["PackageName"].ToString();
                                lblStatus.Text = reader["Status"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading student data: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        private void LoadBookings()
        {
            try
            {
                if (ViewState["StudentID"] == null) return;

                int studentId = Convert.ToInt32(ViewState["StudentID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT 
                                        lb.BookingID,
                                        lb.Date,
                                        lb.Time,
                                        lb.VehicleID,
                                        lb.Status,
                                        i.FirstName + ' ' + i.LastName AS InstructorName
                                    FROM LessonBookingMJ lb
                                    INNER JOIN InstructorMJ i ON lb.InstructorID = i.InstructorID
                                    WHERE lb.StudentID = @StudentID
                                    ORDER BY lb.Date DESC, lb.Time DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        
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
                lblMessage.Text = "Error loading bookings: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        private void LoadPackageProgress()
        {
            try
            {
                if (ViewState["StudentID"] == null) return;

                int studentId = Convert.ToInt32(ViewState["StudentID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get package name and determine total lessons
                    string packageQuery = "SELECT PackageName FROM StudentMJ WHERE StudentID = @StudentID";
                    string packageName = "";
                    
                    using (SqlCommand cmd = new SqlCommand(packageQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            packageName = result.ToString().ToUpper();
                        }
                    }

                    // Determine total lessons based on package
                    int totalLessons = 0;
                    if (packageName.Contains("STEWARD"))
                        totalLessons = 10;
                    else if (packageName.Contains("PRINCE"))
                        totalLessons = 15;
                    else if (packageName.Contains("ROYALTY"))
                        totalLessons = 20;
                    else if (packageName.Contains("FULL"))
                        totalLessons = 25;

                    // Count completed lessons
                    string completedQuery = @"SELECT COUNT(*) FROM LessonBookingMJ 
                                            WHERE StudentID = @StudentID 
                                            AND Status IN ('Completed', 'Confirmed')";
                    
                    int completedLessons = 0;
                    using (SqlCommand cmd = new SqlCommand(completedQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        completedLessons = (int)cmd.ExecuteScalar();
                    }

                    int remainingLessons = totalLessons - completedLessons;
                    if (remainingLessons < 0) remainingLessons = 0;

                    // Update labels
                    lblTotalLessons.Text = totalLessons.ToString();
                    lblCompletedLessons.Text = completedLessons.ToString();
                    lblRemainingLessons.Text = remainingLessons.ToString();

                    // Calculate progress percentage
                    int progressPercent = totalLessons > 0 ? (completedLessons * 100) / totalLessons : 0;
                    progressBar.Style["width"] = progressPercent + "%";
                    lblProgress.Text = progressPercent + "%";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading package progress: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        private void LoadPaymentInfo()
        {
            try
            {
                if (ViewState["StudentID"] == null) return;

                int studentId = Convert.ToInt32(ViewState["StudentID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT PaymentMethod, AmountPaid, PaymentDate
                                    FROM PaymentMJ 
                                    WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblPaymentMethod.Text = reader["PaymentMethod"].ToString();
                                lblAmountPaid.Text = reader["AmountPaid"].ToString();
                                lblPaymentDate.Text = Convert.ToDateTime(reader["PaymentDate"]).ToString("yyyy-MM-dd");
                                lblPaymentStatus.Text = "<span class='badge bg-success'>Paid</span>";
                            }
                            else
                            {
                                lblPaymentMethod.Text = "N/A";
                                lblAmountPaid.Text = "0.00";
                                lblPaymentDate.Text = "N/A";
                                lblPaymentStatus.Text = "<span class='badge bg-warning'>Not Paid</span>";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading payment information: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            // Populate edit fields
            txtName.Text = lblName.Text;
            txtSurname.Text = lblSurname.Text;
            txtPhone.Text = lblPhone.Text;
            ddlGender.SelectedValue = lblGender.Text;

            // Parse address
            string[] addressParts = lblAddress.Text.Split(',');
            if (addressParts.Length >= 3)
            {
                string[] streetParts = addressParts[0].Trim().Split(' ');
                if (streetParts.Length >= 2)
                {
                    txtStreetNumber.Text = streetParts[0];
                    txtStreetName.Text = string.Join(" ", streetParts, 1, streetParts.Length - 1);
                }
                txtCity.Text = addressParts[1].Trim();
                txtPostalCode.Text = addressParts[2].Trim();
            }

            pnlView.Visible = false;
            pnlEdit.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["StudentID"] == null) return;

                int studentId = Convert.ToInt32(ViewState["StudentID"]);
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE StudentMJ SET 
                                    Name = @Name,
                                    Surname = @Surname,
                                    PhoneNumber = @PhoneNumber,
                                    Gender = @Gender,
                                    StreetNumber = @StreetNumber,
                                    StreetName = @StreetName,
                                    City = @City,
                                    PostalCode = @PostalCode
                                    WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Surname", txtSurname.Text);
                        cmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text);
                        cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                        cmd.Parameters.AddWithValue("@StreetNumber", txtStreetNumber.Text);
                        cmd.Parameters.AddWithValue("@StreetName", txtStreetName.Text);
                        cmd.Parameters.AddWithValue("@City", txtCity.Text);
                        cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text);
                        cmd.Parameters.AddWithValue("@StudentID", studentId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Information updated successfully!";
                lblMessage.CssClass = "alert alert-success";

                pnlEdit.Visible = false;
                pnlView.Visible = true;
                LoadStudentData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating information: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
            pnlView.Visible = true;
            lblMessage.Text = "";
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelBooking")
            {
                try
                {
                    int bookingId = Convert.ToInt32(e.CommandArgument);
                    string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE LessonBookingMJ SET Status = 'Cancelled' WHERE BookingID = @BookingID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@BookingID", bookingId);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblMessage.Text = "Booking cancelled successfully!";
                    lblMessage.CssClass = "alert alert-success";
                    LoadBookings();
                    LoadPackageProgress();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error cancelling booking: " + ex.Message;
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
        }

        protected bool IsBookingCancellable(object dateObj, object timeObj, string status)
        {
            // Don't show cancel button if already cancelled or completed
            if (status == "Cancelled" || status == "Completed")
            {
                return false;
            }

            // Check if date/time has passed
            try
            {
                if (dateObj != null && timeObj != null)
                {
                    DateTime bookingDate = Convert.ToDateTime(dateObj);
                    TimeSpan bookingTime = (TimeSpan)timeObj;
                    
                    // Combine date and time
                    DateTime bookingDateTime = bookingDate.Date.Add(bookingTime);
                    
                    // Check if booking date/time has passed
                    if (bookingDateTime <= DateTime.Now)
                    {
                        return false; // Cannot cancel past bookings
                    }
                }
                
                return true; // Can cancel future bookings
            }
            catch
            {
                return false; // If error, don't show cancel button
            }
        }
    }
}
