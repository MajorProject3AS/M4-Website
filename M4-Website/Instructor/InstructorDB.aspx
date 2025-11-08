<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstructorDB.aspx.cs" Inherits="M4_Website.InstructorDB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Instructor Dashboard</title>
    <link href="Styles.css" rel="stylesheet" />
    <style>
    body {
    margin: 0;
    font-family: Arial, sans-serif;
}

.top-panel {
    background-color: #c00; /* Red */
    color: white;
    padding: 20px;
    text-align: center;
}

.content-wrapper {
    display: flex;
    height: calc(100vh - 80px); /* Adjust based on top panel height */
}

.aside-panel {
    background-color: #000; /* Black */
    width: 200px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.nav-button {
    width: 100%;
    padding: 10px;
    color: white;
    background-color: #333;
    border: none;
    cursor: pointer;
}

.nav-button:hover {
    background-color: #555;
}

.main-panel {
    flex-grow: 1;
    background-color: #fff; /* White */
    padding: 40px;
    overflow-y: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.user-control-panel {
    width: 100%;
    max-width: 800px;
}
</style>

</head>
<body>
    <form id="form1" runat="server">
        <!-- Top Panel -->
<div class="top-panel">
    <h1>TLG Driving Academy</h1>
</div>

<!-- Container for Sidebar and Main Panel -->
<div class="content-wrapper">
    <!-- Aside Panel -->
    <div class="aside-panel">
        <asp:Button ID="btnDashboard" runat="server" Text="Dashboard" CssClass="nav-button" OnClick="btnDashboard_Click" />
        <asp:Button ID="btnAttendance" runat="server" Text="Attendance" CssClass="nav-button" OnClick="btnAttendance_Click" />
        <asp:Button ID="btnProgress" runat="server" Text="Student Progress" CssClass="nav-button" OnClick="btnProgress_Click" />
    </div>

    <!-- Main Panel -->
    <div class="main-panel">
        <asp:Panel ID="pnlMain" runat="server" CssClass="user-control-panel"></asp:Panel>
        <asp:Panel ID="Panel1" runat="server"></asp:Panel>
    </div>
</div>
    </form>
</body>
</html>
