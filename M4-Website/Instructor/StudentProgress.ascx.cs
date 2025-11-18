using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
            if (!IsPostBack)
            {
                string emp = " ";
                DSStudent.SelectParameters["Search"].DefaultValue = emp;
                GVStu.DataBind();

                DSProgress.SelectParameters["Search"].DefaultValue = emp;
                GVProgress.DataBind();
                DDLSearch.DataBind();
               DDLSearch.Items.Insert(0, new ListItem("None", ""));
            }

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
                    DDLSearch.DataBind();
                }
                catch
                {
                    StatusLbl.Text = "Error: Make sure student is selected or that the student is not already added. ";
                }
            }
        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            if (GVProgress.SelectedIndex < 0)
            {
                StatusLbl.Text = "Please select a student first.";
                return;
            }

            int studentID = Convert.ToInt32(GVProgress.SelectedRow.Cells[1].Text);
            string skillColumn = SkillDDL.SelectedValue;
            string rating = RatingDDL.SelectedValue;

            UpdateStudentProgress(studentID, skillColumn, rating);
            GVProgress.DataBind();

        }

        private void UpdateStudentProgress(int studentID, string skillColumn, string rating)
        {
            string updateQuery = $"UPDATE StudentProgress SET {skillColumn} = @Rating WHERE StudentID = @StudentID";

            using (SqlConnection connec = new SqlConnection(ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(updateQuery, connec))
            {
                cmd.Parameters.AddWithValue("@StudentID", studentID);
                cmd.Parameters.AddWithValue("@Rating", rating);

                try
                {
                    connec.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        StatusLbl.Text = "Skill updated successfully.";
                    }
                    else
                    {
                        StatusLbl.Text = "No matching student found.";
                    }
                }
                catch 
                {
                    StatusLbl.Text = "Error updating skill";
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           
            if (GVProgress.SelectedIndex < 0)
            {
                StatusLbl.Text = "Please select a student first.";
                return;
            }

            int studentID = Convert.ToInt32(GVProgress.SelectedRow.Cells[1].Text);
            string newComment = TextBox1.Text.Trim();
            if (string.IsNullOrEmpty(newComment))
            {
                StatusLbl.Text = "Please enter a comment.";
                return;
            }

            AddCommentToStudentProgress(studentID, newComment);
            TextBox1.Text = "";
            GVProgress.DataBind();
        }
        

        private void AddCommentToStudentProgress(int studentID, string newComment)
        {
            string query = @"
        UPDATE StudentProgress
        SET Comments = @NewComment + CHAR(13) + CHAR(10) + ISNULL(Comments, '')
        WHERE StudentID = @StudentID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["WstGrp24ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@StudentID", studentID);
                cmd.Parameters.AddWithValue("@NewComment", $"[{DateTime.Now:yyyy-MM-dd HH:mm}] {newComment}");

                try
                {
                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    StatusLbl.Text = rows > 0 ? "Comment added." : "Student not found.";
                }
                catch 
                {
                    StatusLbl.Text = "Error adding comment";
                }
            }
        }

        protected void GVStu_SelectedIndexChanged(object sender, EventArgs e)
        {
            string name = GVStu.SelectedRow.Cells[2].Text;
            string surname = GVStu.SelectedRow.Cells[3].Text;
            StudentName.Value = name + " " + surname;
        }

        protected void GVProgress_SelectedIndexChanged(object sender, EventArgs e)
        {
            string name = GVProgress.SelectedRow.Cells[2].Text;
            string surname = GVProgress.SelectedRow.Cells[3].Text;
            StudentName.Value = name + " " + surname;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
           
            string input = txtSearch.Text.Trim();

            if (string.IsNullOrEmpty(input))
            {
                // Show all students
                string emp = " ";
                DSStudent.SelectParameters["Search"].DefaultValue = emp;
            }
            else
            {
                // Wildcard search for name or ID
                DSStudent.SelectParameters["Search"].DefaultValue =  input;
            }

            GVStu.DataBind();
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
           
            // Clear search box
            txtSearch.Text = " ";

            // Reset parameter to show all students
            string not = " ";
            DSStudent.SelectParameters["Search"].DefaultValue = not;

            GVStu.DataBind();
        
        }

        protected void DDLSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
           
           
               
                DSProgress.SelectParameters["Search"].DefaultValue = DDLSearch.Text;
            
            GVProgress.DataBind();
        }

        protected void btnReloadd_Click(object sender, EventArgs e)
        {
            string emp = " ";
            DSProgress.SelectParameters["Search"].DefaultValue = emp;
            GVProgress.DataBind();
        }
    }
}