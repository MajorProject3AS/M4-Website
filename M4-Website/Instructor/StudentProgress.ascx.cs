using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M4_Website
{
    public partial class StudentProgress : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void Addbtn_Click1(object sender, EventArgs e)
        {
            if (GVStu.SelectedIndex > -1)
            {
                
                
                try
                {
                    DSProgress.InsertParameters["StudentID"].DefaultValue = GVStu.SelectedRow.Cells[1].Text;
                    DSProgress.InsertParameters["StudentName"].DefaultValue = GVStu.SelectedRow.Cells[2].Text;
                    DSProgress.InsertParameters["StudentSurname"].DefaultValue = GVStu.SelectedRow.Cells[3].Text;
                    DSProgress.Insert();
                    GVProgress.DataBind();
                }
                catch (Exception ex)
                {
                    StatusLbl.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}