<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="ManageInstructors.aspx.cs" Inherits="M4_Website.Manager.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
                <style>
    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: #ffffff;
    }

    /* Header */
    header {
        background: #ffffff;
        height: 80px;
        border-bottom: 1px solid #ddd;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        padding: 0 20px;
    }

    /* Sidebar */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 240px;
        height: 100vh;
        background-color: #000;
        color: white;
        padding-top: 20px;
    }

    .sidebar img {
        width: 160px;
        display: block;
        margin: 0 auto 20px auto;
    }

    .sidebar h2 {
        text-align: center;
        color: #fff;
        font-size: 18px;
        margin-bottom: 30px;
    }

    .sidebar a {
        display: block;
        padding: 12px 20px;
        color: #fff;
        text-decoration: none;
        transition: 0.2s;
    }

    .sidebar a:hover {
        background-color: #343a40;
    }
body {
  margin: 0;
  padding: 0;
  background: #fff;
}
.dashboard-layout {
  display: flex;
  min-height: 100vh;
}
.sidebar {
  width: 230px;
  background: #000;
  color: #fff;
  min-height: 100vh;
  position: fixed; /* fixes the sidebar to the left */
  left: 0;
  top: 0;
  padding-top: 0;
  z-index: 999;
}
 .sidebar img {
     width: 160px;
     display: block;
     margin: 0 auto 20px auto;
 }
.main-content {
  margin-left: 230px; /* this matches the sidebar width */
  padding: 32px 40px 40px 40px;
  flex: 1 1 0%;
}
.main-content h1 {
  margin-top: 0;
}
.grid-container {
  width: 50px;
  margin-top: 22px;
}
.dashboard-grid td, .dashboard-grid th {
  background: #fff !important;
  border: 1px solid #ddd !important;
  padding: 12px 16px !important;
  white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100px; 

}

        
        
                    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="main-content" style="background-color: #FFFFFF">
        <h2> Instructors</h2>
         
         <div class="grid-container" style="background-color: #FFFFFF">
             <div class=".dashboard-grid td, .dashboard-grid th">
                 <asp:GridView ID="GVInstructorsActive" runat="server" AutoGenerateColumns="False" DataKeyNames="InstructorID"  AllowPaging="True" SelectedRowStyle-ForeColor="#CCCCCC" SelectedRowStyle-BorderWidth="3px" SelectedRowStyle-BorderStyle="Dotted" SelectedRowStyle-BorderColor="Black" OnRowCancelingEdit="GVInstructorsActive_RowCancelingEdit" OnRowEditing="GVInstructorsActive_RowEditing" OnRowUpdating="GVInstructorsActive_RowUpdating" OnSelectedIndexChanged="GVInstructorsActive_SelectedIndexChanged">
                     <Columns>
                         <asp:CommandField ShowEditButton="True" ShowSelectButton="True">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                         </asp:CommandField>
                         <asp:BoundField DataField="InstructorID" HeaderText="InstructorID" ReadOnly="True" InsertVisible="False" SortExpression="InstructorID">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="LicensePlateID" HeaderText="LicensePlateID" SortExpression="LicensePlateID">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="LicenseNumber" HeaderText="LicenseNumber" SortExpression="LicenseNumber">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="ExpertiseLevel" HeaderText="ExpertiseLevel" SortExpression="ExpertiseLevel">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>

                             <ItemStyle BackColor="White" Font-Bold="False"></ItemStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" SortExpression="ContactNumber">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>
                         <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status">
                             <HeaderStyle BackColor="#CC0000" Font-Bold="True"></HeaderStyle>
                         </asp:BoundField>

                     </Columns>

                     <SelectedRowStyle BorderColor="Black" BorderWidth="3px" BorderStyle="Dotted"></SelectedRowStyle>
                 </asp:GridView>

             <asp:SqlDataSource runat="server" ID="GVinstructors" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT * FROM [InstructorMJ]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [InstructorMJ] WHERE [InstructorID] = @original_InstructorID AND (([LicensePlateID] = @original_LicensePlateID) OR ([LicensePlateID] IS NULL AND @original_LicensePlateID IS NULL)) AND (([LicenseNumber] = @original_LicenseNumber) OR ([LicenseNumber] IS NULL AND @original_LicenseNumber IS NULL)) AND (([ExpertiseLevel] = @original_ExpertiseLevel) OR ([ExpertiseLevel] IS NULL AND @original_ExpertiseLevel IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([ContactNumber] = @original_ContactNumber) OR ([ContactNumber] IS NULL AND @original_ContactNumber IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL))" InsertCommand="INSERT INTO [InstructorMJ] ([LicensePlateID], [LicenseNumber], [ExpertiseLevel], [FirstName], [LastName], [Gender], [ContactNumber], [Email], [Status]) VALUES (@LicensePlateID, @LicenseNumber, @ExpertiseLevel, @FirstName, @LastName, @Gender, @ContactNumber, @Email, @Status)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [InstructorMJ] SET [LicensePlateID] = @LicensePlateID, [LicenseNumber] = @LicenseNumber, [ExpertiseLevel] = @ExpertiseLevel, [FirstName] = @FirstName, [LastName] = @LastName, [Gender] = @Gender, [ContactNumber] = @ContactNumber, [Email] = @Email, [Status] = @Status WHERE [InstructorID] = @original_InstructorID AND (([LicensePlateID] = @original_LicensePlateID) OR ([LicensePlateID] IS NULL AND @original_LicensePlateID IS NULL)) AND (([LicenseNumber] = @original_LicenseNumber) OR ([LicenseNumber] IS NULL AND @original_LicenseNumber IS NULL)) AND (([ExpertiseLevel] = @original_ExpertiseLevel) OR ([ExpertiseLevel] IS NULL AND @original_ExpertiseLevel IS NULL)) AND (([FirstName] = @original_FirstName) OR ([FirstName] IS NULL AND @original_FirstName IS NULL)) AND (([LastName] = @original_LastName) OR ([LastName] IS NULL AND @original_LastName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([ContactNumber] = @original_ContactNumber) OR ([ContactNumber] IS NULL AND @original_ContactNumber IS NULL)) AND (([Email] = @original_Email) OR ([Email] IS NULL AND @original_Email IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL))">
                 <DeleteParameters>
                     <asp:Parameter Name="original_InstructorID" Type="Int32"></asp:Parameter>
                     <asp:Parameter Name="original_LicensePlateID" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_LicenseNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_ExpertiseLevel" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_FirstName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_LastName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Gender" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_ContactNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Email" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                 </DeleteParameters>
                 <InsertParameters>
                     <asp:Parameter Name="LicensePlateID" Type="String"></asp:Parameter>
                     <asp:Parameter Name="LicenseNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="ExpertiseLevel" Type="String"></asp:Parameter>
                     <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Gender" Type="String"></asp:Parameter>
                     <asp:Parameter Name="ContactNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Email" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                 </InsertParameters>
                 <UpdateParameters>
                     <asp:Parameter Name="LicensePlateID" Type="String"></asp:Parameter>
                     <asp:Parameter Name="LicenseNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="ExpertiseLevel" Type="String"></asp:Parameter>
                     <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Gender" Type="String"></asp:Parameter>
                     <asp:Parameter Name="ContactNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Email" Type="String"></asp:Parameter>
                     <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_InstructorID" Type="Int32"></asp:Parameter>
                     <asp:Parameter Name="original_LicensePlateID" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_LicenseNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_ExpertiseLevel" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_FirstName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_LastName" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Gender" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_ContactNumber" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Email" Type="String"></asp:Parameter>
                     <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                 </UpdateParameters>
             </asp:SqlDataSource>
         </div>

        
         
         <br />
         <br />


    </div>
    </div>
</asp:Content>
