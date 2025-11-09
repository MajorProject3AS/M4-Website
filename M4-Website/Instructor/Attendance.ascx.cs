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
    }
}