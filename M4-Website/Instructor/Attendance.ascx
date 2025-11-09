<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attendance.ascx.cs" Inherits="M4_Website.Attendance" %>
<div style="float:left;width:35%">
    <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
</div>
<div style="float:left;width:35%">
    <asp:GridView ID="BKPac" runat="server" AutoGenerateColumns="False" DataSourceID="DSBP">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" InsertVisible="False" SortExpression="BookingID"></asp:BoundField>
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
            <asp:BoundField DataField="InstructorID" HeaderText="InstructorID" SortExpression="InstructorID"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
            <asp:BoundField DataField="PackageName" HeaderText="PackageName" SortExpression="PackageName"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="DSBP" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' SelectCommand="SELECT LessonBookingMJ.BookingID, LessonBookingMJ.StudentID, StudentMJ.Name, StudentMJ.Surname, LessonBookingMJ.InstructorID, LessonBookingMJ.Date, LessonBookingMJ.Time, PackageMJ.PackageName FROM LessonBookingMJ INNER JOIN StudentMJ ON LessonBookingMJ.StudentID = StudentMJ.StudentID INNER JOIN PackageMJ ON LessonBookingMJ.PackageID = PackageMJ.PackageName AND StudentMJ.PackageName = PackageMJ.PackageName WHERE (LessonBookingMJ.InstructorID = @instructorId) AND (LessonBookingMJ.Date = @date)">
        <SelectParameters>
            <asp:Parameter Name="instructorId"></asp:Parameter>
            <asp:ControlParameter ControlID="Calendar1" Name="date" PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="PresentBtn" runat="server" Text="Present" OnClick="PresentBtn_Click" />
    <asp:Button ID="AbsentBtn" runat="server" Text="Absent" OnClick="AbsentBtn_Click" />
    <asp:Label ID="statusLbl" runat="server" Text=" "></asp:Label>
</div>
<br /><br /><br /><br /><br /><br />
<div style="float:inline-end; margin-top: 241px;">
    <asp:GridView ID="AttendanceGV" runat="server" Width="918px" AutoGenerateColumns="False" DataKeyNames="BookingID" DataSourceID="DSAttendance">
        <Columns>
            <asp:BoundField DataField="BookingID" HeaderText="BookingID" ReadOnly="True" SortExpression="BookingID"></asp:BoundField>
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" SortExpression="StudentID"></asp:BoundField>
            <asp:BoundField DataField="StudentName" HeaderText="StudentName" SortExpression="StudentName"></asp:BoundField>
            <asp:BoundField DataField="StudentSurname" HeaderText="StudentSurname" SortExpression="StudentSurname"></asp:BoundField>
            <asp:BoundField DataField="InstructorID" HeaderText="InstructorID" SortExpression="InstructorID"></asp:BoundField>
            <asp:BoundField DataField="BookingDate" HeaderText="BookingDate" SortExpression="BookingDate"></asp:BoundField>
            <asp:BoundField DataField="BookingTime" HeaderText="BookingTime" SortExpression="BookingTime"></asp:BoundField>
            <asp:BoundField DataField="Attendance" HeaderText="Attendance" SortExpression="Attendance"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
            <asp:BoundField DataField="PackageID" HeaderText="PackageID" SortExpression="PackageID"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="DSAttendance" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString %>' DeleteCommand="DELETE FROM [LA_Sheet] WHERE [BookingID] = @original_BookingID AND (([StudentID] = @original_StudentID) OR ([StudentID] IS NULL AND @original_StudentID IS NULL)) AND (([StudentName] = @original_StudentName) OR ([StudentName] IS NULL AND @original_StudentName IS NULL)) AND (([StudentSurname] = @original_StudentSurname) OR ([StudentSurname] IS NULL AND @original_StudentSurname IS NULL)) AND (([InstructorID] = @original_InstructorID) OR ([InstructorID] IS NULL AND @original_InstructorID IS NULL)) AND (([BookingDate] = @original_BookingDate) OR ([BookingDate] IS NULL AND @original_BookingDate IS NULL)) AND (([BookingTime] = @original_BookingTime) OR ([BookingTime] IS NULL AND @original_BookingTime IS NULL)) AND (([Attendance] = @original_Attendance) OR ([Attendance] IS NULL AND @original_Attendance IS NULL)) AND (([Date] = @original_Date) OR ([Date] IS NULL AND @original_Date IS NULL)) AND (([PackageID] = @original_PackageID) OR ([PackageID] IS NULL AND @original_PackageID IS NULL))" InsertCommand="INSERT INTO [LA_Sheet] ([BookingID], [StudentID], [StudentName], [StudentSurname], [InstructorID], [BookingDate], [BookingTime], [Attendance], [Date], [PackageID]) VALUES (@BookingID, @StudentID, @StudentName, @StudentSurname, @InstructorID, @BookingDate, @BookingTime, @Attendance, @Date, @PackageID)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT BookingID, StudentID, StudentName, StudentSurname, InstructorID, BookingDate, BookingTime, Attendance, Date, PackageID FROM LA_Sheet WHERE (InstructorID = @instructorId)" UpdateCommand="UPDATE [LA_Sheet] SET [StudentID] = @StudentID, [StudentName] = @StudentName, [StudentSurname] = @StudentSurname, [InstructorID] = @InstructorID, [BookingDate] = @BookingDate, [BookingTime] = @BookingTime, [Attendance] = @Attendance, [Date] = @Date, [PackageID] = @PackageID WHERE [BookingID] = @original_BookingID AND (([StudentID] = @original_StudentID) OR ([StudentID] IS NULL AND @original_StudentID IS NULL)) AND (([StudentName] = @original_StudentName) OR ([StudentName] IS NULL AND @original_StudentName IS NULL)) AND (([StudentSurname] = @original_StudentSurname) OR ([StudentSurname] IS NULL AND @original_StudentSurname IS NULL)) AND (([InstructorID] = @original_InstructorID) OR ([InstructorID] IS NULL AND @original_InstructorID IS NULL)) AND (([BookingDate] = @original_BookingDate) OR ([BookingDate] IS NULL AND @original_BookingDate IS NULL)) AND (([BookingTime] = @original_BookingTime) OR ([BookingTime] IS NULL AND @original_BookingTime IS NULL)) AND (([Attendance] = @original_Attendance) OR ([Attendance] IS NULL AND @original_Attendance IS NULL)) AND (([Date] = @original_Date) OR ([Date] IS NULL AND @original_Date IS NULL)) AND (([PackageID] = @original_PackageID) OR ([PackageID] IS NULL AND @original_PackageID IS NULL))">
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
    
