using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Microsoft.AspNet.Identity;

namespace M4_Website.Booking
{
    public partial class BookLesson : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in (authenticated)
                if (User.Identity.IsAuthenticated)
                {
                    // Get the email from the logged-in user
                    string userEmail = User.Identity.Name; // This typically contains the email
                    
                    // Retrieve student ID using email
                    int? studentId = GetStudentIdByEmail(userEmail);
                    
                    if (studentId.HasValue)
                    {
                        Session["StudentID"] = studentId.Value;
                        LoadStudentInfo(studentId.Value);
                    }
                    else
                    {
                        // User is logged in but not a student yet - redirect to package booking
                        string script = @"
                            if (confirm('No student record found for your account.\n\nWould you like to book a package now?')) {
                                window.location.href = '/Courses.aspx';
                            } else {
                                window.location.href = '/Default.aspx';
                            }
                        ";
                        ClientScript.RegisterStartupScript(this.GetType(), "NoStudentRecord", script, true);
                    }
                }
                else if (Session["StudentID"] != null)
                {
                    // Check session
                    int studentId = Convert.ToInt32(Session["StudentID"]);
                    LoadStudentInfo(studentId);
                }
                else
                {
                    // Show login panel
                    pnlLogin.Visible = true;
                    pnlStudentInfo.Visible = false;
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
                System.Diagnostics.Debug.WriteLine("Error getting student ID: " + ex.Message);
            }

            return null;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtStudentIDLogin.Text))
            {
                if (int.TryParse(txtStudentIDLogin.Text, out int studentId))
                {
                    Session["StudentID"] = studentId;
                    LoadStudentInfo(studentId);
                }
                else
                {
                    lblLoginMessage.Text = "Invalid Student ID format.";
                    lblLoginMessage.CssClass = "alert alert-danger";
                }
            }
            else
            {
                lblLoginMessage.Text = "Please enter your Student ID.";
                lblLoginMessage.CssClass = "alert alert-warning";
            }
        }

        private void LoadStudentInfo(int studentId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check if student exists and get their info including payment status
                    string query = @"SELECT s.StudentID, s.Name, s.Surname, s.PackageName,
                                    p.PaymentID, p.Status as PaymentStatus
                                    FROM StudentMJ s
                                    LEFT JOIN PaymentMJ p ON s.StudentID = p.StudentID
                                    WHERE s.StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                bool hasPayment = reader["PaymentID"] != DBNull.Value;
                                string paymentStatus = hasPayment ? reader["PaymentStatus"].ToString() : "";

                                if (!hasPayment)
                                {
                                    // Student hasn't paid, ask if they want to pay
                                    string script = @"
                                        if (confirm('You have not paid for your package yet.\n\nWould you like to proceed to payment now?')) {
                                            window.location.href = '/Payment/Payment.aspx?studentId=" + studentId + @"';
                                        } else {
                                            window.location.href = '/Default.aspx';
                                        }
                                    ";
                                    ClientScript.RegisterStartupScript(this.GetType(), "PaymentPrompt", script, true);
                                    pnlLogin.Visible = true;
                                    pnlStudentInfo.Visible = false;
                                    return;
                                }
                                else if (paymentStatus != "Paid")
                                {
                                    // Payment is still processing
                                    string script = @"
                                        alert('Your payment is currently being processed.\n\nStatus: " + paymentStatus + @"\n\nYou will be able to book lessons once your payment has been confirmed by our receptionist.\n\nPlease check back later or contact us for more information.');
                                        window.location.href = '/Default.aspx';
                                    ";
                                    ClientScript.RegisterStartupScript(this.GetType(), "PaymentProcessing", script, true);
                                    pnlLogin.Visible = true;
                                    pnlStudentInfo.Visible = false;
                                    return;
                                }
                                else
                                {
                                    // Payment is confirmed as Paid, show booking form
                                    hfStudentID.Value = reader["StudentID"].ToString();
                                    lblStudentName.Text = reader["Name"].ToString() + " " + reader["Surname"].ToString();
                                    lblPackage.Text = reader["PackageName"].ToString();
                                    lblPaymentStatus.Text = "<span class='badge bg-success'>Paid</span>";

                                    pnlLogin.Visible = false;
                                    pnlStudentInfo.Visible = true;

                                    // Load time slots
                                    LoadTimeSlots();

                                    // Store student ID in ViewState
                                    ViewState["StudentID"] = studentId;
                                }
                            }
                            else
                            {
                                lblLoginMessage.Text = "Student ID not found. Please check your ID or complete the booking process first.";
                                lblLoginMessage.CssClass = "alert alert-danger";
                                pnlLogin.Visible = true;
                                pnlStudentInfo.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblLoginMessage.Text = "Error loading student information: " + ex.Message;
                lblLoginMessage.CssClass = "alert alert-danger";
            }
        }

        private void LoadTimeSlots()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT TimeSlotID, StartTime, EndTime FROM TimeSlotMJ ORDER BY StartTime";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        ddlTimeSlot.Items.Clear();
                        ddlTimeSlot.Items.Add(new ListItem("-- Select Time Slot --", ""));

                        while (reader.Read())
                        {
                            string timeSlotId = reader["TimeSlotID"].ToString();
                            TimeSpan startTime = (TimeSpan)reader["StartTime"];
                            TimeSpan endTime = (TimeSpan)reader["EndTime"];
                            string display = startTime.ToString(@"hh\:mm") + " - " + endTime.ToString(@"hh\:mm");

                            ddlTimeSlot.Items.Add(new ListItem(display, timeSlotId));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading time slots: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        protected void txtLessonDate_TextChanged(object sender, EventArgs e)
        {
            // When date changes, reload available instructors
            if (!string.IsNullOrEmpty(txtLessonDate.Text) && !string.IsNullOrEmpty(ddlTimeSlot.SelectedValue))
            {
                LoadAvailableInstructors();
            }
        }

        protected void ddlTimeSlot_SelectedIndexChanged(object sender, EventArgs e)
        {
            // When time slot changes, reload available instructors
            if (!string.IsNullOrEmpty(txtLessonDate.Text) && !string.IsNullOrEmpty(ddlTimeSlot.SelectedValue))
            {
                LoadAvailableInstructors();
            }
        }

        private void LoadAvailableInstructors()
        {
            try
            {
                if (string.IsNullOrEmpty(txtLessonDate.Text) || string.IsNullOrEmpty(ddlTimeSlot.SelectedValue))
                {
                    return;
                }

                DateTime selectedDate = DateTime.Parse(txtLessonDate.Text);
                int timeSlotId = int.Parse(ddlTimeSlot.SelectedValue);

                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Get instructors who are NOT already booked for this date and time
                    string query = @"SELECT InstructorID, FirstName, LastName
                                    FROM InstructorMJ
                                    WHERE (Status = 'Active' OR Status IS NULL)
                                    AND InstructorID NOT IN (
                                        SELECT InstructorID 
                                        FROM LessonBookingMJ 
                                        WHERE Date = @Date 
                                        AND TimeSlotID = @TimeSlotID
                                        AND Status NOT IN ('Cancelled')
                                    )
                                    ORDER BY FirstName, LastName";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Date", selectedDate);
                        cmd.Parameters.AddWithValue("@TimeSlotID", timeSlotId);

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        ddlInstructor.Items.Clear();
                        ddlInstructor.Items.Add(new ListItem("-- Select Instructor --", ""));

                        while (reader.Read())
                        {
                            string instructorId = reader["InstructorID"].ToString();
                            string fullName = reader["FirstName"].ToString() + " " + reader["LastName"].ToString();

                            ddlInstructor.Items.Add(new ListItem(fullName, instructorId));
                        }

                        // Clear any previous messages first
                        lblMessage.Text = "";
                        lblMessage.CssClass = "";

                        if (ddlInstructor.Items.Count == 1)
                        {
                            // Only the placeholder exists, no instructors available
                            lblMessage.Text = "No instructors available for the selected date and time.";
                            lblMessage.CssClass = "alert alert-warning";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading instructors: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }

        protected void cvPastDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (DateTime.TryParse(args.Value, out DateTime selectedDate))
            {
                args.IsValid = selectedDate.Date >= DateTime.Now.Date;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btnBookLesson_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    int studentId = Convert.ToInt32(ViewState["StudentID"]);
                    DateTime lessonDate = DateTime.Parse(txtLessonDate.Text);
                    int timeSlotId = int.Parse(ddlTimeSlot.SelectedValue);
                    int instructorId = int.Parse(ddlInstructor.SelectedValue);
                    string packageName = lblPackage.Text;

                    string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Get the vehicle (license plate) assigned to the selected instructor
                        string getVehicleQuery = "SELECT LicensePlateID FROM InstructorMJ WHERE InstructorID = @InstructorID";
                        string vehicleId = null;
                        using (SqlCommand vehicleCmd = new SqlCommand(getVehicleQuery, conn))
                        {
                            vehicleCmd.Parameters.AddWithValue("@InstructorID", instructorId);
                            object result = vehicleCmd.ExecuteScalar();
                            if (result != null)
                            {
                                vehicleId = result.ToString();
                            }
                        }

                        if (string.IsNullOrEmpty(vehicleId))
                        {
                            lblMessage.Text = "Selected instructor does not have a vehicle assigned.";
                            lblMessage.CssClass = "alert alert-danger";
                            return;
                        }

                        // Check if student already has a booking on this date
                        string checkStudentQuery = @"SELECT COUNT(*) FROM LessonBookingMJ 
                                                    WHERE StudentID = @StudentID 
                                                    AND Date = @Date 
                                                    AND Status NOT IN ('Cancelled')";

                        using (SqlCommand checkCmd = new SqlCommand(checkStudentQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@StudentID", studentId);
                            checkCmd.Parameters.AddWithValue("@Date", lessonDate);

                            int studentBookingCount = (int)checkCmd.ExecuteScalar();

                            if (studentBookingCount > 0)
                            {
                                cvDuplicateBooking.IsValid = false;
                                lblMessage.Text = "You already have a lesson booked on this date.";
                                lblMessage.CssClass = "alert alert-danger";
                                return;
                            }
                        }

                        // Check if instructor is already booked for this date and time
                        string checkInstructorQuery = @"SELECT COUNT(*) FROM LessonBookingMJ 
                                                       WHERE InstructorID = @InstructorID 
                                                       AND Date = @Date 
                                                       AND TimeSlotID = @TimeSlotID
                                                       AND Status NOT IN ('Cancelled')";

                        using (SqlCommand checkCmd = new SqlCommand(checkInstructorQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@InstructorID", instructorId);
                            checkCmd.Parameters.AddWithValue("@Date", lessonDate);
                            checkCmd.Parameters.AddWithValue("@TimeSlotID", timeSlotId);

                            int instructorBookingCount = (int)checkCmd.ExecuteScalar();

                            if (instructorBookingCount > 0)
                            {
                                lblMessage.Text = "This instructor is already booked for the selected date and time. Please select a different instructor or time.";
                                lblMessage.CssClass = "alert alert-danger";
                                return;
                            }
                        }

                        // Get selected time for display
                        TimeSpan selectedTime = TimeSpan.Zero;
                        string getTimeQuery = "SELECT StartTime FROM TimeSlotMJ WHERE TimeSlotID = @TimeSlotID";
                        using (SqlCommand timeCmd = new SqlCommand(getTimeQuery, conn))
                        {
                            timeCmd.Parameters.AddWithValue("@TimeSlotID", timeSlotId);
                            selectedTime = (TimeSpan)timeCmd.ExecuteScalar();
                        }

                        // Insert the booking
                        string insertQuery = @"INSERT INTO LessonBookingMJ 
                                              (StudentID, InstructorID, VehicleID, PackageID, TimeSlotID, Date, Time, Status) 
                                              VALUES 
                                              (@StudentID, @InstructorID, @VehicleID, @PackageID, @TimeSlotID, @Date, @Time, @Status)";

                        using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@StudentID", studentId);
                            cmd.Parameters.AddWithValue("@InstructorID", instructorId);
                            cmd.Parameters.AddWithValue("@VehicleID", vehicleId);
                            cmd.Parameters.AddWithValue("@PackageID", packageName);
                            cmd.Parameters.AddWithValue("@TimeSlotID", timeSlotId);
                            cmd.Parameters.AddWithValue("@Date", lessonDate);
                            cmd.Parameters.AddWithValue("@Time", selectedTime);
                            cmd.Parameters.AddWithValue("@Status", "Confirmed");

                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Show success message
                    string instructorName = ddlInstructor.SelectedItem.Text;
                    string timeSlot = ddlTimeSlot.SelectedItem.Text;
                    string script = @"
                        alert('Lesson booked successfully!\n\nDate: " + lessonDate.ToString("yyyy-MM-dd") + @"\nTime: " + timeSlot + @"\nInstructor: " + instructorName + @"\n\nYou will receive a confirmation shortly.');
                        window.location.href = '/Default.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "BookingSuccess", script, true);
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error booking lesson: " + ex.Message;
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
