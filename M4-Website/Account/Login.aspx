<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="M4_Website.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

     <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #fff; /* page background white */
        }

        .login-page {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

       /* Dark maroon top banner */
.welcome-banner {
    background-color: #800000; /* dark maroon */
    background: linear-gradient(180deg, #800000, #660000); /* subtle gradient for depth */
    width: 100%;
    text-align: center;
    padding: 40px 0;
    margin-bottom: 50px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.2);
}

.welcome-banner h1 {
    margin: 0;
    font-size: 3em;
    color: #fff;
    text-shadow: 1px 1px 3px #400000; /* darker text shadow for softer effect */
}

.welcome-banner p {
    color: #fff;
    font-size: 1.1em;
    margin-top: 10px;
}


        /* Form container */
        .login-form-container {
            background-color: #fff; /* keep form white */
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 450px;
            text-align: center;
        }

        /* Headings inside form */
        .login-form-container h2, .login-form-container h4 {
            color: #b30000;
        }

        /* Form controls */
        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            color: #000;
        }

        .form-control:focus {
            outline: none;
            border-color: #b30000;
        }

        /* Login button red with white text */
        .btn-login {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #b30000;
            color: #fff;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-login:hover {
            background-color: #ff4d4d;
        }

        /* Links red */
        .register-link a {
            color: #b30000;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        /* Responsive centering */
        @media (max-width: 500px) {
            .login-form-container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>

     <div class="login-page">
        <div class="welcome-banner">
            <h1>Access Your Account</h1>
            <p>Sign in to book lessons, track progress, and manage your learning journey.</p>
        </div>
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <div class="col-md-8">
            <section id="loginForm">
                <div class="row">
                   
                    <h4>Use a local account to log in.</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="row">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 col-form-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="row">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 col-form-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="row">
                        <div class="offset-md-2 col-md-10">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="offset-md-2 col-md-10">
                            <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-outline-dark" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                 <p>
                    <asp:HyperLink runat="server" ID="ForgotPasswordLink" NavigateUrl="~/Account/Forgot.aspx">Forgot password</asp:HyperLink>
                </p>


                <p>
                    <%-- Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    --%>
                </p>
            </section>
        </div>

        <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>
    </main>
</asp:Content>
