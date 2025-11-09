<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="M4_Website._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!-- HERO SECTION -->
<section class="hero-section text-center text-light">
    <div class="hero-bg"></div>
    <div class="hero-overlay"></div>

    <div class="hero-content">
        <h1 class="hero-title">Learn to Drive with <span class="text-red">Confidence</span></h1>
        <p class="hero-subtitle">
            Professional driving lessons with certified instructors.<br>
            Get your license faster with our proven teaching methods.
        </p>

        <div class="hero-buttons">
            <a href="/Booking/BookLesson.aspx" class="btn btn-red me-3">Book Your Lesson</a>
            <a href="Courses.aspx" class="btn btn-outline-red">View Services</a>
        </div>

        <div class="stats mt-5">
            <div>
                <h3>1000+</h3>
                <p>Students Taught</p>
            </div>
            <div>
                <h3>95%</h3>
                <p>Pass Rate</p>
            </div>
            <div>
                <h3>15+</h3>
                <p>Years Experience</p>
            </div>
        </div>
    </div>
</section>

<!-- SERVICES SECTION -->
<section class="main-content">
    <div class="container">
        <h2>Our Services</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center p-4">
                    <i class="bi bi-car-front-fill text-red mb-3"></i>
                    <h5 class="card-title">Beginner Driving Lessons</h5>
                    <p class="card-text">Learn the basics and build confidence behind the wheel with our certified instructors.</p>
                    <a href="Courses.aspx" class="btn btn-outline-red">Learn More</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center p-4">
                    <i class="bi bi-speedometer2 text-red mb-3"></i>
                    <h5 class="card-title">Advanced Driving</h5>
                    <p class="card-text">Improve your skills with advanced driving techniques and safe driving strategies.</p>
                    <a href="Courses.aspx" class="btn btn-outline-red">Learn More</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm text-center p-4">
                    <i class="bi bi-shield-check text-red mb-3"></i>
                    <h5 class="card-title">Defensive Driving</h5>
                    <p class="card-text">Learn how to anticipate and avoid hazards on the road to stay safe at all times.</p>
                    <a href="Courses.aspx" class="btn btn-outline-red">Learn More</a>
                </div>
            </div>
        </div>
    </div>
</section>

</asp:Content>




