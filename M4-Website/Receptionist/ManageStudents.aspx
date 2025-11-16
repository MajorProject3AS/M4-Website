<%@ Page Title="Manage Students" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="M4_Website.Receptionist.ManageStudents" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-people"></i> Manage Students</h2>
            <asp:Button ID="btnBackToDashboard" runat="server" Text="← Back to Dashboard" 
                CssClass="btn btn-secondary" OnClick="btnBackToDashboard_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="mb-3" Visible="false"></asp:Label>

        <!-- Filter and Search Panel -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-funnel"></i> Filters</h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label for="ddlStatusFilter" class="form-label">Status</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All" Selected="True">All Statuses</asp:ListItem>
                            <asp:ListItem Value="New">New</asp:ListItem>
                            <asp:ListItem Value="Active">Active</asp:ListItem>
                            <asp:ListItem Value="Archived">Archived</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlPackageFilter" class="form-label">Package</label>
                        <asp:DropDownList ID="ddlPackageFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlPackageFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All" Selected="True">All Packages</asp:ListItem>
                            <asp:ListItem Value="STEWARD'S PACKAGE">Steward's Package</asp:ListItem>
                            <asp:ListItem Value="ROYALTY PACKAGE">Royalty Package</asp:ListItem>
                            <asp:ListItem Value="PRINCE'S PACKAGE">Prince's Package</asp:ListItem>
                            <asp:ListItem Value="FULL COURSE">Full Course</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="txtSearchStudent" class="form-label">Search Student</label>
                        <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" 
                            placeholder="Name, Surname, Email, or ID Number"></asp:TextBox>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <asp:Button ID="btnClearFilters" runat="server" Text="Clear Filters" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnClearFilters_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Students Grid -->
        <div class="card">
            <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Students List</h5>
                <span class="badge bg-light text-dark">Total: <asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvStudents" runat="server" CssClass="table table-striped table-hover" 
                        AutoGenerateColumns="False" 
                        EmptyDataText="No students found"
                        OnRowCommand="gvStudents_RowCommand"
                        DataKeyNames="StudentID">
                        <Columns>
                            <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Surname" HeaderText="Surname" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
                            <asp:BoundField DataField="PackageName" HeaderText="Package" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class="badge bg-<%# GetStatusColor(Eval("Status").ToString()) %>">
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnViewDetails" runat="server" Text="View Details" 
                                        CssClass="btn btn-sm btn-info" 
                                        CommandName="ViewDetails" 
                                        CommandArgument='<%# Eval("StudentID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Student Details Modal -->
        <asp:Panel ID="pnlStudentDetails" runat="server" CssClass="modal-overlay" Visible="false">
            <div class="modal-content-custom">
                <div class="card">
                    <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-person-circle"></i> Student Details</h5>
                        <asp:Button ID="btnCloseDetails" runat="server" Text="×" CssClass="btn-close btn-close-white" OnClick="btnCloseDetails_Click" />
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-primary">Personal Information</h6>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Student ID:</strong></td>
                                        <td><asp:Label ID="lblDetailStudentID" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Name:</strong></td>
                                        <td><asp:Label ID="lblDetailName" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Surname:</strong></td>
                                        <td><asp:Label ID="lblDetailSurname" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Email:</strong></td>
                                        <td><asp:Label ID="lblDetailEmail" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Phone:</strong></td>
                                        <td><asp:Label ID="lblDetailPhone" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>ID Number:</strong></td>
                                        <td><asp:Label ID="lblDetailIDNo" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Gender:</strong></td>
                                        <td><asp:Label ID="lblDetailGender" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Date of Birth:</strong></td>
                                        <td><asp:Label ID="lblDetailDOB" runat="server"></asp:Label></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-primary">Course Information</h6>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Package:</strong></td>
                                        <td><asp:Label ID="lblDetailPackage" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Status:</strong></td>
                                        <td><asp:Label ID="lblDetailStatus" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Registration Date:</strong></td>
                                        <td><asp:Label ID="lblDetailRegDate" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Address:</strong></td>
                                        <td><asp:Label ID="lblDetailAddress" runat="server"></asp:Label></td>
                                    </tr>
                                </table>

                                <h6 class="text-primary mt-3">Statistics</h6>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Total Payments:</strong></td>
                                        <td><asp:Label ID="lblDetailTotalPayments" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Total Bookings:</strong></td>
                                        <td><asp:Label ID="lblDetailTotalBookings" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Completed Lessons:</strong></td>
                                        <td><asp:Label ID="lblDetailCompletedLessons" runat="server"></asp:Label></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12 text-center">
                                <asp:Button ID="btnCloseDetailsBottom" runat="server" Text="Close" CssClass="btn btn-secondary" OnClick="btnCloseDetails_Click" />
                            </div>
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
            max-width: 900px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .table-responsive {
            max-height: 600px;
            overflow-y: auto;
        }
    </style>
</asp:Content>
