using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website.Manager
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        private void BindGridView()
        {
            // Get data from your data source
           
            GVInstructorsActive.DataBind();
        }
       

        protected void UPDATEbtn_Click(object sender, EventArgs e)
        {
            string licensePlateID = GVInstructorsActive.SelectedRow.Cells[2].Text.Trim();
            int instructorID = Convert.ToInt32(GVInstructorsActive.SelectedRow.Cells[1].Text);

            string errorMessage;
            if (!ValidateVehicleAssignment(licensePlateID, instructorID, out errorMessage))
            {
                lblError.Text = errorMessage;
                return;
            }


            string connString = "Data Source=146.230.177.46;Initial Catalog=WstGrp24;User ID=WstGrp24;Password=6wefi;TrustServerCertificate=True"; // Replace with actual connection string
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = @"UPDATE InstructorsMJ SET 
                          LicensePlateID = @LicensePlateID,
                          LicenseNumber =@LicenseNumber,
                          ExpertiseLevel = @ExpertiseLevel,
                          FirstName = @FirstName,
                          LastName = @LastName,
                         Gender = @Gender,
                          ContactNumber = @ContactNumber,
                          Email = @Email,
                          Status = @Status
                       WHERE InstructorID = @InstructorID";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@LicensePlateID", GVInstructorsActive.SelectedRow.Cells[2].Text.Trim());
                    cmd.Parameters.AddWithValue("@LicenseNmber", GVInstructorsActive.SelectedRow.Cells[3].Text.Trim());
                    cmd.Parameters.AddWithValue("@ExpertiseLevel", GVInstructorsActive.SelectedRow.Cells[4].Text.Trim());
                    cmd.Parameters.AddWithValue("@FirstName", GVInstructorsActive.SelectedRow.Cells[5].Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", GVInstructorsActive.SelectedRow.Cells[6].Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", GVInstructorsActive.SelectedRow.Cells[7].Text.Trim());
                    cmd.Parameters.AddWithValue("@ContactNumber", GVInstructorsActive.SelectedRow.Cells[8].Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", GVInstructorsActive.SelectedRow.Cells[9].Text.Trim());
                    cmd.Parameters.AddWithValue("@Status", GVInstructorsActive.SelectedRow.Cells[10].Text.Trim());
                    cmd.Parameters.AddWithValue("@InstructorID", GVInstructorsActive.SelectedRow.Cells[1].Text.Trim());

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        lblError.Text = "Instructor updated successfully!";
                    }
                    else
                    {
                        lblError.Text = "Update failed. Instructor not found.";
                    }
                }
            }

        }
        private bool ValidateVehicleAssignment(string licensePlateID, int instructorID, out string errorMessage)
        {
            errorMessage = "";
            string connString = "Data Source=146.230.177.46;Initial Catalog=WstGrp24;User ID=WstGrp24;Password=6wefi;TrustServerCertificate=True";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // 1. Check if the vehicle exists
                string existsQuery = "SELECT COUNT(*) FROM VehicleMJ WHERE LicensePlateID = @LicensePlateID";
                using (SqlCommand cmd = new SqlCommand(existsQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@LicensePlateID", GVInstructorsActive.SelectedRow.Cells[2].Text.Trim());
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        errorMessage = "The vehicle does not exist.";
                        return false;
                    }
                }

                // 2. Check if vehicle is allocated to another active instructor (ignore current instructor if updating)
                string allocatedQuery = "SELECT COUNT(*) FROM InstructorsMJ WHERE LicensePlateID = @LicensePlateID AND Status = 'Active' AND InstructorID <> @InstructorID";
                using (SqlCommand cmd = new SqlCommand(allocatedQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@LicensePlateID", GVInstructorsActive.SelectedRow.Cells[2].Text.Trim());
                    cmd.Parameters.AddWithValue("@InstructorID", GVInstructorsActive.SelectedRow.Cells[1].Text.Trim());
                    int count = (int)cmd.ExecuteScalar();
                    if (count > 0)
                    {
                        errorMessage = "The vehicle is already allocated to an active instructor.";
                        return false;
                    }
                }
            }
            // All checks passed
            return true;
        }
        
    }
}