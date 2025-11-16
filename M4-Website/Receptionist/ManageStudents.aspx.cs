using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace M4_Website.Receptionist
{
    public partial class ManageStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        private void LoadStudents()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            StudentID,
                            Name,
                            Surname,
                            Email,
                            PhoneNumber,
                            IDNo,
                            Gender,
                            StreetNumber,
                            StreetName,
                            City,
                            PostalCode,
                            PackageName,
                            Status
                        FROM StudentMJ
                        WHERE 1=1";

                    // Apply status filter
                    string statusFilter = ddlStatusFilter.SelectedValue;
                    if (statusFilter != "All")
                    {
                        query += " AND Status = @Status";
                    }

                    // Apply package filter
                    string packageFilter = ddlPackageFilter.SelectedValue;
                    if (packageFilter != "All")
                    {
                        query += " AND PackageName = @Package";
                    }

                    // Apply search filter
                    string searchText = txtSearchStudent.Text.Trim();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        query += " AND (Name LIKE @SearchText OR Surname LIKE @SearchText OR Email LIKE @SearchText OR IDNo LIKE @SearchText)";
                    }

                    query += " ORDER BY StudentID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (statusFilter != "All")
                        {
                            cmd.Parameters.AddWithValue("@Status", statusFilter);
                        }

                        if (packageFilter != "All")
                        {
                            cmd.Parameters.AddWithValue("@Package", packageFilter);
                        }

                        if (!string.IsNullOrEmpty(searchText))
                        {
                            cmd.Parameters.AddWithValue("@SearchText", "%" + searchText + "%");
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvStudents.DataSource = dt;
                        gvStudents.DataBind();

                        lblTotalStudents.Text = dt.Rows.Count.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading students: " + ex.Message, "danger");
            }
        }

        protected string GetStatusColor(string status)
        {
            switch (status)
            {
                case "Active":
                    return "success";
                case "New":
                    return "info";
                case "Archived":
                    return "secondary";
                default:
                    return "secondary";
            }
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int studentId = Convert.ToInt32(e.CommandArgument);
                ShowStudentDetails(studentId);
            }
        }

        private void ShowStudentDetails(int studentId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get student details
                    string query = @"
                        SELECT 
                            StudentID,
                            Name,
                            Surname,
                            Email,
                            PhoneNumber,
                            IDNo,
                            Gender,
                            StreetNumber,
                            StreetName,
                            City,
                            PostalCode,
                            PackageName,
                            Status
                        FROM StudentMJ
                        WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblDetailStudentID.Text = "STU" + reader["StudentID"].ToString();
                                lblDetailName.Text = reader["Name"].ToString();
                                lblDetailSurname.Text = reader["Surname"].ToString();
                                lblDetailEmail.Text = reader["Email"].ToString();
                                lblDetailPhone.Text = reader["PhoneNumber"].ToString();
                                lblDetailIDNo.Text = reader["IDNo"].ToString();
                                lblDetailGender.Text = reader["Gender"].ToString();
                                
                                // Build address from street number, street name, city, and postal code
                                string address = "";
                                if (reader["StreetNumber"] != DBNull.Value && !string.IsNullOrEmpty(reader["StreetNumber"].ToString()))
                                    address += reader["StreetNumber"].ToString() + " ";
                                if (reader["StreetName"] != DBNull.Value && !string.IsNullOrEmpty(reader["StreetName"].ToString()))
                                    address += reader["StreetName"].ToString() + ", ";
                                if (reader["City"] != DBNull.Value && !string.IsNullOrEmpty(reader["City"].ToString()))
                                    address += reader["City"].ToString() + " ";
                                if (reader["PostalCode"] != DBNull.Value && !string.IsNullOrEmpty(reader["PostalCode"].ToString()))
                                    address += reader["PostalCode"].ToString();
                                
                                lblDetailAddress.Text = !string.IsNullOrEmpty(address.Trim()) ? address.Trim() : "N/A";
                                lblDetailPackage.Text = reader["PackageName"].ToString();
                                lblDetailStatus.Text = reader["Status"].ToString();
                            }
                        }
                    }

                    // Get payment statistics
                    string paymentQuery = @"
                        SELECT COUNT(*) as TotalPayments, ISNULL(SUM(AmountPaid), 0) as TotalAmount
                        FROM PaymentMJ
                        WHERE StudentID = @StudentID AND Status = 'Paid'";

                    using (SqlCommand cmd = new SqlCommand(paymentQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblDetailTotalPayments.Text = reader["TotalPayments"].ToString() + 
                                    " (R" + Convert.ToDecimal(reader["TotalAmount"]).ToString("N2") + ")";
                            }
                        }
                    }

                    // Get booking statistics
                    string bookingQuery = @"
                        SELECT 
                            COUNT(*) as TotalBookings,
                            SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) as CompletedLessons
                        FROM LessonBookingMJ
                        WHERE StudentID = @StudentID";

                    using (SqlCommand cmd = new SqlCommand(bookingQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblDetailTotalBookings.Text = reader["TotalBookings"].ToString();
                                lblDetailCompletedLessons.Text = reader["CompletedLessons"].ToString();
                            }
                        }
                    }
                }

                pnlStudentDetails.Visible = true;
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading student details: " + ex.Message, "danger");
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlStudentDetails.Visible = false;
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadStudents();
        }

        protected void ddlPackageFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadStudents();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadStudents();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            ddlStatusFilter.SelectedValue = "All";
            ddlPackageFilter.SelectedValue = "All";
            txtSearchStudent.Text = "";
            LoadStudents();
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
