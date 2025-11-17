<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="M4_Website.Account.ResetPassword" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>

        <p class="text-danger"><asp:Literal runat="server" ID="ErrorMessage" /></p>

        <div>
            <h4>Enter your new password</h4>
            <hr />

            <asp:ValidationSummary runat="server" CssClass="text-danger" />

            <div class="row">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 col-form-label">Password</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password" />
                    <asp:RequiredFieldValidator ControlToValidate="Password" runat="server"
                        ErrorMessage="Required" CssClass="text-danger" />
                </div>
            </div>

            <div class="row">
                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 col-form-label">Confirm Password</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    <asp:CompareValidator runat="server" ControlToValidate="ConfirmPassword"
                        ControlToCompare="Password" ErrorMessage="Passwords must match"
                        CssClass="text-danger" />
                </div>
            </div>

            <div class="row mt-3">
                <div class="offset-md-2 col-md-10">
                    <asp:Button runat="server" Text="Reset Password" OnClick="Reset_Click" CssClass="btn btn-outline-dark" />
                </div>
            </div>
        </div>
    </main>
</asp:Content>

