<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyProgress.aspx.cs" Inherits="M4_Website.Student.MyProgress" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>My Progress & Instructor Comments</h2>
            <a href="Dashboard.aspx" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3" Visible="false" />

        <!-- Student Progress Comments Section -->
        <div class="card mb-4">
            <div class="card-header bg-secondary text-white">
                <h4 class="mb-0">Instructor Evaluations & Feedback</h4>
            </div>
            <div class="card-body">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> <strong>Note:</strong> This shows your driving progress across different skills. 
                    Your instructor updates these evaluations after each lesson.
                </div>
                
                <asp:GridView ID="gvProgressComments" runat="server" CssClass="table table-striped table-hover table-responsive" 
                    AutoGenerateColumns="False" EmptyDataText="No progress records found yet. Complete lessons to see instructor feedback!">
                    <Columns>
                        <asp:BoundField DataField="StudentName" HeaderText="Student" />
                        <asp:BoundField DataField="PreTripChecks" HeaderText="Pre-Trip Checks" />
                        <asp:BoundField DataField="VehicleControl" HeaderText="Vehicle Control" />
                        <asp:BoundField DataField="SpeedNGearControl" HeaderText="Speed & Gear Control" />
                        <asp:BoundField DataField="ObservationalNDefensive" HeaderText="Observational & Defensive" />
                        <asp:BoundField DataField="ControlledIntersections" HeaderText="Controlled Intersections" />
                        <asp:BoundField DataField="UncontrolledIntersections" HeaderText="Uncontrolled Intersections" />
                        <asp:BoundField DataField="HillStartsNGradientControl" HeaderText="Hill Starts & Gradient" />
                        <asp:BoundField DataField="ParkingNReversing" HeaderText="Parking & Reversing" />
                        <asp:BoundField DataField="LaneChangingNOvertaking" HeaderText="Lane Changing & Overtaking" />
                        <asp:BoundField DataField="FreewayDriving" HeaderText="Freeway Driving" />
                        <asp:BoundField DataField="MockTest" HeaderText="Mock Test" />
                        <asp:TemplateField HeaderText="Instructor Comments">
                            <ItemTemplate>
                                <div style="max-width: 300px; white-space: normal;">
                                    <asp:Label ID="lblComments" runat="server" 
                                        Text='<%# string.IsNullOrEmpty(Eval("Comments").ToString()) ? "No comments yet" : Eval("Comments") %>' 
                                        CssClass='<%# string.IsNullOrEmpty(Eval("Comments").ToString()) ? "text-muted fst-italic" : "" %>' />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
