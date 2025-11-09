<%@ Page Title="Book Package" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookPackage.aspx.cs" Inherits="M4_Website.Booking.BookPackage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <h2>Book Your Package</h2>
                <hr />
                
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="card-title">Package Details</h4>
                        <div id="packageDetails" runat="server">
                            <p><strong>Package:</strong> <asp:Label ID="lblPackageName" runat="server" /></p>
                            <p><strong>Code:</strong> <asp:Label ID="lblPackageCode" runat="server" /></p>
                            <p><strong>Price:</strong> <asp:Label ID="lblPackagePrice" runat="server" /></p>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Your Information</h4>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtName">First Name</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                                        ControlToValidate="txtName" 
                                        ErrorMessage="First name is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtSurname">Surname</label>
                                    <asp:TextBox ID="txtSurname" runat="server" CssClass="form-control" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="rfvSurname" runat="server" 
                                        ControlToValidate="txtSurname" 
                                        ErrorMessage="Surname is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label for="txtEmail">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="100" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Invalid email format" 
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                        </div>

                        <div class="form-group mb-3">
                            <label for="txtPhoneNumber">Phone Number</label>
                            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" MaxLength="20" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                                ControlToValidate="txtPhoneNumber" 
                                ErrorMessage="Phone number is required" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                        </div>

                        <div class="form-group mb-3">
                            <label for="txtIDNo">ID Number</label>
                            <asp:TextBox ID="txtIDNo" runat="server" CssClass="form-control" MaxLength="20" />
                            <asp:RequiredFieldValidator ID="rfvIDNo" runat="server" 
                                ControlToValidate="txtIDNo" 
                                ErrorMessage="ID number is required" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                        </div>

                        <div class="form-group mb-3">
                            <label for="ddlGender">Gender</label>
                            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvGender" runat="server" 
                                ControlToValidate="ddlGender" 
                                InitialValue=""
                                ErrorMessage="Gender is required" 
                                CssClass="text-danger" 
                                Display="Dynamic" />
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtStreetNumber">Street Number</label>
                                    <asp:TextBox ID="txtStreetNumber" runat="server" CssClass="form-control" MaxLength="10" />
                                    <asp:RequiredFieldValidator ID="rfvStreetNumber" runat="server" 
                                        ControlToValidate="txtStreetNumber" 
                                        ErrorMessage="Street number is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtStreetName">Street Name</label>
                                    <asp:TextBox ID="txtStreetName" runat="server" CssClass="form-control" MaxLength="50" />
                                    <asp:RequiredFieldValidator ID="rfvStreetName" runat="server" 
                                        ControlToValidate="txtStreetName" 
                                        ErrorMessage="Street name is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtCity">City</label>
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" MaxLength="30" />
                                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" 
                                        ControlToValidate="txtCity" 
                                        ErrorMessage="City is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="txtPostalCode">Postal Code</label>
                                    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control" MaxLength="10" />
                                    <asp:RequiredFieldValidator ID="rfvPostalCode" runat="server" 
                                        ControlToValidate="txtPostalCode" 
                                        ErrorMessage="Postal code is required" 
                                        CssClass="text-danger" 
                                        Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label for="ddlStatus">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" Enabled="false">
                                <asp:ListItem Value="New" Selected="True">New</asp:ListItem>
                                <asp:ListItem Value="Active">Active</asp:ListItem>
                            </asp:DropDownList>
                            <small class="form-text text-muted">Status will be set to "New" until you start booking lessons</small>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Booking" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClick="btnCancel_Click" CausesValidation="false" />
                        </div>

                        <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
