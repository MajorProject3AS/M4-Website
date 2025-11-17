<%@ Page Title="Receptionist Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReceptionistDashboard.aspx.cs" Inherits="M4_Website.Receptionist.ReceptionistDashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="bi bi-person-workspace"></i> Receptionist Dashboard
        </h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="mb-3" Visible="false"></asp:Label>

        <div class="row mb-4">
            <!-- Quick Stats -->
            <div class="col-md-3">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Pending Payments</h5>
                        <h2><asp:Label ID="lblPendingPayments" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-info mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Today's Bookings</h5>
                        <h2><asp:Label ID="lblTodayBookings" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Active Students</h5>
                        <h2><asp:Label ID="lblActiveStudents" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Total Bookings</h5>
                        <h2><asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation Cards -->
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-credit-card" style="font-size: 3rem; color: #ffc107;"></i>
                        <h4 class="card-title mt-3">Process Payments</h4>
                        <p class="card-text">Review and approve pending student payments</p>
                        <asp:Button ID="btnGoToPayments" runat="server" Text="MANAGE PAYMENTS" 
                            CssClass="btn btn-warning btn-lg" OnClick="btnGoToPayments_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-calendar-check" style="font-size: 3rem; color: #0dcaf0;"></i>
                        <h4 class="card-title mt-3">Manage Bookings</h4>
                        <p class="card-text">View and manage all student lesson bookings</p>
                        <asp:Button ID="btnGoToBookings" runat="server" Text="MANAGE BOOKINGS" 
                            CssClass="btn btn-info btn-lg" OnClick="btnGoToBookings_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-people" style="font-size: 3rem; color: #198754;"></i>
                        <h4 class="card-title mt-3">Manage Students</h4>
                        <p class="card-text">View and manage all registered students</p>
                        <asp:Button ID="btnGoToStudents" runat="server" Text="MANAGE STUDENTS" 
                            CssClass="btn btn-success btn-lg" OnClick="btnGoToStudents_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0"><i class="bi bi-clock-history"></i> Recent Activity</h5>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvRecentActivity" runat="server" CssClass="table table-striped table-hover" 
                            AutoGenerateColumns="False" EmptyDataText="No recent activity">
                            <Columns>
                                <asp:BoundField DataField="ActivityDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                                <asp:BoundField DataField="ActivityType" HeaderText="Type" />
                                <asp:BoundField DataField="StudentName" HeaderText="Student" />
                                <asp:BoundField DataField="Details" HeaderText="Details" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .card {
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
    </style>
</asp:Content>
