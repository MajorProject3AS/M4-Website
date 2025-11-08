using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class InstructorDB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Control ctrl = LoadControl("~/Instructor/Dash.ascx");
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ctrl);
        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Control ctrl = LoadControl("~/Instructor/Dash.ascx");
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ctrl);
        }

        protected void btnAttendance_Click(object sender, EventArgs e)
        {
            Control ctrl = LoadControl("~/Instructor/Attendance.ascx");
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ctrl);
        }

        protected void btnProgress_Click(object sender, EventArgs e)
        {
            Control ctrl = LoadControl("~/Instructor/StudentProgress.ascx");
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ctrl);
        }
        
    }
}