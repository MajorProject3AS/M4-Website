<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudentProgress.ascx.cs" Inherits="M4_Website.StudentProgress" %>
<div>

</div>
<div>
    <div>
        <asp:GridView ID="GVStu" runat="server" AutoGenerateColumns="False" DataKeyNames="StudentID" DataSourceID="DSStudent" Width="940px">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="StudentID" HeaderText="StudentID" ReadOnly="True" InsertVisible="False" SortExpression="StudentID"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                <asp:BoundField DataField="PackageName" HeaderText="PackageName" SortExpression="PackageName"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="DSStudent" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString2 %>' SelectCommand="SELECT * FROM [StudentMJ]"></asp:SqlDataSource>
        <asp:Button ID="Addbtn" runat="server" Text="Add Student to Evaluations" Width="198px" OnClick="Addbtn_Click1" />
        <asp:Label ID="StatusLbl" runat="server" Text=" "></asp:Label>
    </div>
    <div>
        <div>
            <asp:GridView ID="GVProgress" runat="server" AutoGenerateColumns="False" DataKeyNames="StudentID" DataSourceID="DSProgress">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="StudentID" HeaderText="StudentID" ReadOnly="True" SortExpression="StudentID"></asp:BoundField>
                    <asp:BoundField DataField="StudentName" HeaderText="StudentName" SortExpression="StudentName"></asp:BoundField>
                    <asp:BoundField DataField="StudentSurname" HeaderText="StudentSurname" SortExpression="StudentSurname"></asp:BoundField>
                    <asp:BoundField DataField="PreTripChecks" HeaderText="PreTripChecks" SortExpression="PreTripChecks"></asp:BoundField>
                    <asp:BoundField DataField="VehicleControl" HeaderText="VehicleControl" SortExpression="VehicleControl"></asp:BoundField>
                    <asp:BoundField DataField="SpeedNGearControl" HeaderText="SpeedNGearControl" SortExpression="SpeedNGearControl"></asp:BoundField>
                    <asp:BoundField DataField="ObservationalNDefensiveDriving" HeaderText="ObservationalNDefensiveDriving" SortExpression="ObservationalNDefensiveDriving"></asp:BoundField>
                    <asp:BoundField DataField="ControlledIntersections" HeaderText="ControlledIntersections" SortExpression="ControlledIntersections"></asp:BoundField>
                    <asp:BoundField DataField="UncontrolledIntersections" HeaderText="UncontrolledIntersections" SortExpression="UncontrolledIntersections"></asp:BoundField>
                    <asp:BoundField DataField="HillStartsNGradientControl" HeaderText="HillStartsNGradientControl" SortExpression="HillStartsNGradientControl"></asp:BoundField>
                    <asp:BoundField DataField="ParkingNReversing" HeaderText="ParkingNReversing" SortExpression="ParkingNReversing"></asp:BoundField>
                    <asp:BoundField DataField="LaneChangingNOvertaking" HeaderText="LaneChangingNOvertaking" SortExpression="LaneChangingNOvertaking"></asp:BoundField>
                    <asp:BoundField DataField="FreewayDriving" HeaderText="FreewayDriving" SortExpression="FreewayDriving"></asp:BoundField>
                    <asp:BoundField DataField="MockTest" HeaderText="MockTest" SortExpression="MockTest"></asp:BoundField>
                    <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="DSProgress" ConflictDetection="CompareAllValues" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString2 %>' DeleteCommand="DELETE FROM [StudentProgress] WHERE [StudentID] = @original_StudentID AND [StudentName] = @original_StudentName AND [StudentSurname] = @original_StudentSurname AND (([PreTripChecks] = @original_PreTripChecks) OR ([PreTripChecks] IS NULL AND @original_PreTripChecks IS NULL)) AND (([VehicleControl] = @original_VehicleControl) OR ([VehicleControl] IS NULL AND @original_VehicleControl IS NULL)) AND (([SpeedNGearControl] = @original_SpeedNGearControl) OR ([SpeedNGearControl] IS NULL AND @original_SpeedNGearControl IS NULL)) AND (([ObservationalNDefensiveDriving] = @original_ObservationalNDefensiveDriving) OR ([ObservationalNDefensiveDriving] IS NULL AND @original_ObservationalNDefensiveDriving IS NULL)) AND (([ControlledIntersections] = @original_ControlledIntersections) OR ([ControlledIntersections] IS NULL AND @original_ControlledIntersections IS NULL)) AND (([UncontrolledIntersections] = @original_UncontrolledIntersections) OR ([UncontrolledIntersections] IS NULL AND @original_UncontrolledIntersections IS NULL)) AND (([HillStartsNGradientControl] = @original_HillStartsNGradientControl) OR ([HillStartsNGradientControl] IS NULL AND @original_HillStartsNGradientControl IS NULL)) AND (([ParkingNReversing] = @original_ParkingNReversing) OR ([ParkingNReversing] IS NULL AND @original_ParkingNReversing IS NULL)) AND (([LaneChangingNOvertaking] = @original_LaneChangingNOvertaking) OR ([LaneChangingNOvertaking] IS NULL AND @original_LaneChangingNOvertaking IS NULL)) AND (([FreewayDriving] = @original_FreewayDriving) OR ([FreewayDriving] IS NULL AND @original_FreewayDriving IS NULL)) AND (([MockTest] = @original_MockTest) OR ([MockTest] IS NULL AND @original_MockTest IS NULL)) AND (([Comments] = @original_Comments) OR ([Comments] IS NULL AND @original_Comments IS NULL))" InsertCommand="INSERT INTO StudentProgress(StudentID, StudentName, StudentSurname) VALUES (@StudentID, @StudentName, @StudentSurname)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [StudentProgress]" UpdateCommand="UPDATE [StudentProgress] SET [StudentName] = @StudentName, [StudentSurname] = @StudentSurname, [PreTripChecks] = @PreTripChecks, [VehicleControl] = @VehicleControl, [SpeedNGearControl] = @SpeedNGearControl, [ObservationalNDefensiveDriving] = @ObservationalNDefensiveDriving, [ControlledIntersections] = @ControlledIntersections, [UncontrolledIntersections] = @UncontrolledIntersections, [HillStartsNGradientControl] = @HillStartsNGradientControl, [ParkingNReversing] = @ParkingNReversing, [LaneChangingNOvertaking] = @LaneChangingNOvertaking, [FreewayDriving] = @FreewayDriving, [MockTest] = @MockTest, [Comments] = @Comments WHERE [StudentID] = @original_StudentID AND [StudentName] = @original_StudentName AND [StudentSurname] = @original_StudentSurname AND (([PreTripChecks] = @original_PreTripChecks) OR ([PreTripChecks] IS NULL AND @original_PreTripChecks IS NULL)) AND (([VehicleControl] = @original_VehicleControl) OR ([VehicleControl] IS NULL AND @original_VehicleControl IS NULL)) AND (([SpeedNGearControl] = @original_SpeedNGearControl) OR ([SpeedNGearControl] IS NULL AND @original_SpeedNGearControl IS NULL)) AND (([ObservationalNDefensiveDriving] = @original_ObservationalNDefensiveDriving) OR ([ObservationalNDefensiveDriving] IS NULL AND @original_ObservationalNDefensiveDriving IS NULL)) AND (([ControlledIntersections] = @original_ControlledIntersections) OR ([ControlledIntersections] IS NULL AND @original_ControlledIntersections IS NULL)) AND (([UncontrolledIntersections] = @original_UncontrolledIntersections) OR ([UncontrolledIntersections] IS NULL AND @original_UncontrolledIntersections IS NULL)) AND (([HillStartsNGradientControl] = @original_HillStartsNGradientControl) OR ([HillStartsNGradientControl] IS NULL AND @original_HillStartsNGradientControl IS NULL)) AND (([ParkingNReversing] = @original_ParkingNReversing) OR ([ParkingNReversing] IS NULL AND @original_ParkingNReversing IS NULL)) AND (([LaneChangingNOvertaking] = @original_LaneChangingNOvertaking) OR ([LaneChangingNOvertaking] IS NULL AND @original_LaneChangingNOvertaking IS NULL)) AND (([FreewayDriving] = @original_FreewayDriving) OR ([FreewayDriving] IS NULL AND @original_FreewayDriving IS NULL)) AND (([MockTest] = @original_MockTest) OR ([MockTest] IS NULL AND @original_MockTest IS NULL)) AND (([Comments] = @original_Comments) OR ([Comments] IS NULL AND @original_Comments IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_StudentID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="original_StudentName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_StudentSurname" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_PreTripChecks" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_VehicleControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_SpeedNGearControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ObservationalNDefensiveDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ControlledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_UncontrolledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_HillStartsNGradientControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ParkingNReversing" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_LaneChangingNOvertaking" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_FreewayDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_MockTest" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Comments" Type="String"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="StudentID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="StudentName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="StudentSurname" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="StudentName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="StudentSurname" Type="String"></asp:Parameter>
                    <asp:Parameter Name="PreTripChecks" Type="String"></asp:Parameter>
                    <asp:Parameter Name="VehicleControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="SpeedNGearControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="ObservationalNDefensiveDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="ControlledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="UncontrolledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="HillStartsNGradientControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="ParkingNReversing" Type="String"></asp:Parameter>
                    <asp:Parameter Name="LaneChangingNOvertaking" Type="String"></asp:Parameter>
                    <asp:Parameter Name="FreewayDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MockTest" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Comments" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_StudentID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="original_StudentName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_StudentSurname" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_PreTripChecks" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_VehicleControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_SpeedNGearControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ObservationalNDefensiveDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ControlledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_UncontrolledIntersections" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_HillStartsNGradientControl" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_ParkingNReversing" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_LaneChangingNOvertaking" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_FreewayDriving" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_MockTest" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_Comments" Type="String"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        
        
    </div>
</div><div>
     
</div>