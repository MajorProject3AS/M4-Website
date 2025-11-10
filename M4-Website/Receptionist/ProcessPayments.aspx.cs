using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace M4_Website.Receptionist
{
    public partial class ProcessPayments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPayments();
            }
        }

        private void LoadPayments()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            p.PaymentID,
                            p.StudentID,
                            s.Name + ' ' + s.Surname AS StudentName,
                            s.Email,
                            s.PhoneNumber,
                            s.PackageName,
                            p.AmountPaid,
                            p.PaymentMethod,
                            p.PaymentDate,
                            p.Status
                        FROM PaymentMJ p
                        INNER JOIN StudentMJ s ON p.StudentID = s.StudentID
                        WHERE 1=1";

                    // Apply status filter
                    string statusFilter = ddlStatusFilter.SelectedValue;
                    if (statusFilter != "All")
                    {
                        query += " AND p.Status = @Status";
                    }

                    // Apply search filter
                    string searchText = txtSearchStudent.Text.Trim();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        query += " AND (s.Name LIKE @SearchText OR s.Surname LIKE @SearchText OR s.Email LIKE @SearchText)";
                    }

                    query += " ORDER BY p.PaymentDate DESC";

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

                        gvPayments.DataSource = dt;
                        gvPayments.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading payments: " + ex.Message, "danger");
            }
        }

        protected string GetStatusColor(string status)
        {
            switch (status)
            {
                case "Paid":
                    return "success";
                case "Processing":
                    return "warning";
                case "Rejected":
                    return "danger";
                default:
                    return "secondary";
            }
        }

        protected void gvPayments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int paymentId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ApprovePayment")
            {
                UpdatePaymentStatus(paymentId, "Paid");
                ShowMessage("Payment approved successfully!", "success");
                LoadPayments();
            }
            else if (e.CommandName == "RejectPayment")
            {
                UpdatePaymentStatus(paymentId, "Rejected");
                ShowMessage("Payment rejected.", "warning");
                LoadPayments();
            }
            else if (e.CommandName == "ViewDetails")
            {
                ShowPaymentDetails(paymentId);
            }
        }

        private void UpdatePaymentStatus(int paymentId, string status)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Update payment status
                    string updateQuery = "UPDATE PaymentMJ SET Status = @Status WHERE PaymentID = @PaymentID";
                    
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@PaymentID", paymentId);
                        cmd.ExecuteNonQuery();
                    }

                    // If approved, update student status to Active
                    if (status == "Paid")
                    {
                        string getStudentQuery = "SELECT StudentID FROM PaymentMJ WHERE PaymentID = @PaymentID";
                        int studentId = 0;

                        using (SqlCommand cmd = new SqlCommand(getStudentQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@PaymentID", paymentId);
                            studentId = (int)cmd.ExecuteScalar();
                        }

                        string updateStudentQuery = "UPDATE StudentMJ SET Status = 'Active' WHERE StudentID = @StudentID";
                        using (SqlCommand cmd = new SqlCommand(updateStudentQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@StudentID", studentId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating payment status: " + ex.Message, "danger");
            }
        }

        private void ShowPaymentDetails(int paymentId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            p.PaymentID,
                            s.Name + ' ' + s.Surname AS StudentName,
                            s.Email,
                            s.PhoneNumber,
                            s.PackageName,
                            p.AmountPaid,
                            p.PaymentMethod,
                            p.PaymentDate,
                            p.Status
                        FROM PaymentMJ p
                        INNER JOIN StudentMJ s ON p.StudentID = s.StudentID
                        WHERE p.PaymentID = @PaymentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PaymentID", paymentId);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblDetailPaymentID.Text = reader["PaymentID"].ToString();
                                lblDetailStudentName.Text = reader["StudentName"].ToString();
                                lblDetailEmail.Text = reader["Email"].ToString();
                                lblDetailPhone.Text = reader["PhoneNumber"].ToString();
                                lblDetailPackage.Text = reader["PackageName"].ToString();
                                lblDetailAmount.Text = "R" + Convert.ToDecimal(reader["AmountPaid"]).ToString("N2");
                                lblDetailMethod.Text = reader["PaymentMethod"].ToString();
                                lblDetailDate.Text = Convert.ToDateTime(reader["PaymentDate"]).ToString("yyyy-MM-dd HH:mm");
                                lblDetailStatus.Text = reader["Status"].ToString();

                                pnlPaymentDetails.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading payment details: " + ex.Message, "danger");
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlPaymentDetails.Visible = false;
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPayments();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPayments();
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
