<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attendance.ascx.cs" Inherits="M4_Website.Attendance" %>
<style>
  .wrapper {
    display: flex;
    gap: 30px;
    align-items: flex-start;
    margin-bottom: 40px;
}
  .cln {
    flex: 0 0 280px;
    background-color: #fff;
    padding: 10px;
    border: 1px solid #ccc;
}
.GBWrap {
    flex: 1;
    max-height: 300px;
    overflow-x: auto;
    overflow-y: auto;
    border: 1px solid #ccc;
    padding: 5px;
    background-color: #fff;
    width:100%;
    max-width:100%;
}
.GB {
    width: max-content;
    font-size: 13px;
    border-collapse: collapse;
}

.GB th,
.GB td {
    padding: 4px 8px;
    border: 1px solid #ddd;
    white-space: nowrap;
    text-align: left;
}

.GB th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}
.GAWrap {
    flex: 1;
    max-height: 300px;
    overflow-x: auto;
    overflow-y: auto;
    border: 1px solid #ccc;
    padding: 5px;
    background-color: #fff;
}
.GB {
    width: max-content;
    font-size: 13px;
    border-collapse: collapse;
}

.GA th,
.GA td {
    padding: 4px 8px;
    border: 1px solid #ddd;
    white-space: nowrap;
    text-align: left;
}

.GA th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}

.butn {
    padding: 6px 14px;
    background-color: #c00;
    color: white;
    border: none;
    font-weight: bold;
    cursor: pointer;
    border-radius: 4px;
}

.butn:hover {
    background-color: #900;
}
.DDL {
    padding: 4px;
    font-size: 13px;
    border-radius: 4px;
    border: 1px solid #ccc;
}


  
</style>
<div class="wrapper">
<div class="CalendarWrap">
    
<div style="float:left;width:35%">
<asp:Label ID="Label1" runat="server" Text="*Select a date to view bookings"  Font-Italic="True" Font-Size="Small" ForeColor="#CC0000"></asp:Label>
    <asp:Calendar ID="Calendar1" runat="server" CssClass="cln"></asp:Calendar>
</div>
    
    </div>

<div style="float:left;width:70%">
    <asp:Label ID="Label4" runat="server" Text="*Select booking to mark attendance" ForeColor="#CC0000" Font-Size="Small" Font-Italic="True"></asp:Label>
    
    <div class="GBWrap">
    <asp:GridView ID="BKPac" runat="server" AutoGenerateColumns="False" DataSourceID="DSBP" CssClass="GB" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="BKPac_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" InsertVisible="False" SortExpression="BookingID"></asp:BoundField>
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d}"></asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
            <asp:BoundField DataField="PackageName" HeaderText="PackageName" SortExpression="PackageName"></asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="DSBP" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT LessonBookingMJ.BookingID, LessonBookingMJ.StudentID, StudentMJ.Name, StudentMJ.Surname, LessonBookingMJ.InstructorID, LessonBookingMJ.Date, LessonBookingMJ.Time, PackageMJ.PackageName FROM LessonBookingMJ INNER JOIN StudentMJ ON LessonBookingMJ.StudentID = StudentMJ.StudentID INNER JOIN PackageMJ ON LessonBookingMJ.PackageID = PackageMJ.PackageName AND StudentMJ.PackageName = PackageMJ.PackageName WHERE (LessonBookingMJ.InstructorID = @instructorId) AND (LessonBookingMJ.Date = @date)">
        <SelectParameters>
            <asp:Parameter Name="instructorId"></asp:Parameter>
            <asp:ControlParameter ControlID="Calendar1" Name="date" PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
    <asp:Button ID="PresentBtn" runat="server" Text="Present" OnClientClick="return confirmMark('Present');"
 OnClick="PresentBtn_Click" CssClass="butn" />
    <asp:Button ID="AbsentBtn" runat="server" Text="Absent" OnClientClick="return confirmMark('Absent');"
 OnClick="AbsentBtn_Click" CssClass="butn" />
    <asp:Label ID="statusLbl" runat="server" Text=" "></asp:Label>
</div>
    </div>
    

 <div class="GAWrap">
<h3>
<asp:Label ID="Label2" runat="server" Text="Lesson Attendance" Font-Bold="True" Font-Size="Large" ForeColor="Black"></asp:Label>
        </h3>
     <asp:TextBox ID="txtSearch" runat="server" CssClass="input-box" placeholder="Enter name or surname..." />
<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="butn" />
     <span style="float:right;width:7%;">
         <asp:Button ID="btnReloa" runat="server" Text="&#x21bb;" 
    ToolTip="Reload Grid"
    CssClass="reload-button"
    OnClick="btnReloa_Click" />
     </span>
    <asp:GridView ID="AttendanceGV" runat="server" Width="918px" AutoGenerateColumns="False" DataKeyNames="BookingID" DataSourceID="DSAttendance" CssClass="GA" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" SortExpression="BookingID"></asp:BoundField>
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
            <asp:BoundField DataField="StudentName" HeaderText="StudentName" SortExpression="StudentName"></asp:BoundField>
            <asp:BoundField DataField="StudentSurname" HeaderText="StudentSurname" SortExpression="StudentSurname"></asp:BoundField>
            <asp:BoundField DataField="BookingDate" HeaderText="BookingDate" SortExpression="BookingDate" DataFormatString="{0:d}"></asp:BoundField>
            <asp:BoundField DataField="BookingTime" HeaderText="BookingTime" SortExpression="BookingTime"></asp:BoundField>
            <asp:BoundField DataField="Attendance" HeaderText="Attendance" SortExpression="Attendance"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:d}"></asp:BoundField>
            <asp:BoundField DataField="PackageID" HeaderText="PackageID" SortExpression="PackageID"></asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="DSAttendance" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' DeleteCommand="DELETE FROM [LA_Sheet] WHERE [BookingID] = @original_BookingID AND (([StudentID] = @original_StudentID) OR ([StudentID] IS NULL AND @original_StudentID IS NULL)) AND (([StudentName] = @original_StudentName) OR ([StudentName] IS NULL AND @original_StudentName IS NULL)) AND (([StudentSurname] = @original_StudentSurname) OR ([StudentSurname] IS NULL AND @original_StudentSurname IS NULL)) AND (([InstructorID] = @original_InstructorID) OR ([InstructorID] IS NULL AND @original_InstructorID IS NULL)) AND (([BookingDate] = @original_BookingDate) OR ([BookingDate] IS NULL AND @original_BookingDate IS NULL)) AND (([BookingTime] = @original_BookingTime) OR ([BookingTime] IS NULL AND @original_BookingTime IS NULL)) AND (([Attendance] = @original_Attendance) OR ([Attendance] IS NULL AND @original_Attendance IS NULL)) AND (([Date] = @original_Date) OR ([Date] IS NULL AND @original_Date IS NULL)) AND (([PackageID] = @original_PackageID) OR ([PackageID] IS NULL AND @original_PackageID IS NULL))" InsertCommand="INSERT INTO [LA_Sheet] ([BookingID], [StudentID], [StudentName], [StudentSurname], [InstructorID], [BookingDate], [BookingTime], [Attendance], [Date], [PackageID]) VALUES (@BookingID, @StudentID, @StudentName, @StudentSurname, @InstructorID, @BookingDate, @BookingTime, @Attendance, @Date, @PackageID)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT BookingID, StudentID, StudentName, StudentSurname, InstructorID, BookingDate, BookingTime, Attendance, Date, PackageID FROM LA_Sheet WHERE (InstructorID = @instructorId) AND (@Search IS NULL OR @Search = '') OR (InstructorID = @instructorId) AND (StudentName LIKE @Search) OR (InstructorID = @instructorId) AND (StudentSurname LIKE @Search)" UpdateCommand="UPDATE [LA_Sheet] SET [StudentID] = @StudentID, [StudentName] = @StudentName, [StudentSurname] = @StudentSurname, [InstructorID] = @InstructorID, [BookingDate] = @BookingDate, [BookingTime] = @BookingTime, [Attendance] = @Attendance, [Date] = @Date, [PackageID] = @PackageID WHERE [BookingID] = @original_BookingID AND (([StudentID] = @original_StudentID) OR ([StudentID] IS NULL AND @original_StudentID IS NULL)) AND (([StudentName] = @original_StudentName) OR ([StudentName] IS NULL AND @original_StudentName IS NULL)) AND (([StudentSurname] = @original_StudentSurname) OR ([StudentSurname] IS NULL AND @original_StudentSurname IS NULL)) AND (([InstructorID] = @original_InstructorID) OR ([InstructorID] IS NULL AND @original_InstructorID IS NULL)) AND (([BookingDate] = @original_BookingDate) OR ([BookingDate] IS NULL AND @original_BookingDate IS NULL)) AND (([BookingTime] = @original_BookingTime) OR ([BookingTime] IS NULL AND @original_BookingTime IS NULL)) AND (([Attendance] = @original_Attendance) OR ([Attendance] IS NULL AND @original_Attendance IS NULL)) AND (([Date] = @original_Date) OR ([Date] IS NULL AND @original_Date IS NULL)) AND (([PackageID] = @original_PackageID) OR ([PackageID] IS NULL AND @original_PackageID IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_BookingID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="original_StudentID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="original_StudentName" Type="String"></asp:Parameter>
            <asp:Parameter Name="original_StudentSurname" Type="String"></asp:Parameter>
            <asp:Parameter Name="original_InstructorID" Type="Int32"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="original_BookingDate"></asp:Parameter>
            <asp:Parameter DbType="Time" Name="original_BookingTime"></asp:Parameter>
            <asp:Parameter Name="original_Attendance" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="original_Date"></asp:Parameter>
            <asp:Parameter Name="original_PackageID" Type="String"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="BookingID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="StudentID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="StudentName" Type="String"></asp:Parameter>
            <asp:Parameter Name="StudentSurname" Type="String"></asp:Parameter>
            <asp:Parameter Name="InstructorID" Type="Int32"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="BookingDate"></asp:Parameter>
            <asp:Parameter DbType="Time" Name="BookingTime"></asp:Parameter>
            <asp:Parameter Name="Attendance" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="Date"></asp:Parameter>
            <asp:Parameter Name="PackageID" Type="String"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="instructorId" />
            <asp:Parameter Name="Search" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="StudentID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="StudentName" Type="String"></asp:Parameter>
            <asp:Parameter Name="StudentSurname" Type="String"></asp:Parameter>
            <asp:Parameter Name="InstructorID" Type="Int32"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="BookingDate"></asp:Parameter>
            <asp:Parameter DbType="Time" Name="BookingTime"></asp:Parameter>
            <asp:Parameter Name="Attendance" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="Date"></asp:Parameter>
            <asp:Parameter Name="PackageID" Type="String"></asp:Parameter>
            <asp:Parameter Name="original_BookingID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="original_StudentID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="original_StudentName" Type="String"></asp:Parameter>
            <asp:Parameter Name="original_StudentSurname" Type="String"></asp:Parameter>
            <asp:Parameter Name="original_InstructorID" Type="Int32"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="original_BookingDate"></asp:Parameter>
            <asp:Parameter DbType="Time" Name="original_BookingTime"></asp:Parameter>
            <asp:Parameter Name="original_Attendance" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="original_Date"></asp:Parameter>
            <asp:Parameter Name="original_PackageID" Type="String"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
     
</div>
<asp:HiddenField ID="hfStudentName" runat="server" />
<script type="text/javascript">
    function confirmMark(status) {
        var studentName = document.getElementById('<%= hfStudentName.ClientID %>').value;
    return confirm("⚠️ You are about to mark " +studentName+ " as " + status + ". Do you want to continue?");
}
</script>
   
    


