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
            try
            {
                string query = "SELECT InstructorID, LicensePlateID, LicenseNumber, ExpertiseLevel, FirstName, LastName, Gender, ContactNumber, Email, Status FROM InstructorMJ";

                using (SqlConnection con = new SqlConnection("Data Source=146.230.177.46;Initial Catalog=WstGrp24;User ID=WstGrp24;Password=6wefi;TrustServerCertificate=True"))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    System.Data.DataTable dt = new System.Data.DataTable(); // Fully qualified name
                    da.Fill(dt);

                    GVInstructorsActive.DataSource = dt;
                    GVInstructorsActive.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading data: {ex.Message}", "error");
            }
        }
       

        

        protected void GVInstructorsActive_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GVInstructorsActive_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVInstructorsActive.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GVInstructorsActive_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Get the primary key value
                string instructorID = GVInstructorsActive.DataKeys[e.RowIndex].Value.ToString();

                // Use Cells index for BoundFields (adjust indices based on your column order)
                // Skip the CommandField (index 0) and InstructorID (index 1, which is read-only)
                string licensePlateID = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[2].Controls[0]).Text.Trim();
                string licenseNumber = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[3].Controls[0]).Text.Trim();
                string expertiseLevel = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[4].Controls[0]).Text.Trim();
                string firstName = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[5].Controls[0]).Text.Trim();
                string lastName = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[6].Controls[0]).Text.Trim();
                string gender = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[7].Controls[0]).Text.Trim();
                string contactNumber = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[8].Controls[0]).Text.Trim();
                string email = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[9].Controls[0]).Text.Trim();
                string status = ((TextBox)GVInstructorsActive.Rows[e.RowIndex].Cells[10].Controls[0]).Text.Trim();
                // Validate vehicle before updating
                string validationResult = ValidateVehicle(licensePlateID, instructorID);

                if (validationResult != "VALID")
                {
                    ShowMessage(validationResult, "error");
                    return; // Stop the update process
                }
                // Proceed with update if validation passes
                string updateQuery = @"UPDATE InstructorMJ SET 
                                 LicensePlateID = @LicensePlateID, 
                                 LicenseNumber = @LicenseNumber, 
                                 ExpertiseLevel = @ExpertiseLevel, 
                                 FirstName = @FirstName, 
                                 LastName = @LastName, 
                                 Gender = @Gender, 
                                 ContactNumber = @ContactNumber, 
                                 Email = @Email, 
                                 Status = @Status 
                                 WHERE InstructorID = @InstructorID";

                using (SqlConnection con = new SqlConnection("Data Source=146.230.177.46;Initial Catalog=WstGrp24;User ID=WstGrp24;Password=6wefi;TrustServerCertificate=True"))
                {
                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@LicensePlateID", licensePlateID);
                    cmd.Parameters.AddWithValue("@LicenseNumber", licenseNumber);
                    cmd.Parameters.AddWithValue("@ExpertiseLevel", expertiseLevel);
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@InstructorID", instructorID);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();
                    if (rowsAffected > 0)
                    {
                        ShowMessage("Instructor updated successfully!", "success");
                    }
                    else
                    {
                        ShowMessage("No records were updated. Please check if the instructor exists.", "warning");
                    }
                }

                GVInstructorsActive.EditIndex = -1;
                BindGridView();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating instructor: {ex.Message}", "error");
            }
        }

        protected void GVInstructorsActive_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

            GVInstructorsActive.EditIndex = -1;
            BindGridView();

        }
        private string ValidateVehicle(string licensePlateID, string currentInstructorID)
        {
            // Your existing validation logic (unchanged)
            using (SqlConnection con = new SqlConnection("Data Source=146.230.177.46;Initial Catalog=WstGrp24;User ID=WstGrp24;Password=6wefi;TrustServerCertificate=True"))
            {
                // Check if vehicle exists in vehicleMJ table
                string checkVehicleQuery = @"SELECT COUNT(*) FROM VehicleMJ WHERE LicensePlateID = @LicensePlateID";
                SqlCommand cmd = new SqlCommand(checkVehicleQuery, con);
                cmd.Parameters.AddWithValue("@LicensePlateID", licensePlateID);

                con.Open();
                int vehicleCount = (int)cmd.ExecuteScalar();

                if (vehicleCount == 0)
                {
                    return "Vehicle does not exist in the system!";
                }

                // Check vehicle status
                string checkStatusQuery = @"SELECT Status FROM VehicleMJ WHERE LicensePlateID = @LicensePlateID";
                cmd.CommandText = checkStatusQuery;
                string vehicleStatus = cmd.ExecuteScalar()?.ToString();

                if (vehicleStatus?.ToUpper() != "ACTIVE")
                {
                    return "Vehicle is not active! Please select an active vehicle.";
                }
                // Check if vehicle is allocated to another instructor
                string checkAllocationQuery = @"SELECT COUNT(*) FROM InstructorMJ 
                                          WHERE LicensePlateID = @LicensePlateID 
                                          AND InstructorID != @InstructorID
                                          AND Status = 'Active'";
                cmd.CommandText = checkAllocationQuery;
                cmd.Parameters.AddWithValue("@InstructorID", currentInstructorID);
                int allocatedCount = (int)cmd.ExecuteScalar();

                if (allocatedCount > 0)
                {
                    return "Vehicle is already allocated to another active instructor!";
                }

                con.Close();
            }

            return "VALID";
        }
        private void ShowMessage(string message, string type)
        {
            // Enhanced message display with different colors based on type
            string color = type == "success" ? "green" : type == "warning" ? "orange" : "red";
            string script = $@"<script type='text/javascript'>
        alert('{message.Replace("'", "\\'")}');
    </script>";

            if (ScriptManager.GetCurrent(this) != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", script, false);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
        }

        protected void GVInstructorsActive_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
 }
