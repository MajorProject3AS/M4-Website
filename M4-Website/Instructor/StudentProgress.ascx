<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudentProgress.ascx.cs" Inherits="M4_Website.StudentProgress" %>

<style>
        .wrapper {
    width: 100%;
    max-width: 900px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 30px;

}
        .Gwrap {
   overflow-x: auto;
    overflow-y: auto;
    border: 1px solid #ccc;
    padding: 5px;
background-color: #fff;
    max-height: 300px;

}
        .Gwrapper {
       overflow-x: auto;
    overflow-y: auto;
    border: 1px solid #ccc;
    padding: 5px;
background-color: #fff;
    max-height: 300px;


}
        .GV {
    width: max-content; /* allows horizontal scroll if content exceeds container */
    border-collapse: collapse;
    font-size: 13px;
    


    
}

.GV th, .GV td {
     border: 1px solid #ccc;
    padding: 4px 8px;
    text-align: left;
    white-space: nowrap; /* prevents wrapping */

}
.GV th {
   background-color: #f2f2f2;
    font-weight: bold;
    color: #333;

}
.GP {
   width: max-content; /* allows horizontal scroll if content exceeds container */
    border-collapse: collapse;
    font-size: 13px;
    background-color: #fff;

}

.GP th, .GP td {
     border: 1px solid #ccc;
padding: 4px 8px;
text-align: left;
white-space: nowrap; /* prevents wrapping */

}
.GP th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;

}
/* Submit buttons */
.BTN {
    padding: 8px 16px;
    background-color: #c00;
    color: white;
    border: none;
    cursor: pointer;
    font-weight: bold;
}

.BTN:hover {
    background-color: #900;
}
/* Dropdown styling inside GridView */
.DD {
    padding: 4px;
    font-size: 13px;
    border-radius: 4px;
    border: 1px solid #ccc;
}

/* Comment box styling */
.comment-box {
    width: 100%;
    padding: 10px;
    font-family: Arial, sans-serif;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
}


</style>
<div class="wrapper">
    <div class="Gwrap">
        <asp:Label ID="Instr" runat="server" Text="*Select student to add to evaluations." ForeColor="#CC0000" Font-Italic="True" Font-Size="Small"></asp:Label>
        <asp:GridView ID="GVStu" runat="server" AutoGenerateColumns="False" DataKeyNames="StudentID" DataSourceID="DSStudent" Width="940px" CssClass="GV" OnSelectedIndexChanged="GVStu_SelectedIndexChanged" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="StudentID" HeaderText="StudentID" ReadOnly="True" InsertVisible="False" SortExpression="StudentID"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                <asp:BoundField DataField="PackageName" HeaderText="PackageName" SortExpression="PackageName" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="DSStudent" ConnectionString='<%$ ConnectionStrings:WstGrp24ConnectionString2 %>' SelectCommand="SELECT * FROM [StudentMJ]"></asp:SqlDataSource>
        
    </div>
    <span>
<asp:Button ID="Addbtn" runat="server" Text="Add Student to Evaluations" Width="198px" OnClientClick="return confirmProgressAction('add');"
 OnClick="Addbtn_Click1" CssClass="BTN" />
    </span>
  <asp:Label ID="StatusLbl" runat="server" Text=" "></asp:Label>
    <div>
        <div class="Gwrapper">
            <h3>
                <asp:Label ID="Label1" runat="server" Text="Student Evaluations" Font-Bold="True" ForeColor="Black" Font-Size="Large"></asp:Label>
            </h3>
            <asp:Label ID="In" runat="server" Text="*Select student to submit rating or comment." Font-Italic="True" ForeColor="#CC0000" Font-Size="Small"></asp:Label>
            <asp:GridView ID="GVProgress" runat="server" AutoGenerateColumns="False" DataKeyNames="StudentID" DataSourceID="DSProgress" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="GP" OnSelectedIndexChanged="GVProgress_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
        <span>
            <asp:DropDownList ID="SkillDDL" runat="server" AutoPostBack="True" CssClass="DD">
                <asp:ListItem Text="Pre Trip Checks" Value="PreTripChecks"></asp:ListItem>
                <asp:ListItem Text="Vehicle Control" Value="VehicleControl"></asp:ListItem>
                <asp:ListItem Text="Speed and Gear Control" Value="SpeedNGearControl"></asp:ListItem>
                <asp:ListItem Text="Observational and Defensive Driving" Value="ObservationalNDefensiveDriving"></asp:ListItem>
                <asp:ListItem Text="Controlled Intersections" Value="ControlledIntersections"></asp:ListItem>
                <asp:ListItem Text="Uncontrolled Intersections" Value="UncontrolledIntersections"></asp:ListItem>
                <asp:ListItem Text="Hill Starts and Gradient Control" Value="HillStartsNGradientControl"></asp:ListItem>
                <asp:ListItem Text="Parking and Reversing" Value="ParkingNReversing"></asp:ListItem>
                <asp:ListItem Text="Lane Changing and Overtaking" Value="LaneChangingNOvertaking"></asp:ListItem>
                <asp:ListItem Text="Freeway Driving" Value="FreewayDriving"></asp:ListItem>
                <asp:ListItem Text="Mock Test" Value="MockTest"></asp:ListItem>
            </asp:DropDownList>
        </span>
        <br /><br />
         <span>
             <asp:DropDownList ID="RatingDDL" runat="server" AutoPostBack="True" CssClass="DD">
                 <asp:ListItem Text="Excellent" Value="Excellent"></asp:ListItem>
                <asp:ListItem Text="Satisfactory" Value="Satisfactory"></asp:ListItem>
                <asp:ListItem Text="Unsatisfactory" Value="Unsatisfactory"></asp:ListItem>
                
             </asp:DropDownList>
 </span>
       <div>
     
    <asp:Button ID="SubmitBtn" runat="server" Text="Submit Rating"  OnClientClick="return confirmProgressAction('rating');"
 OnClick="SubmitBtn_Click" CssClass="BTN" />
     
</div> 
        
        
        <span style="float:right;width:40%;">
            <asp:TextBox ID="TextBox1" runat="server" Height="55px" TextMode="MultiLine" Width="363px" CssClass="TX"></asp:TextBox>
           <asp:Button ID="Button1" runat="server" Text="Submit Comment" OnClientClick="return confirmProgressAction('comment');"
 OnClick="Button1_Click" CssClass="BTN" />
        </span>
        
    </div>

</div>
<asp:HiddenField ID="StudentName" runat="server" />
<script type="text/javascript">
    function confirmProgressAction(actionType) {
        var studentName = document.getElementById('<%= StudentName.ClientID %>').value;
        var message = "";

        switch (actionType) {
            case 'add':
                message = "⚠️ You are about to add " + studentName + " to Student Evaluations. Do you want to continue?";
                break;
            case 'rating':
                message = "⚠️ You are about to submit skill ratings for " + studentName + ". Do you want to continue?";
                break;
            case 'comment':
                message = "⚠️ You are about to submit a comment for " + studentName + ". Do you want to continue?";
                break;
        }

        return confirm(message);
    }
</script>

