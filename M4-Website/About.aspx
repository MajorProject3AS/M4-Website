<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="M4_Website.About" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Intro Section */
        .intro-section {
            background: linear-gradient(to right, #4a0000, #7a0a0a, #a81515);
            color: #fff;
            text-align: center;
            padding: 90px 20px;
        }

        .intro-section h1 {
            font-weight: 700;
            font-size: 40px;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .intro-section p {
            font-size: 18px;
            margin: 5px 0;
            opacity: 0.9;
        }

        /* About Section */
        .about-section {
            background-color: #f8f9fa;
            padding: 60px 20px;
            text-align: center;
        }

        .about-section h2 {
            font-weight: 700;
            color: #c80000;
            margin-bottom: 20px;
        }

        .about-section p {
            font-size: 17px;
            color: #333;
            line-height: 1.7;
            margin-bottom: 15px;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.03);
        }

        .card-title {
            color: #c80000;
            font-weight: 600;
        }

        /* Extras Section */
        .extras-section {
            background-color: #fff;
            padding: 50px 20px;
            text-align: center;
        }

        .extras-section h3 {
            color: #c80000;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .contact-info i {
            color: #c80000;
            margin-right: 8px;
        }
    </style>

    <!-- Intro Section -->
    <section class="intro-section">
        <div class="container">
            <h1>About TLG Driving School</h1>
            <p>With over 15 years of experience, we're committed to providing the highest quality driving instruction</p>
            <p>in a safe, supportive environment.</p>
        </div>
    </section>

    <!-- About Content -->
    <main class="about-section">
        <div class="container">
            <h2>Why Choose TLG?</h2>
            <p>
                At <strong>TLG Driving Academy</strong>, we are dedicated to helping you become a confident,
                responsible, and skilled driver. Our qualified instructors provide hands-on training with patience
                and professionalism, ensuring that every student feels comfortable behind the wheel.
            </p>
            <p>
                We offer lessons in all South African languages and maintain a guaranteed pass rate, giving you the
                best chance at success. Whether you’re starting fresh or upgrading your license, TLG is your trusted partner on the road.
            </p>
        </div>
    </main>

    <!-- Driving Packages -->
    <section class="container my-5">
        <div class="row text-center">
            <div class="col-md-6 mb-4">
                <div class="card p-4">
                    <h5 class="card-title">Code 08 Packages</h5>
                    <p><strong>Steward’s Package (10 Lessons):</strong> R1300</p>
                    <p><strong>Royalty Package (15 Lessons):</strong> R1700</p>
                    <p><strong>Prince’s Package (20 Lessons):</strong> R2000</p>
                    <p><strong>Full Course:</strong> R3200</p>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card p-4">
                    <h5 class="card-title">Code 10 Packages</h5>
                    <p><strong>Steward’s Package (10 Lessons):</strong> R1700</p>
                    <p><strong>Royalty Package (15 Lessons):</strong> R2100</p>
                    <p><strong>Prince’s Package (20 Lessons):</strong> R2500</p>
                    <p><strong>Princess’s Package (25 Lessons):</strong> R3000</p>
                    <p><strong>Full Course:</strong> R3600</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Extras and Contact -->
    <section class="extras-section">
        <div class="container">
            <h3>Extras</h3>
            <p><strong>Special Car Hire:</strong> R600</p>
            <p><strong>Special Truck Hire:</strong> R1000</p>
            <p><strong>Learner’s Licence + Booking Fee:</strong> R550</p>

            <hr class="my-4" />

            <h3>Trading Hours</h3>
            <p>Monday – Friday: <strong>08:00 – 17:30</strong></p>
            <p>Saturday: <strong>08:00 – 12:00</strong></p>

            <hr class="my-4" />

            <h3>Contact Us</h3>
            <div class="contact-info">
                <p><i class="bi bi-telephone"></i> 074 667 2974 | 061 585 0684</p>
                <p><i class="bi bi-envelope"></i> takalanilg@gmail.com</p>
                <p><i class="bi bi-geo-alt"></i> UKZN Westville Campus, Makabane Shopping Centre, Office No. 3</p>
            </div>
        </div>
    </section>

</asp:Content>
