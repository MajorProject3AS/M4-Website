using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class Attendance : System.Web.UI.UserControl
    {
        public int Id = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            DSBP.SelectParameters["instructorId"].DefaultValue = Id.ToString();
            BKPac.DataBind();
            DSAttendance.SelectParameters["instructorId"].DefaultValue = Id.ToString();
            AttendanceGV.DataBind();
        }

        protected void PresentBtn_Click(object sender, EventArgs e)
        {
            if (BKPac.SelectedIndex > -1)
            {
                try
                {
                string date = DateTime.Now.ToString("yyyy-MM-dd");
                string attendance = "Present";
                DSAttendance.InsertParameters["BookingID"].DefaultValue = BKPac.SelectedRow.Cells[1].Text;
                DSAttendance.InsertParameters["StudentID"].DefaultValue = BKPac.SelectedRow.Cells[2].Text;
                DSAttendance.InsertParameters["StudentName"].DefaultValue = BKPac.SelectedRow.Cells[3].Text;
                DSAttendance.InsertParameters["StudentSurname"].DefaultValue = BKPac.SelectedRow.Cells[4].Text;
                DSAttendance.InsertParameters["InstructorId"].DefaultValue = Id.ToString();
                DSAttendance.InsertParameters["BookingDate"].DefaultValue = BKPac.SelectedRow.Cells[6].Text;
                DSAttendance.InsertParameters["BookingTime"].DefaultValue = BKPac.SelectedRow.Cells[7].Text;
                DSAttendance.InsertParameters["Attendance"].DefaultValue = attendance;
                DSAttendance.InsertParameters["Date"].DefaultValue = date;
                DSAttendance.InsertParameters["PackageID"].DefaultValue = BKPac.SelectedRow.Cells[8].Text;
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
                    DSAttendance.InsertParameters["BookingID"].DefaultValue = BKPac.SelectedRow.Cells[1].Text;
                    DSAttendance.InsertParameters["StudentID"].DefaultValue = BKPac.SelectedRow.Cells[2].Text;
                    DSAttendance.InsertParameters["StudentName"].DefaultValue = BKPac.SelectedRow.Cells[3].Text;
                    DSAttendance.InsertParameters["StudentSurname"].DefaultValue = BKPac.SelectedRow.Cells[4].Text;
                    DSAttendance.InsertParameters["instructorId"].DefaultValue = Id.ToString();
                    DSAttendance.InsertParameters["BookingDate"].DefaultValue = BKPac.SelectedRow.Cells[6].Text;
                    DSAttendance.InsertParameters["BookingTime"].DefaultValue = BKPac.SelectedRow.Cells[7].Text;
                    DSAttendance.InsertParameters["Attendance"].DefaultValue = attendanc;
                    DSAttendance.InsertParameters["Date"].DefaultValue = date;
                    DSAttendance.InsertParameters["PackageID"].DefaultValue = BKPac.SelectedRow.Cells[8].Text;
                    DSAttendance.Insert();
                    AttendanceGV.DataBind();
                }
                catch (Exception ex)
                {
                    statusLbl.Text = "Error: " + ex.Message;

                }
            }
        }
    }
}