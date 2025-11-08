<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="ManageVehicles.aspx.cs" Inherits="M4_Website.Manager.WebForm3" %>
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
   <h2> Vehicles</h2>
    
    <div class="grid-container" style="background-color: #FFFFFF">
        <div class=".dashboard-grid td, .dashboard-grid th">
            <asp:GridView ID="GVvehichles" runat="server" AutoGenerateColumns="False" DataKeyNames="LicensePlateID" DataSourceID="DSvehicle" AllowPaging="True" SelectedRowStyle-BorderColor="Black" SelectedRowStyle-BackColor="#CCCCCC" SelectedRowStyle-BorderStyle="Dotted">
                <Columns>
                    <asp:CommandField ShowEditButton="True" ShowSelectButton="True">
                        <HeaderStyle BackColor="Black"></HeaderStyle>
                    </asp:CommandField>
                    <asp:BoundField DataField="LicensePlateID" HeaderText="LicensePlateID" ReadOnly="True" SortExpression="LicensePlateID">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="TransmissionType" HeaderText="TransmissionType" SortExpression="TransmissionType">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="FuelType" HeaderText="FuelType" SortExpression="FuelType">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Make" HeaderText="Make" SortExpression="Make">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="VehicleType" HeaderText="VehicleType" SortExpression="VehicleType">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status">
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="DSvehicle" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' DeleteCommand="DELETE FROM [VehicleMJ] WHERE [LicensePlateID] = @original_LicensePlateID AND (([TransmissionType] = @original_TransmissionType) OR ([TransmissionType] IS NULL AND @original_TransmissionType IS NULL)) AND (([FuelType] = @original_FuelType) OR ([FuelType] IS NULL AND @original_FuelType IS NULL)) AND (([Make] = @original_Make) OR ([Make] IS NULL AND @original_Make IS NULL)) AND (([VehicleType] = @original_VehicleType) OR ([VehicleType] IS NULL AND @original_VehicleType IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL))" InsertCommand="INSERT INTO [VehicleMJ] ([LicensePlateID], [TransmissionType], [FuelType], [Make], [VehicleType], [Status]) VALUES (@LicensePlateID, @TransmissionType, @FuelType, @Make, @VehicleType, @Status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [VehicleMJ]" UpdateCommand="UPDATE [VehicleMJ] SET [TransmissionType] = @TransmissionType, [FuelType] = @FuelType, [Make] = @Make, [VehicleType] = @VehicleType, [Status] = @Status WHERE [LicensePlateID] = @original_LicensePlateID AND (([TransmissionType] = @original_TransmissionType) OR ([TransmissionType] IS NULL AND @original_TransmissionType IS NULL)) AND (([FuelType] = @original_FuelType) OR ([FuelType] IS NULL AND @original_FuelType IS NULL)) AND (([Make] = @original_Make) OR ([Make] IS NULL AND @original_Make IS NULL)) AND (([VehicleType] = @original_VehicleType) OR ([VehicleType] IS NULL AND @original_VehicleType IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_LicensePlateID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_TransmissionType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_FuelType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Make" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_VehicleType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="LicensePlateID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="TransmissionType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="FuelType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Make" Type="String"></asp:Parameter>
                    <asp:Parameter Name="VehicleType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TransmissionType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="FuelType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Make" Type="String"></asp:Parameter>
                    <asp:Parameter Name="VehicleType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_LicensePlateID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_TransmissionType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_FuelType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Make" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_VehicleType" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Status" Type="String"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            </div>
        </div>
        </div>

</asp:Content>
