using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.AspNet.Identity;
using M4_Website.Models;

namespace M4_Website.Booking
{
    public partial class BookPackage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in and auto-fill email
                if (User.Identity.IsAuthenticated)
                {
                    string userEmail = User.Identity.Name;
                    
                    // Check if student has incomplete lessons before allowing new package booking
                    if (HasIncompletePackage(userEmail))
                    {
                        string script = @"
                            alert('You cannot book another package until you complete all lessons in your current package.\n\nPlease complete your ongoing lessons first.');
                            window.location.href = '/Student/Dashboard.aspx';
                        ";
                        ClientScript.RegisterStartupScript(this.GetType(), "IncompleteLessons", script, true);
                        return;
                    }
                    
                    txtEmail.Text = userEmail;
                    txtEmail.Enabled = false; // Grey out the email field
                    txtEmail.CssClass = "form-control bg-light"; // Add grey background
                }

                // Get package details from query string
                string packageName = Request.QueryString["package"];
                string packageCode = Request.QueryString["code"];
                string packagePrice = Request.QueryString["price"];

                // Display package details
                if (!string.IsNullOrEmpty(packageName))
                {
                    lblPackageName.Text = packageName;
                }
                else
                {
                    lblPackageName.Text = "Princess's Package - 25 Lessons";
                }

                if (!string.IsNullOrEmpty(packageCode))
                {
                    lblPackageCode.Text = packageCode;
                }
                else
                {
                    lblPackageCode.Text = "CODE 10 - Light Truck";
                }

                if (!string.IsNullOrEmpty(packagePrice))
                {
                    lblPackagePrice.Text = packagePrice;
                }
                else
                {
                    lblPackagePrice.Text = "R3000.00";
                }

                // Set default status to New for first-time students
                ddlStatus.SelectedValue = "New";
            }
        }

        private bool HasIncompletePackage(string email)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get student's current package info
                    string query = "SELECT StudentID, PackageName, Status FROM StudentMJ WHERE Email = @Email";
                    int studentId = 0;
                    string packageName = "";
                    string studentStatus = "";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                studentId = Convert.ToInt32(reader["StudentID"]);
                                packageName = reader["PackageName"]?.ToString().ToUpper() ?? "";
                                studentStatus = reader["Status"]?.ToString() ?? "";
                            }
                            else
                            {
                                // No existing student record - allow booking
                                return false;
                            }
                        }
                    }

                    // If student status is "New", they haven't started yet - allow booking
                    if (studentStatus.Equals("New", StringComparison.OrdinalIgnoreCase))
                    {
                        return false;
                    }

                    // Determine total lessons based on package
                    int totalLessons = GetTotalLessonsForPackage(packageName);

                    if (totalLessons == 0)
                    {
                        // Unknown package or no package - allow booking
                        return false;
                    }

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

                    // Check if there are incomplete lessons
                    if (completedLessons < totalLessons)
                    {
                        return true; // Has incomplete lessons - block new booking
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error but allow booking to prevent blocking legitimate users
                System.Diagnostics.Debug.WriteLine("Error checking incomplete package: " + ex.Message);
                return false;
            }

            return false; // All lessons completed - allow new booking
        }

        private int GetTotalLessonsForPackage(string packageName)
        {
            if (string.IsNullOrEmpty(packageName))
                return 0;

            packageName = packageName.ToUpper();

            if (packageName.Contains("STEWARD"))
                return 10;
            else if (packageName.Contains("PRINCE"))
                return 15;
            else if (packageName.Contains("ROYALTY"))
                return 20;
            else if (packageName.Contains("FULL") || packageName.Contains("PRINCESS"))
                return 25;

            return 0;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Get form data
                    string name = txtName.Text.Trim();
                    string surname = txtSurname.Text.Trim();
                    string email = txtEmail.Text.Trim();
                    string phoneNumber = txtPhoneNumber.Text.Trim();
                    string idNo = txtIDNo.Text.Trim();
                    string gender = ddlGender.SelectedValue;
                    string streetNumber = txtStreetNumber.Text.Trim();
                    string streetName = txtStreetName.Text.Trim();
                    string city = txtCity.Text.Trim();
                    string postalCode = txtPostalCode.Text.Trim();
                    string status = ddlStatus.SelectedValue;
                    string packageName = lblPackageName.Text;

                    // Validate student data
                    var validationErrors = ValidationHelper.ValidateStudentData(
                        name, surname, email, phoneNumber, idNo, postalCode
                    );

                    if (validationErrors.Count > 0)
                    {
                        // Show validation errors
                        string errorMessage = "Please correct the following errors:\\n\\n" + 
                                            string.Join("\\n", validationErrors);
                        ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", 
                            $"alert('{errorMessage}');", true);
                        return;
                    }

                    // Trim package name - remove everything after the dash and convert to uppercase
                    int dashIndex = packageName.IndexOf(" -");
                    if (dashIndex > 0)
                    {
                        packageName = packageName.Substring(0, dashIndex).Trim().ToUpper();
                    }
                    else
                    {
                        packageName = packageName.Trim().ToUpper();
                    }

                    // Save to database
                    string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;
                    int newStudentId = 0;
                    
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"INSERT INTO StudentMJ 
                                        (Name, Surname, Email, PhoneNumber, IDNo, Gender, StreetNumber, StreetName, City, PostalCode, Status, PackageName) 
                                        VALUES 
                                        (@Name, @Surname, @Email, @PhoneNumber, @IDNo, @Gender, @StreetNumber, @StreetName, @City, @PostalCode, @Status, @PackageName);
                                        SELECT CAST(SCOPE_IDENTITY() as int)";
                        
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Surname", surname);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                            cmd.Parameters.AddWithValue("@IDNo", idNo);
                            cmd.Parameters.AddWithValue("@Gender", gender);
                            cmd.Parameters.AddWithValue("@StreetNumber", streetNumber);
                            cmd.Parameters.AddWithValue("@StreetName", streetName);
                            cmd.Parameters.AddWithValue("@City", city);
                            cmd.Parameters.AddWithValue("@PostalCode", postalCode);
                            cmd.Parameters.AddWithValue("@Status", status);
                            cmd.Parameters.AddWithValue("@PackageName", packageName);

                            conn.Open();
                            newStudentId = (int)cmd.ExecuteScalar();
                        }
                    }

                    // Store StudentID in session for payment page
                    Session["LastStudentID"] = newStudentId;

                    // Clear form
                    ClearForm();

                    // Show confirmation dialog and redirect to payment
                    string script = @"
                        if (confirm('Thank you! Your booking has been submitted successfully.\n\nWould you like to proceed to payment now?')) {
                            window.location.href = '/Payment/Payment.aspx';
                        } else {
                            window.location.href = '/Courses.aspx';
                        }
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "PaymentConfirmation", script, true);
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred while processing your booking. Please try again.";
                    lblMessage.CssClass = "alert alert-danger mt-3";
                    // Log the error
                    System.Diagnostics.Debug.WriteLine("Booking Error: " + ex.Message);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Courses.aspx");
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtSurname.Text = "";
            txtEmail.Text = "";
            txtPhoneNumber.Text = "";
            txtIDNo.Text = "";
            ddlGender.SelectedIndex = 0;
            txtStreetNumber.Text = "";
            txtStreetName.Text = "";
            txtCity.Text = "";
            txtPostalCode.Text = "";
        }
    }
}
