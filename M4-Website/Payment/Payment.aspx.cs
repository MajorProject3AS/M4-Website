using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace M4_Website.Payment
{
    public partial class Payment : System.Web.UI.Page
    {
        private int studentId;
        private decimal packagePrice;
        private string packageName;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if StudentID is in session or query string
                if (Session["LastStudentID"] != null)
                {
                    studentId = Convert.ToInt32(Session["LastStudentID"]);
                    LoadStudentPackageInfo(studentId);
                }
                else if (Request.QueryString["studentId"] != null)
                {
                    if (int.TryParse(Request.QueryString["studentId"], out studentId))
                    {
                        LoadStudentPackageInfo(studentId);
                    }
                    else
                    {
                        lblMessage.Text = "Invalid student ID.";
                        lblMessage.CssClass = "alert alert-danger";
                        btnProcessPayment.Enabled = false;
                    }
                }
                else
                {
                    lblMessage.Text = "No student information found. Please complete the booking first.";
                    lblMessage.CssClass = "alert alert-warning";
                    btnProcessPayment.Enabled = false;
                }
            }
        }

        private void LoadStudentPackageInfo(int studentId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT StudentID, PackageName FROM StudentMJ WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblStudentID.Text = reader["StudentID"].ToString();
                                packageName = reader["PackageName"].ToString();
                                lblPackageName.Text = packageName;

                                // Get package price based on package name
                                packagePrice = GetPackagePrice(packageName);

                                lblAmountToPay.Text = "R" + packagePrice.ToString("N2");
                                lblFullAmount.Text = "R" + packagePrice.ToString("N2");
                                lblConfirmAmount.Text = "R" + packagePrice.ToString("N2");

                                // Set transfer reference
                                lblTransferReference.Text = "STU" + studentId.ToString();
                                lblEmailReference.Text = "STU" + studentId.ToString();

                                // Store in ViewState
                                ViewState["StudentID"] = studentId;
                                ViewState["PackagePrice"] = packagePrice;
                                ViewState["PackageName"] = packageName;
                            }
                            else
                            {
                                lblMessage.Text = "Student information not found.";
                                lblMessage.CssClass = "alert alert-danger";
                                btnProcessPayment.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading student information: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                btnProcessPayment.Enabled = false;
            }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Hide all panels first
            pnlBankTransfer.Visible = false;
            pnlCardPayment.Visible = false;

            // Disable all card validators
            rfvCardHolderName.Enabled = false;
            rfvCardNumber.Enabled = false;
            revCardNumber.Enabled = false;
            rfvExpiryDate.Enabled = false;
            revExpiryDate.Enabled = false;
            rfvCVV.Enabled = false;
            revCVV.Enabled = false;

            string paymentMethod = ddlPaymentMethod.SelectedValue;

            if (paymentMethod == "Bank Transfer")
            {
                pnlBankTransfer.Visible = true;
            }
            else if (paymentMethod == "Credit Card" || paymentMethod == "Debit Card")
            {
                pnlCardPayment.Visible = true;
                // Enable card validators
                rfvCardHolderName.Enabled = true;
                rfvCardNumber.Enabled = true;
                revCardNumber.Enabled = true;
                rfvExpiryDate.Enabled = true;
                revExpiryDate.Enabled = true;
                rfvCVV.Enabled = true;
                revCVV.Enabled = true;
            }
        }

        private decimal GetPackagePrice(string packageName)
        {
            // Map package names to prices based on your packages
            switch (packageName.ToUpper())
            {
                case "STEWARD'S PACKAGE":
                    return 1300.00m; // CODE 08
                case "ROYALTY PACKAGE":
                    return 1700.00m; // CODE 08
                case "PRINCE'S PACKAGE":
                    return 2000.00m; // CODE 08
                case "FULL COURSE":
                    return 3200.00m; // CODE 08
                case "PRINCESS'S PACKAGE":
                    return 3000.00m; // CODE 10
                default:
                    // Try to determine by checking if it contains specific keywords
                    if (packageName.ToUpper().Contains("STEWARD"))
                        return packageName.ToUpper().Contains("CODE 10") ? 1700.00m : 1300.00m;
                    if (packageName.ToUpper().Contains("ROYALTY"))
                        return packageName.ToUpper().Contains("CODE 10") ? 2100.00m : 1700.00m;
                    if (packageName.ToUpper().Contains("PRINCE"))
                        return packageName.ToUpper().Contains("CODE 10") ? 2500.00m : 2000.00m;
                    if (packageName.ToUpper().Contains("PRINCESS"))
                        return 3000.00m;
                    if (packageName.ToUpper().Contains("FULL"))
                        return 3200.00m;
                    return 0.00m;
            }
        }

        protected void btnProcessPayment_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && chkConfirmAmount.Checked)
            {
                try
                {
                    int studentId = Convert.ToInt32(ViewState["StudentID"]);
                    decimal amountPaid = Convert.ToDecimal(ViewState["PackagePrice"]);
                    string paymentMethod = ddlPaymentMethod.SelectedValue;

                    // Additional validation for card payments
                    if ((paymentMethod == "Credit Card" || paymentMethod == "Debit Card"))
                    {
                        if (string.IsNullOrWhiteSpace(txtCardHolderName.Text) ||
                            string.IsNullOrWhiteSpace(txtCardNumber.Text) ||
                            string.IsNullOrWhiteSpace(txtExpiryDate.Text) ||
                            string.IsNullOrWhiteSpace(txtCVV.Text))
                        {
                            lblMessage.Text = "Please fill in all card details.";
                            lblMessage.CssClass = "alert alert-danger";
                            return;
                        }
                    }

                    // For bank transfer, check if proof of payment is uploaded
                    if (paymentMethod == "Bank Transfer")
                    {
                        // No upload validation needed - user will email proof of payment
                        // Payment will be pending until proof is received via email
                    }

                    // Save payment to database
                    string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Insert payment record with Status = 'Processing'
                        string query = @"INSERT INTO PaymentMJ 
                                        (PaymentDate, AmountPaid, AmountDue, PaymentMethod, StudentID, Status) 
                                        VALUES 
                                        (@PaymentDate, @AmountPaid, @AmountDue, @PaymentMethod, @StudentID, @Status)";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@PaymentDate", DateTime.Now);
                            cmd.Parameters.AddWithValue("@AmountPaid", amountPaid);
                            cmd.Parameters.AddWithValue("@AmountDue", 0.00); // Full payment, no amount due
                            cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                            cmd.Parameters.AddWithValue("@StudentID", studentId);
                            cmd.Parameters.AddWithValue("@Status", "Processing"); // Set default status to Processing

                            cmd.ExecuteNonQuery();
                        }

                        // Update student status to Active after payment submission
                        string updateStatusQuery = "UPDATE StudentMJ SET Status = 'Active' WHERE StudentID = @StudentID";
                        
                        using (SqlCommand updateCmd = new SqlCommand(updateStatusQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@StudentID", studentId);
                            updateCmd.ExecuteNonQuery();
                        }
                    }

                    // Clear session
                    Session.Remove("LastStudentID");

                    // Show success message and redirect
                    string script = @"
                        alert('Payment processed successfully!\n\nAmount Paid: R" + amountPaid.ToString("N2") + @"\nPayment Method: " + paymentMethod + @"\n\nThank you for your payment!');
                        window.location.href = '/Default.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "PaymentSuccess", script, true);
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error processing payment: " + ex.Message;
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
            else if (!chkConfirmAmount.Checked)
            {
                lblMessage.Text = "Please confirm the payment amount.";
                lblMessage.CssClass = "alert alert-warning";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.Remove("LastStudentID");
            Response.Redirect("~/Courses.aspx");
        }
    }
}
