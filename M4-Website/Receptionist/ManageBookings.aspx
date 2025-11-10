<%@ Page Title="Manage Bookings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageBookings.aspx.cs" Inherits="M4_Website.Receptionist.ManageBookings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>
                <i class="bi bi-calendar2-check"></i> Manage Bookings
            </h2>
            <asp:Button ID="btnBackToDashboard" runat="server" Text="← Back to Dashboard" 
                CssClass="btn btn-secondary" OnClick="btnBackToDashboard_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="mb-3" Visible="false"></asp:Label>

        <!-- Filter Section -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-funnel"></i> Filter Bookings</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <label>Status:</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All">All Bookings</asp:ListItem>
                            <asp:ListItem Value="Confirmed" Selected="True">Confirmed</asp:ListItem>
                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label>Date Filter:</label>
                        <asp:DropDownList ID="ddlDateFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlDateFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All">All Dates</asp:ListItem>
                            <asp:ListItem Value="Today" Selected="True">Today</asp:ListItem>
                            <asp:ListItem Value="Tomorrow">Tomorrow</asp:ListItem>
                            <asp:ListItem Value="Week">This Week</asp:ListItem>
                            <asp:ListItem Value="Month">This Month</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label>Search Student:</label>
                        <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" placeholder="Student name..."></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label>&nbsp;</label>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary form-control" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Bookings Grid -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="bi bi-list-ul"></i> Lesson Bookings</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvBookings" runat="server" CssClass="table table-striped table-hover" 
                        AutoGenerateColumns="False" 
                        DataKeyNames="BookingID"
                        OnRowCommand="gvBookings_RowCommand"
                        EmptyDataText="No bookings found">
                        <Columns>
                            <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="false" />
                            <asp:BoundField DataField="Time" HeaderText="Time" HtmlEncode="false" />
                            <asp:BoundField DataField="StudentName" HeaderText="Student" />
                            <asp:BoundField DataField="InstructorName" HeaderText="Instructor" />
                            <asp:BoundField DataField="VehicleID" HeaderText="Vehicle ID" />
                            <asp:BoundField DataField="PackageName" HeaderText="Package" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge bg-<%# GetStatusColor(Eval("Status").ToString()) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnComplete" runat="server" 
                                        Text="Mark Complete" 
                                        CssClass='<%# IsBookingDatePassed(Eval("Date")) ? "btn btn-success btn-sm me-1" : "btn btn-secondary btn-sm me-1" %>'
                                        CommandName="CompleteBooking" 
                                        CommandArgument='<%# Eval("BookingID") %>'
                                        Visible='<%# Eval("Status").ToString() == "Confirmed" %>'
                                        Enabled='<%# IsBookingDatePassed(Eval("Date")) %>'
                                        OnClientClick="return confirm('Mark this booking as completed?');" 
                                        ToolTip='<%# IsBookingDatePassed(Eval("Date")) ? "Mark as complete" : "Cannot complete future bookings" %>' />
                                    <asp:Button ID="btnCancel" runat="server" 
                                        Text="Cancel" 
                                        CssClass="btn btn-danger btn-sm me-1" 
                                        CommandName="CancelBooking" 
                                        CommandArgument='<%# Eval("BookingID") %>'
                                        Visible='<%# Eval("Status").ToString() == "Confirmed" %>'
                                        OnClientClick="return confirm('Are you sure you want to cancel this booking?');" />
                                    <asp:Button ID="btnViewDetails" runat="server" 
                                        Text="View" 
                                        CssClass="btn btn-info btn-sm" 
                                        CommandName="ViewDetails" 
                                        CommandArgument='<%# Eval("BookingID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Booking Details Modal Panel -->
        <asp:Panel ID="pnlBookingDetails" runat="server" CssClass="modal-overlay" Visible="false">
            <div class="modal-content-custom">
                <div class="modal-header-custom">
                    <h4><i class="bi bi-info-circle"></i> Booking Details</h4>
                    <asp:Button ID="btnCloseDetails" runat="server" Text="×" CssClass="close-btn" OnClick="btnCloseDetails_Click" />
                </div>
                <div class="modal-body-custom">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5>Booking Information</h5>
                            <p><strong>Booking ID:</strong> <asp:Label ID="lblDetailBookingID" runat="server"></asp:Label></p>
                            <p><strong>Date:</strong> <asp:Label ID="lblDetailDate" runat="server"></asp:Label></p>
                            <p><strong>Time:</strong> <asp:Label ID="lblDetailTime" runat="server"></asp:Label></p>
                            <p><strong>Status:</strong> <asp:Label ID="lblDetailStatus" runat="server"></asp:Label></p>
                            <p><strong>Vehicle ID:</strong> <asp:Label ID="lblDetailVehicle" runat="server"></asp:Label></p>
                        </div>
                        <div class="col-md-6">
                            <h5>Student Information</h5>
                            <p><strong>Student:</strong> <asp:Label ID="lblDetailStudentName" runat="server"></asp:Label></p>
                            <p><strong>Email:</strong> <asp:Label ID="lblDetailEmail" runat="server"></asp:Label></p>
                            <p><strong>Phone:</strong> <asp:Label ID="lblDetailPhone" runat="server"></asp:Label></p>
                            <p><strong>Package:</strong> <asp:Label ID="lblDetailPackage" runat="server"></asp:Label></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h5>Instructor Information</h5>
                            <p><strong>Instructor:</strong> <asp:Label ID="lblDetailInstructor" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1050;
        }

        .modal-content-custom {
            background-color: white;
            border-radius: 8px;
            width: 90%;
            max-width: 900px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .modal-header-custom {
            background-color: #343a40;
            color: white;
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-body-custom {
            padding: 20px;
        }

        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 2rem;
            cursor: pointer;
            padding: 0;
            width: 30px;
            height: 30px;
        }

        .close-btn:hover {
            color: #ddd;
        }

        .badge {
            padding: 5px 10px;
            border-radius: 4px;
        }
    </style>
</asp:Content>
