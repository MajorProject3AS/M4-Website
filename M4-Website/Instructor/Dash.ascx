<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Dash.ascx.cs" Inherits="M4_Website.Dash" %>
<style>
    .summary-wrapper {
    display: flex;
    justify-content: space-around;
    gap: 20px;
    margin: 20px 0;
}

.summary-box {
    border: 2px solid #ccc;
    padding: 30px;
    width: 300px;
    height: 200px;
    text-align: center;
    background-color: #fff;
    border-radius: 10px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
    font-size: 22px;
    font-weight: bold;
    display: flex;
    flex-direction: column;
    justify-content: center;

}

.grid-wrapper {
    max-height: 300px;       /* Set desired height */
    overflow-y: auto;        /* Enable vertical scroll */
    border: 1px solid #ccc;

}

.booking-grid {
    width: 70%;
     margin: 0 auto;             /* center it */
    font-size: 14px;            
    border-collapse: collapse;

    
}

.booking-grid th, .booking-grid td {
    border: 1px solid #ccc;
    padding: 6px 10px;
    text-align: left;
}
@media screen and (max-width: 768px) {
    .summary-wrapper {
        flex-direction: column;
        align-items: center;
    }

}
.booking-grid th {
    background-color: #f5f5f5;
    font-weight: bold;
}

</style>
<div class="summary-wrapper">

<asp:DetailsView ID="DetailsViewToday" runat="server" CssClass="summary-box"  />


<asp:DetailsView ID="DetailsViewMonthly" runat="server" CssClass="summary-box"  />


<asp:DetailsView ID="DetailsViewStudents" runat="server" CssClass="summary-box"  />
</div>
<div class="grid-wrapper">
    <asp:GridView ID="BookingsGV" runat="server" CssClass="booking-grid" AutoGenerateColumns="False" DataKeyNames="BookingID" DataSourceID="DSBookings">
        <Columns>
            <asp:CommandField ShowSelectButton="True"></asp:CommandField>
            <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" InsertVisible="False" SortExpression="BookingID"></asp:BoundField>
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
            <asp:BoundField DataField="VehicleID" HeaderText="VehicleID" SortExpression="VehicleID"></asp:BoundField>
            <asp:BoundField DataField="PackageID" HeaderText="PackageID" SortExpression="PackageID"></asp:BoundField>
            <asp:BoundField DataField="TimeSlotID" HeaderText="TimeSlotID" SortExpression="TimeSlotID"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="DSBookings" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString2 %>' ProviderName='<%$ ConnectionStrings:WstGrp24ConnectionString2.ProviderName %>' SelectCommand="SELECT BookingID, StudentID, InstructorID, VehicleID, PackageID, TimeSlotID, Date, Time, Status FROM LessonBookingMJ WHERE (InstructorID = @instructorId)">
        <SelectParameters>
            <asp:Parameter Name="instructorId" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
