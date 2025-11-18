<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="M4_Website.Student.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <!-- Message Banner at the top -->
        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3" Visible="false" />
        
        <h2>Student Dashboard</h2>
        <hr />

        <!-- Personal Information Section -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">My Information</h4>
            </div>
            <div class="card-body">
                <asp:Panel ID="pnlView" runat="server" Visible="true">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> <asp:Label ID="lblName" runat="server" /></p>
                            <p><strong>Surname:</strong> <asp:Label ID="lblSurname" runat="server" /></p>
                            <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></p>
                            <p><strong>Phone Number:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
                            <p><strong>ID Number:</strong> <asp:Label ID="lblIDNo" runat="server" /></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Gender:</strong> <asp:Label ID="lblGender" runat="server" /></p>
                            <p><strong>Address:</strong> <asp:Label ID="lblAddress" runat="server" /></p>
                            <p><strong>Package:</strong> <asp:Label ID="lblPackage" runat="server" /></p>
                            <p><strong>Status:</strong> <asp:Label ID="lblStatus" runat="server" /></p>
                        </div>
                    </div>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit Information" CssClass="btn btn-primary" OnClick="btnEdit_Click" />
                </asp:Panel>

                <asp:Panel ID="pnlEdit" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label>Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>Surname</label>
                                <asp:TextBox ID="txtSurname" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Gender --</asp:ListItem>
                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label>Street Number</label>
                                <asp:TextBox ID="txtStreetNumber" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>Street Name</label>
                                <asp:TextBox ID="txtStreetName" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label>Postal Code</label>
                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-success" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClick="btnCancel_Click" CausesValidation="false" />
                </asp:Panel>
            </div>
        </div>

        <!-- Package Progress Section -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white">
                <h4 class="mb-0">Package Progress</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="text-center">
                            <h3 class="text-primary"><asp:Label ID="lblTotalLessons" runat="server" Text="0" /></h3>
                            <p>Total Lessons</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center">
                            <h3 class="text-success"><asp:Label ID="lblCompletedLessons" runat="server" Text="0" /></h3>
                            <p>Completed Lessons</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center">
                            <h3 class="text-warning"><asp:Label ID="lblRemainingLessons" runat="server" Text="0" /></h3>
                            <p>Lessons Remaining</p>
                        </div>
                    </div>
                </div>
                <div class="progress mt-3" style="height: 30px;">
                    <div id="progressBar" runat="server" class="progress-bar bg-success" role="progressbar" style="width: 0%">
                        <asp:Label ID="lblProgress" runat="server" Text="0%" />
                    </div>
                </div>
            </div>
        </div>

        <!-- My Bookings Section -->
        <div class="card mb-4">
            <div class="card-header bg-info text-white">
                <h4 class="mb-0">My Lesson Bookings</h4>
            </div>
            <div class="card-body">
                <asp:GridView ID="gvBookings" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" EmptyDataText="No bookings found."
                    OnRowCommand="gvBookings_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:hh\:mm}" />
                        <asp:BoundField DataField="InstructorName" HeaderText="Instructor" />
                        <asp:BoundField DataField="VehicleID" HeaderText="Vehicle" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnCancelBooking" runat="server" 
                                    Text="Cancel" 
                                    CssClass="btn btn-sm btn-danger" 
                                    CommandName="CancelBooking" 
                                    CommandArgument='<%# Eval("BookingID") %>'
                                    OnClientClick="return confirm('Are you sure you want to cancel this booking?');"
                                    Visible='<%# IsBookingCancellable(Eval("Date"), Eval("Time"), Eval("Status").ToString()) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div class="mt-3">
                    <a href="/Booking/BookLesson.aspx" class="btn btn-primary">Book New Lesson</a>
                </div>
            </div>
        </div>

        <!-- Payment Status Section -->
        <div class="card mb-4">
            <div class="card-header bg-warning text-dark">
                <h4 class="mb-0">Payment Information</h4>
            </div>
            <div class="card-body">
                <p><strong>Payment Method:</strong> <asp:Label ID="lblPaymentMethod" runat="server" /></p>
                <p><strong>Amount Paid:</strong> R<asp:Label ID="lblAmountPaid" runat="server" /></p>
                <p><strong>Payment Date:</strong> <asp:Label ID="lblPaymentDate" runat="server" /></p>
                <p><strong>Status:</strong> <asp:Label ID="lblPaymentStatus" runat="server" /></p>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="card mb-4">
            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">Quick Actions</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="/Booking/BookLesson.aspx" class="btn btn-primary btn-lg w-100">
                            <i class="bi bi-calendar-plus"></i> Book New Lesson
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="MyProgress.aspx" class="btn btn-secondary btn-lg w-100">
                            <i class="bi bi-graph-up"></i> View My Progress
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
