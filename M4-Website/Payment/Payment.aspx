<%@ Page Title="Payment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="M4_Website.Payment.Payment" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <h2>Payment</h2>
                <hr />

                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="card-title">Package Information</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Package:</strong> <asp:Label ID="lblPackageName" runat="server" /></p>
                                <p><strong>Student ID:</strong> <asp:Label ID="lblStudentID" runat="server" /></p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Amount to Pay:</strong> <asp:Label ID="lblAmountToPay" runat="server" CssClass="text-primary h5" /></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Payment Details</h4>

                        <div class="form-group mb-3">
                            <label for="ddlPaymentMethod">Payment Method</label>
                            <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
                                <asp:ListItem Value="">-- Select Payment Method --</asp:ListItem>
                                <asp:ListItem Value="Credit Card">Credit Card</asp:ListItem>
                                <asp:ListItem Value="Debit Card">Debit Card</asp:ListItem>
                                <asp:ListItem Value="Bank Transfer">Bank Transfer</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvPaymentMethod" runat="server" 
                                ControlToValidate="ddlPaymentMethod" 
                                InitialValue=""
                                ErrorMessage="Payment method is required" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                            <small class="form-text text-muted">Cash payments can only be made at our branch</small>
                        </div>

                        <!-- Bank Transfer Details -->
                        <asp:Panel ID="pnlBankTransfer" runat="server" Visible="false" CssClass="mb-3">
                            <div class="alert alert-info">
                                <h5><i class="bi bi-bank"></i> Bank Transfer Details</h5>
                                <hr />
                                <p><strong>Bank Name:</strong> First National Bank (FNB)</p>
                                <p><strong>Account Name:</strong> TLG Driving School</p>
                                <p><strong>Account Number:</strong> 62587410258</p>
                                <p><strong>Branch Code:</strong> 250655</p>
                                <p><strong>Account Type:</strong> Business Cheque Account</p>
                                <p><strong>Reference:</strong> <asp:Label ID="lblTransferReference" runat="server" CssClass="text-danger fw-bold" /></p>
                                <hr />
                                <div class="alert alert-warning mt-3">
                                    <h6><i class="bi bi-envelope"></i> Proof of Payment</h6>
                                    <p class="mb-1">Please email your proof of payment to:</p>
                                    <p class="mb-0"><strong>Email:</strong> <a href="mailto:payments@tlgdrivingschool.co.za">payments@tlgdrivingschool.co.za</a></p>
                                    <small class="text-muted">Please include your Student ID (<asp:Label ID="lblEmailReference" runat="server" CssClass="fw-bold" />) in the email subject line</small>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Card Payment Details -->
                        <asp:Panel ID="pnlCardPayment" runat="server" Visible="false" CssClass="mb-3">
                            <div class="alert alert-secondary">
                                <h5><i class="bi bi-credit-card"></i> Card Payment Information</h5>
                            </div>
                            
                            <div class="form-group mb-3">
                                <label for="txtCardHolderName">Cardholder Name</label>
                                <asp:TextBox ID="txtCardHolderName" runat="server" CssClass="form-control" placeholder="Name as it appears on card" MaxLength="100" />
                                <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                                    ControlToValidate="txtCardHolderName" 
                                    ErrorMessage="Cardholder name is required" 
                                    CssClass="text-danger" 
                                    Display="Dynamic"
                                    Enabled="false" />
                            </div>

                            <div class="form-group mb-3">
                                <label for="txtCardNumber">Card Number</label>
                                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="1234 5678 9012 3456" MaxLength="19" />
                                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                                    ControlToValidate="txtCardNumber" 
                                    ErrorMessage="Card number is required" 
                                    CssClass="text-danger" 
                                    Display="Dynamic"
                                    Enabled="false" />
                                <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                                    ControlToValidate="txtCardNumber" 
                                    ErrorMessage="Invalid card number format" 
                                    ValidationExpression="^[0-9\s]{13,19}$" 
                                    CssClass="text-danger" 
                                    Display="Dynamic"
                                    Enabled="false" />
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="txtExpiryDate">Expiry Date (MM/YY)</label>
                                        <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" placeholder="MM/YY" MaxLength="5" />
                                        <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" 
                                            ControlToValidate="txtExpiryDate" 
                                            ErrorMessage="Expiry date is required" 
                                            CssClass="text-danger" 
                                            Display="Dynamic"
                                            Enabled="false" />
                                        <asp:RegularExpressionValidator ID="revExpiryDate" runat="server" 
                                            ControlToValidate="txtExpiryDate" 
                                            ErrorMessage="Invalid format (MM/YY)" 
                                            ValidationExpression="^(0[1-9]|1[0-2])\/[0-9]{2}$" 
                                            CssClass="text-danger" 
                                            Display="Dynamic"
                                            Enabled="false" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="txtCVV">CVV</label>
                                        <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="123" MaxLength="4" TextMode="Password" />
                                        <asp:RequiredFieldValidator ID="rfvCVV" runat="server" 
                                            ControlToValidate="txtCVV" 
                                            ErrorMessage="CVV is required" 
                                            CssClass="text-danger" 
                                            Display="Dynamic"
                                            Enabled="false" />
                                        <asp:RegularExpressionValidator ID="revCVV" runat="server" 
                                            ControlToValidate="txtCVV" 
                                            ErrorMessage="Invalid CVV (3-4 digits)" 
                                            ValidationExpression="^[0-9]{3,4}$" 
                                            CssClass="text-danger" 
                                            Display="Dynamic"
                                            Enabled="false" />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="alert alert-info">
                            <strong>Payment Amount:</strong> <asp:Label ID="lblFullAmount" runat="server" />
                            <br />
                            <small>Full payment is required for the package</small>
                        </div>

                        <div class="form-group mb-3">
                            <asp:CheckBox ID="chkConfirmAmount" runat="server" />
                            <label for="chkConfirmAmount" class="ms-2">I confirm that I will pay the full amount of <asp:Label ID="lblConfirmAmount" runat="server" CssClass="fw-bold" /></label>
                            <br />
                            <asp:CustomValidator ID="cvConfirmAmount" runat="server" 
                                ErrorMessage="You must confirm the payment amount" 
                                CssClass="text-danger" 
                                Display="Dynamic"
                                ClientValidationFunction="ValidateCheckbox" />
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnProcessPayment" runat="server" Text="Process Payment" CssClass="btn btn-success btn-lg" OnClick="btnProcessPayment_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClick="btnCancel_Click" CausesValidation="false" />
                        </div>

                        <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function ValidateCheckbox(sender, args) {
            var checkbox = document.getElementById('<%= chkConfirmAmount.ClientID %>');
            args.IsValid = checkbox.checked;
        }
    </script>
</asp:Content>
