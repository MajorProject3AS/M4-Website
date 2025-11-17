<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Manager.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="M4_Website.Manager.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
                <style>
    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: #ffffff;
    }

    /* Header */
    header {
        background: #ffffff;
        height: 80px;
        border-bottom: 1px solid #ddd;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        padding: 0 20px;
    }

    /* Sidebar */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 240px;
        height: 100vh;
        background-color: #000;
        color: white;
        padding-top: 20px;
    }

    .sidebar img {
        width: 160px;
        display: block;
        margin: 0 auto 20px auto;
    }

    .sidebar h2 {
        text-align: center;
        color: #fff;
        font-size: 18px;
        margin-bottom: 30px;
    }

    .sidebar a {
        display: block;
        padding: 12px 20px;
        color: #fff;
        text-decoration: none;
        transition: 0.2s;
    }

    .sidebar a:hover {
        background-color: #343a40;
    }
body {
  margin: 0;
  padding: 0;
  background: #fff;
}
.dashboard-layout {
  display: flex;
  min-height: 100vh;
}
.sidebar {
  width: 230px;
  background: #000;
  color: #fff;
  min-height: 100vh;
  position: fixed; /* fixes the sidebar to the left */
  left: 0;
  top: 0;
  padding-top: 0;
  z-index: 999;
}
 .sidebar img {
     width: 160px;
     display: block;
     margin: 0 auto 20px auto;
 }
.main-content {
  margin-left: 230px; /* this matches the sidebar width */
  padding: 32px 40px 40px 40px;
  flex: 1 1 0%;
}
.main-content h1 {
  margin-top: 0;
}
                    report-table {  
                        width: 50%;  
                        margin-top: 22px;  
                   
                    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content">
        
        <div class="report-table">
            <iframe title="power bi dashboard" width="600" height="373.5" src="https://app.powerbi.com/view?r=eyJrIjoiNjMwOWNmMDgtOGUyNi00ZGY1LThhZmEtNzhiZGU0YWNkNzQ4IiwidCI6IjIyNjgyN2Q2LWE5ZDAtNDcwZC04YzE1LWIxNDZiMDE5MmQ1MSIsImMiOjh9" frameborder="0" allowFullScreen="true"></iframe>
</div>
    </div>
</asp:Content>
