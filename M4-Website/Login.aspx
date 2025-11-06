<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="M4_Website.Login" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Top Header -->
    <div class="py-5 text-center text-white" style="background-color: #8B0000;">
        <h1 class="fw-bold">Welcome Back</h1>
        <p>Sign in to your TLG Driving School account</p>
    </div>

    <!-- Login Form -->
    <div class="container my-5 pt-3">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body">

                        <div id="loginForm">
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Email Address</label>
                                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Enter your email" TextMode="Email" required="required" />
                            </div>

                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" placeholder="Enter your password" TextMode="Password" required="required" />
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="form-check">
                                    <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                                    <label class="form-check-label" for="chkRemember">Remember me</label>
                                </div>
                                <a href="#" class="text-danger">Forgot password?</a>
                            </div>

                            <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-danger w-100" OnClick="btnLogin_Click" />
                        </div>

                        <div class="text-center mt-3">
                            <span>New here? <a href="Register.aspx" class="text-danger fw-bold">Create Account</a></span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

