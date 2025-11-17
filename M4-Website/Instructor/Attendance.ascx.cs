using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace M4_Website
{
    public partial class Attendance : System.Web.UI.UserControl
    {
        public int Id;
        protected void Page_Load(object sender, EventArgs e)
        {

            string status = "Confirmed";
                string username = HttpContext.Current.User.Identity.Name;
                Id = GetStaffIdByUsername(username);
               
                Session["InstructorID"] = Id; // Store for later use
            
            string instructorID = Id.ToString();
            if (string.IsNullOrEmpty(instructorID)) return;

            DSBP.SelectParameters["instructorId"].DefaultValue = instructorID;
            DSBP.SelectParameters["status"].DefaultValue = status;
            BKPac.DataBind();
            DSAttendance.SelectParameters["instructorId"].DefaultValue = instructorID;
            DSAttendance.SelectParameters["Search"].DefaultValue = " ";
            AttendanceGV.DataBind();
           

        }
        private int GetStaffIdByUsername(string username)
        {
            int InstructorId = -1;
            string connSt = ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connSt))
            using (SqlCommand cmd = new SqlCommand("SELECT InstructorID FROM InstructorMJ WHERE Email = @Username", conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                conn.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    InstructorId = Convert.ToInt32(result);
                }
            }

            return InstructorId;
        }
        protected void PresentBtn_Click(object sender, EventArgs e)
        {
            if (BKPac.SelectedIndex > -1)
            {
                try
                {
                string date = DateTime.Now.ToString("yyyy-MM-dd");
                string attendance = "Present";
                    string instructorID = Id.ToString();
                    if (string.IsNullOrEmpty(instructorID)) return;

                    DSAttendance.InsertParameters["BookingID"].DefaultValue = BKPac.SelectedRow.Cells[1].Text;
                DSAttendance.InsertParameters["StudentID"].DefaultValue = BKPac.SelectedRow.Cells[2].Text;
                DSAttendance.InsertParameters["StudentName"].DefaultValue = BKPac.SelectedRow.Cells[3].Text;
                DSAttendance.InsertParameters["StudentSurname"].DefaultValue = BKPac.SelectedRow.Cells[4].Text;
                DSAttendance.InsertParameters["InstructorId"].DefaultValue = instructorID;
                DSAttendance.InsertParameters["BookingDate"].DefaultValue = BKPac.SelectedRow.Cells[5].Text;
                DSAttendance.InsertParameters["BookingTime"].DefaultValue = BKPac.SelectedRow.Cells[6].Text;
                DSAttendance.InsertParameters["Attendance"].DefaultValue = attendance;
                DSAttendance.InsertParameters["Date"].DefaultValue = date;
                DSAttendance.InsertParameters["PackageID"].DefaultValue = BKPac.SelectedRow.Cells[7].Text;
                DSAttendance.Insert();
                AttendanceGV.DataBind();


                }
                catch (Exception ex)
                {
                   statusLbl.Text = "Error: " + ex.Message;
                }

            }
        }

        protected void AbsentBtn_Click(object sender, EventArgs e)
        {
            if (BKPac.SelectedIndex > -1)
            {
                try
                {
                    string date = DateTime.Now.ToString("yyyy-MM-dd");
                    string attendanc = "Absent";
                    string instructorID = Id.ToString();
                    if (string.IsNullOrEmpty(instructorID)) return;

                    DSAttendance.InsertParameters["BookingID"].DefaultValue = BKPac.SelectedRow.Cells[1].Text;
                    DSAttendance.InsertParameters["StudentID"].DefaultValue = BKPac.SelectedRow.Cells[2].Text;
                    DSAttendance.InsertParameters["StudentName"].DefaultValue = BKPac.SelectedRow.Cells[3].Text;
                    DSAttendance.InsertParameters["StudentSurname"].DefaultValue = BKPac.SelectedRow.Cells[4].Text;
                    DSAttendance.InsertParameters["instructorId"].DefaultValue = instructorID;
                    DSAttendance.InsertParameters["BookingDate"].DefaultValue = BKPac.SelectedRow.Cells[5].Text;
                    DSAttendance.InsertParameters["BookingTime"].DefaultValue = BKPac.SelectedRow.Cells[6].Text;
                    DSAttendance.InsertParameters["Attendance"].DefaultValue = attendanc;
                    DSAttendance.InsertParameters["Date"].DefaultValue = date;
                    DSAttendance.InsertParameters["PackageID"].DefaultValue = BKPac.SelectedRow.Cells[7].Text;
                    DSAttendance.Insert();
                    AttendanceGV.DataBind();
                }
                catch (Exception ex)
                {
                    statusLbl.Text = "Error: " + ex.Message;

                }
            }
        }

        protected void BKPac_SelectedIndexChanged(object sender, EventArgs e)
        {
            string name = BKPac.SelectedRow.Cells[3].Text;
            string surname = BKPac.SelectedRow.Cells[4].Text;
            hfStudentName.Value = name + " " + surname;
        }

       

        protected void btnReloa_Click(object sender, EventArgs e)
        {
           
            string instructorID = Id.ToString();
            if (string.IsNullOrEmpty(instructorID)) return;
            DSAttendance.SelectParameters["instructorId"].DefaultValue = instructorID;
            DSAttendance.SelectParameters["Search"].DefaultValue =" ";

            AttendanceGV.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string input = txtSearch.Text.Trim();
                string instructorID = Id.ToString();
                if (string.IsNullOrEmpty(instructorID)) return;

            if (string.IsNullOrEmpty(input))
            {
                // Show all students
                string emp = " ";
               
                DSAttendance.SelectParameters["Search"].DefaultValue = emp;
                DSAttendance.SelectParameters["instructorId"].DefaultValue = instructorID;
            }
            else
            {
                // Wildcard search for name or ID
                DSAttendance.SelectParameters["Search"].DefaultValue = input;
                DSAttendance.SelectParameters["instructorId"].DefaultValue = instructorID;
            }

            AttendanceGV.DataBind();
        }
    }
}