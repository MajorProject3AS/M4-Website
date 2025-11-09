using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.AspNet.Identity;

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
