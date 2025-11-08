<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="ManagerDefault.aspx.cs" Inherits="M4_Website.Manager.WebForm1" %>
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
.cards {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  margin-bottom: 28px;
  justify-content: flex-start;
}
.card {
  background: #960B0B;
  color: #fff;
  min-width: 270px; /* adjust as needed */
  margin: 0;
  border-radius: 6px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  flex: 1 0 15%; /* 4 cards per row if room */
  max-width: 350px;
}
.grid-container {
  width: 100%;
  margin-top: 22px;
}
.dashboard-grid td, .dashboard-grid th {
  background: #fff !important;
  border: 1px solid #ddd !important;
  padding: 12px 16px !important;
}
        /* Status colors */
        .status-confirmed {
            color: green !important;
            font-weight: bold !important;
        }
        
        .status-pending {
            color: orange !important;
            font-weight: bold !important;
        }
        
        .status-cancelled {
            color: red !important;
            font-weight: bold !important;
        }


   
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="main-content" style="background-color: #FFFFFF">
        <div class="cards">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' ProviderName='<%$ ConnectionStrings:WstGrp24ConnectionString.ProviderName %>' SelectCommand="SELECT COUNT(*) AS Bookings FROM LessonBookingMJ WHERE (Status = 'Scheduled')"></asp:SqlDataSource>
            <div class="card">
                <h3>Scheduled Bookings</h3>
                <p>
                                      <asp:DetailsView 
    ID="DVbookings" 
    runat="server" 
    DataSourceID="SqlDataSource1"
    AutoGenerateRows="False"
    RowStyle-HorizontalAlign="Center"
    HeaderStyle-BackColor="#FFFFFF"
    Width="100px"
    BorderStyle="None"
    GridLines="None" Font-Size="X-Large" Font-Bold="True">
    <Fields>
        <asp:BoundField DataField="Bookings" HeaderText="" />
    </Fields>
</asp:DetailsView>
                </p>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT COUNT(*) AS ActiveInstructors FROM InstructorMJ WHERE (Status = 'Active')"></asp:SqlDataSource>
            <div class="card">
                <h3>Instructors On Duty</h3>
                <p>
                  <asp:DetailsView 
    ID="dvActiveInstructors" 
    runat="server" 
    DataSourceID="SqlDataSource2"
    AutoGenerateRows="False"
    RowStyle-HorizontalAlign="Center"
    HeaderStyle-BackColor="#FFFFFF"
    Width="100px"
    BorderStyle="None"
    GridLines="None" Font-Size="X-Large" Font-Bold="True">
    <Fields>
        <asp:BoundField DataField="ActiveInstructors" HeaderText="" />
    </Fields>
</asp:DetailsView>
                </p>
            </div>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT COUNT(*) AS ActiveVehicles FROM VehicleMJ WHERE (Status = 'Active')"></asp:SqlDataSource>
            <div class="card">
                <h3>Vehicles Available</h3>
                <p> 
                                      <asp:DetailsView 
    ID="vehicles" 
    runat="server" 
    DataSourceID="SqlDataSource3"
    AutoGenerateRows="False"
    RowStyle-HorizontalAlign="Center"
    HeaderStyle-BackColor="#FFFFFF"
    Width="100px"
    BorderStyle="None"
    GridLines="None" Font-Size="X-Large" Font-Bold="True">
    <Fields>
        <asp:BoundField DataField="ActiveVehicles" HeaderText="" />
    </Fields>
</asp:DetailsView>
                </p>
            </div>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT COUNT(*) AS ActiveStaff FROM MJstaff WHERE (Status = 'Active')"></asp:SqlDataSource>
            <div class="card">
                <h3>Staff On Duty</h3>
                <p>
                                     <asp:DetailsView 
    ID="DVstaff" 
    runat="server" 
    DataSourceID="SqlDataSource4"
    AutoGenerateRows="False"
    RowStyle-HorizontalAlign="Center"
    HeaderStyle-BackColor="#FFFFFF"
    Width="100px"
    BorderStyle="None"
    GridLines="None" Font-Size="X-Large" Font-Bold="True">
    <Fields>
        <asp:BoundField DataField="ActiveStaff" HeaderText="" />
    </Fields>
</asp:DetailsView>
                </p>
            </div>
        </div>

    <h2>Bookings Histroy</h2>

   <div class="grid-container" style="background-color: #FFFFFF">
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="BookingID" DataSourceID="DSLessonBookings" AllowPaging="True">
           <Columns>
               <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" InsertVisible="False" SortExpression="BookingID"></asp:BoundField>
               <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
               <asp:BoundField DataField="InstructorID" HeaderText="InstructorID" SortExpression="InstructorID"></asp:BoundField>
               <asp:BoundField DataField="VehicleID" HeaderText="VehicleID" SortExpression="VehicleID"></asp:BoundField>
               <asp:BoundField DataField="PackageID" HeaderText="PackageID" SortExpression="PackageID"></asp:BoundField>
               <asp:BoundField DataField="TimeSlotID" HeaderText="TimeSlotID" SortExpression="TimeSlotID"></asp:BoundField>
               <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
               <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
               <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>

                <asp:TemplateField HeaderText="Status">
                  <ItemTemplate>
                      <asp:Label ID="lblStatus" runat="server" 
                          Text='<%# Eval("Status") %>'
                          CssClass='<%# "status-" + Eval("Status").ToString().ToLower() %>'>
                      </asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
           </Columns>
       </asp:GridView>

       <asp:SqlDataSource runat="server" ID="DSLessonBookings" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT * FROM [LessonBookingMJ]"></asp:SqlDataSource>
      
                
           </div>
        
    </div>


</asp:Content>
