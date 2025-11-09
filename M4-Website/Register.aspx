<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="M4_Website.Register" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Top Header -->
    <div class="py-5 text-center text-white" style="background-color: #8B0000;">
        <h1 class="fw-bold">Create Account</h1>
        <p>Join TLG Driving School and start your journey</p>
    </div>

    <!-- Registration Form -->
    <div class="container my-5 pt-3">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body">

                        <div id="registerForm">
                            <div class="mb-3">
                                <label for="txtFullName" class="form-label">Full Name</label>
                                <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server" placeholder="Enter your full name" required="required" />
                            </div>

                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Email Address</label>
                                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Enter your email" TextMode="Email" required="required" />
                            </div>

                            <div class="mb-3">
                                <label for="txtPhone" class="form-label">Phone Number</label>
                                <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" placeholder="Enter your phone number" required="required" />
                            </div>

                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" placeholder="Create a password" TextMode="Password" required="required" />
                            </div>

                            <div class="mb-3">
                                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                                <asp:TextBox ID="txtConfirmPassword" CssClass="form-control" runat="server" placeholder="Confirm your password" TextMode="Password" required="required" />
                            </div>

                            <div class="form-check mb-3">
                                <asp:CheckBox ID="chkTerms" runat="server" CssClass="form-check-input" required="required" />
                                <label class="form-check-label" for="chkTerms">
                                    I agree to the <a href="#" class="text-danger">Terms of Service</a> and <a href="#" class="text-danger">Privacy Policy</a>
                                </label>
                            </div>

                            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-danger w-100" OnClick="btnRegister_Click" />
                        </div>

                        <div class="text-center mt-3">
                            <span>Already have an account? <a href="Login.aspx" class="text-danger fw-bold">Sign In</a></span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

