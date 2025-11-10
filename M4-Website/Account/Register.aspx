<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="M4_Website.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">


     <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #fff; /* white page background */
        }

        .register-page {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        /* Dark maroon top banner */
        .welcome-banner {
            background-color: #800000; 
            background: linear-gradient(180deg, #800000, #660000);
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
            text-shadow: 1px 1px 3px #400000;
        }

        .welcome-banner p {
            color: #fff;
            font-size: 1.1em;
            margin-top: 10px;
        }

        /* Form container */
        .register-form-container {
            background-color: #fff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 450px;
            text-align: center;
        }

        /* Headings inside form */
        .register-form-container h2, .register-form-container h4 {
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

        /* Register button red with white text */
        .btn-register {
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

        .btn-register:hover {
            background-color: #ff4d4d;
        }

        /* Responsive centering */
        @media (max-width: 500px) {
            .register-form-container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>

    <div class="welcome-banner">
            <h1>WELCOME</h1>
            <p>Create your account to start booking lessons and tracking your progress.</p>
        </div>


    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>
        <h4>Create a new account</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
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
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="row">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 col-form-label">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <div class="row">
            <div class="offset-md-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-outline-dark" />
            </div>
        </div>
    </main>
</asp:Content>
