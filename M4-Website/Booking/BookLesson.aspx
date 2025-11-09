<%@ Page Title="Book a Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookLesson.aspx.cs" Inherits="M4_Website.Booking.BookLesson" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <h2>Book a Lesson</h2>
                <hr />

                <!-- Student Information Panel -->
                <asp:Panel ID="pnlStudentInfo" runat="server" Visible="false">
                    <!-- Hidden Student ID for backend use -->
                    <asp:HiddenField ID="hfStudentID" runat="server" />
                    
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title">Your Information</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Name:</strong> <asp:Label ID="lblStudentName" runat="server" /></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Package:</strong> <asp:Label ID="lblPackage" runat="server" /></p>
                                    <p><strong>Payment Status:</strong> <asp:Label ID="lblPaymentStatus" runat="server" /></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Form -->
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Schedule Your Lesson</h4>

                            <div class="form-group mb-3">
                                <label for="txtLessonDate">Lesson Date</label>
                                <asp:TextBox ID="txtLessonDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="true" OnTextChanged="txtLessonDate_TextChanged" />
                                <asp:RequiredFieldValidator ID="rfvLessonDate" runat="server" 
                                    ControlToValidate="txtLessonDate" 
                                    ErrorMessage="Lesson date is required" 
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                                <asp:CustomValidator ID="cvPastDate" runat="server" 
                                    ControlToValidate="txtLessonDate" 
                                    ErrorMessage="Cannot book lessons in the past" 
                                    CssClass="text-danger" 
                                    Display="Dynamic"
                                    OnServerValidate="cvPastDate_ServerValidate" />
                                <asp:CustomValidator ID="cvDuplicateBooking" runat="server" 
                                    ErrorMessage="You already have a lesson booked on this date" 
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

                            <div class="form-group mb-3">
                                <label for="ddlTimeSlot">Time Slot</label>
                                <asp:DropDownList ID="ddlTimeSlot" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlTimeSlot_SelectedIndexChanged">
                                    <asp:ListItem Value="">-- Select Time Slot --</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvTimeSlot" runat="server" 
                                    ControlToValidate="ddlTimeSlot" 
                                    InitialValue=""
                                    ErrorMessage="Time slot is required" 
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

                            <div class="form-group mb-3">
                                <label for="ddlInstructor">Instructor</label>
                                <asp:DropDownList ID="ddlInstructor" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Instructor --</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvInstructor" runat="server" 
                                    ControlToValidate="ddlInstructor" 
                                    InitialValue=""
                                    ErrorMessage="Instructor is required" 
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                                <small class="form-text text-muted">Only instructors available for the selected date and time are shown</small>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="btnBookLesson" runat="server" Text="Book Lesson" CssClass="btn btn-primary btn-lg" OnClick="btnBookLesson_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClick="btnCancel_Click" CausesValidation="false" />
                            </div>

                            <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block" />
                        </div>
                    </div>
                </asp:Panel>

                <!-- Login Panel for non-logged in users -->
                <asp:Panel ID="pnlLogin" runat="server" Visible="false">
                    <div class="card">
                        <div class="card-body text-center">
                            <h4>Student Login Required</h4>
                            <p>Please enter your Student ID to book a lesson.</p>
                            
                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="txtStudentIDLogin">Student ID</label>
                                        <asp:TextBox ID="txtStudentIDLogin" runat="server" CssClass="form-control" placeholder="Enter your Student ID" />
                                    </div>
                                    <asp:Button ID="btnLogin" runat="server" Text="Continue" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                                </div>
                            </div>
                            <asp:Label ID="lblLoginMessage" runat="server" CssClass="mt-3 d-block" />
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
