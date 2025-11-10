<%@ Page Title="Process Payments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessPayments.aspx.cs" Inherits="M4_Website.Receptionist.ProcessPayments" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>
                <i class="bi bi-credit-card-2-back"></i> Process Payments
            </h2>
            <asp:Button ID="btnBackToDashboard" runat="server" Text="← Back to Dashboard" 
                CssClass="btn btn-secondary" OnClick="btnBackToDashboard_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="mb-3" Visible="false"></asp:Label>

        <!-- Info Alert -->
        <div class="alert alert-info" role="alert">
            <i class="bi bi-info-circle"></i> <strong>Note:</strong> Only Bank Transfer payments require manual approval. Credit Card payments are automatically processed and students can proceed with booking lessons immediately upon successful payment.
        </div>

        <!-- Filter Section -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-funnel"></i> Filter Payments</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <label>Status:</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All">All Payments</asp:ListItem>
                            <asp:ListItem Value="Processing" Selected="True">Processing</asp:ListItem>
                            <asp:ListItem Value="Paid">Paid</asp:ListItem>
                            <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label>Search by Student Name:</label>
                        <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" placeholder="Enter student name..."></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>&nbsp;</label>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary form-control" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Payments Grid -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="bi bi-list-check"></i> Payment Records</h5>
            </div>
            <div class="card-body">
                <asp:GridView ID="gvPayments" runat="server" CssClass="table table-striped table-hover" 
                    AutoGenerateColumns="False" 
                    DataKeyNames="PaymentID"
                    OnRowCommand="gvPayments_RowCommand"
                    EmptyDataText="No payments found">
                    <Columns>
                        <asp:BoundField DataField="PaymentID" HeaderText="Payment ID" />
                        <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="PackageName" HeaderText="Package" />
                        <asp:BoundField DataField="AmountPaid" HeaderText="Amount" DataFormatString="R{0:N2}" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method" />
                        <asp:BoundField DataField="PaymentDate" HeaderText="Payment Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='badge bg-<%# GetStatusColor(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnApprove" runat="server" 
                                    Text="Approve" 
                                    CssClass="btn btn-success btn-sm me-1" 
                                    CommandName="ApprovePayment" 
                                    CommandArgument='<%# Eval("PaymentID") %>'
                                    Visible='<%# Eval("Status").ToString() == "Processing" %>'
                                    OnClientClick="return confirm('Are you sure you want to approve this payment?');" />
                                <asp:Button ID="btnReject" runat="server" 
                                    Text="Reject" 
                                    CssClass="btn btn-danger btn-sm" 
                                    CommandName="RejectPayment" 
                                    CommandArgument='<%# Eval("PaymentID") %>'
                                    Visible='<%# Eval("Status").ToString() == "Processing" %>'
                                    OnClientClick="return confirm('Are you sure you want to reject this payment?');" />
                                <asp:Button ID="btnViewDetails" runat="server" 
                                    Text="View" 
                                    CssClass="btn btn-info btn-sm" 
                                    CommandName="ViewDetails" 
                                    CommandArgument='<%# Eval("PaymentID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Payment Details Modal Panel -->
        <asp:Panel ID="pnlPaymentDetails" runat="server" CssClass="modal-overlay" Visible="false">
            <div class="modal-content-custom">
                <div class="modal-header-custom">
                    <h4><i class="bi bi-file-text"></i> Payment Details</h4>
                    <asp:Button ID="btnCloseDetails" runat="server" Text="×" CssClass="close-btn" OnClick="btnCloseDetails_Click" />
                </div>
                <div class="modal-body-custom">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Payment ID:</strong> <asp:Label ID="lblDetailPaymentID" runat="server"></asp:Label></p>
                            <p><strong>Student:</strong> <asp:Label ID="lblDetailStudentName" runat="server"></asp:Label></p>
                            <p><strong>Email:</strong> <asp:Label ID="lblDetailEmail" runat="server"></asp:Label></p>
                            <p><strong>Phone:</strong> <asp:Label ID="lblDetailPhone" runat="server"></asp:Label></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Package:</strong> <asp:Label ID="lblDetailPackage" runat="server"></asp:Label></p>
                            <p><strong>Amount Paid:</strong> <asp:Label ID="lblDetailAmount" runat="server"></asp:Label></p>
                            <p><strong>Payment Method:</strong> <asp:Label ID="lblDetailMethod" runat="server"></asp:Label></p>
                            <p><strong>Payment Date:</strong> <asp:Label ID="lblDetailDate" runat="server"></asp:Label></p>
                            <p><strong>Status:</strong> <asp:Label ID="lblDetailStatus" runat="server"></asp:Label></p>
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
            max-width: 800px;
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
