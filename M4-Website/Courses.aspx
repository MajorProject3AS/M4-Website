<%@ Page Title="Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="M4_Website.Courses" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fff;
    }

    /* HERO SECTION */
    .courses-hero {
        text-align: center;
        padding: 100px 20px;
        background-color: #7a0000;
        color: #fff;
    }

    .courses-hero h1 {
        font-size: 3rem;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .courses-hero p {
        font-size: 1.2rem;
        margin-top: 15px;
        max-width: 700px;
        margin-left: auto;
        margin-right: auto;
        color: #f0f0f0;
    }

    .hero-08{
        background-color: #fff;
        text-align: center;
        padding: 40px 20px;
        color: #fff;
    }

    .hero-08 h2{
        color: #000;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .hero-08 p{
        max-width: 700px;
        margin: 0 auto;
        color: #444;
        font-size: 1.1rem;
    }

    /* COURSE GRID CARDS */
    .course-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
        max-width: 1200px;
        margin: 60px auto;
    }

    .course-card {
        background: #fff;
        border: 1px solid #ddd;
        border-left: 5px solid #ff0000;
        border-radius: 15px;
        padding: 20px;
        text-align: center;
        opacity: 1;
        transform: translateY(0);
        transition: all 0.3s ease;
    }

    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 15px rgba(255,0,0,0.3);
    }

    .course-card .icon {
        font-size: 35px;
        color: #ff0000;
        margin-bottom: 10px;
    }

    .course-card h3 {
        color: #000;
        font-size: 1.3rem;
        margin-bottom: 10px;
    }

    .course-card p {
        color: #555;
        font-size: 1rem;
        margin: 8px 0;
    }

    .course-btn {
        display: inline-block;
        margin-top: 10px;
        color: #ff0000;
        border: 2px solid #ff0000;
        padding: 8px 20px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .course-btn:hover {
        background-color: #ff0000;
        color: #fff;
    }

    /* CTA SECTION */
    .courses-cta {
        background-color: #7a0000;
        color: #fff;
        text-align: center;
        padding: 80px 20px;
    }

    .courses-cta h2 {
        font-size: 2.5rem;
        margin-bottom: 15px;
        font-weight: bold;
    }

    .courses-cta p {
        font-size: 1.2rem;
        margin-bottom: 30px;
    }

    .cta-btn {
        display: inline-block;
        margin: 10px 15px;
        padding: 12px 30px;
        border-radius: 25px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .cta-btn.book {
        background-color: #ff0000;
        color: #fff;
    }

    .cta-btn.book:hover {
        background-color: #ff3333;
    }

    .cta-btn.contact {
        background-color: transparent;
        color: #fff;
        border: 2px solid #fff;
    }

    .cta-btn.contact:hover {
        background-color: #fff;
        color: #7a0000;
    }

    .additional-services {
        margin-top: 50px;
        text-align: center;
        background-color: #f9f9f9;
        padding: 40px 20px;
    }

    .additional-services h2 {
        font-size: 2em;
        color:#000;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .additional-services .subtitle {
        font-size: 1.1em;
        color: #444;
        margin-bottom: 30px;
    }

    .service-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
        justify-content: center;
        align-items: stretch;
    }

    .service-card {
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        padding: 25px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .service-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    }

    .service-card h3 {
        color: #333;
        margin-bottom: 10px;
    }

    .service-card .price {
        font-size: 1.4em;
        font-weight: bold;
        color: #a60000;
        margin-bottom: 15px;
    }

    .enquire-btn {
        background-color: #a60000;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .enquire-btn:hover {
        background-color: #7e0000;
    }

    /* HOW IT WORKS SECTION */
    .how-it-works {
        background-color: #f4f4f4;
        padding: 60px 20px;
        text-align: center;
        border-radius: 8px;
        margin-top: 60px;
    }

    .how-it-works h2 {
        font-size: 2rem;
        color: #000;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .how-it-works .intro {
        color: #555;
        font-size: 1.1rem;
        margin-bottom: 25px;
    }

    .how-it-works .steps-text {
        color: #333;
        font-size: 1rem;
        line-height: 1.8;
        max-width: 700px;
        margin: 0 auto;
        text-align: left;
        background-color: #f9f9f9;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    }

    .how-it-works strong {
        color: #a60000;
    }
</style>

<main>
    <!-- HERO -->
    <section class="courses-hero">
        <h1>Our Courses</h1>
        <p>Choose the right course for your driving goals — whether you're a beginner or preparing for your test.</p>
    </section>

    <!-- COURSE GRID (CODE 08 ONLY) -->
    <section class="hero-08">
        <h2>CODE 08 - Light Motor Vehicle</h2>
        <p>Standard car driving lessons for Code 08 licence</p>
    </section>

    <section class="course-grid container">
        <div class="course-card">
            <div class="icon">&#128663;</div>
            <h3>Steward's Package - 10 Lessons</h3>
            <p>CODE 08 - Light Motor Vehicle</p>
            <p>R1300.00</p>
            <p>Theory Training, Practical Lessons, Road Safety, Basic Maneuvers</p>
            <a href="/Booking/BookPackage.aspx?package=Steward's Package - 10 Lessons&code=CODE 08 - Light Motor Vehicle&price=R1300.00" class="course-btn">Book This Package</a>
        </div>

        <div class="course-card">
            <div class="icon">&#128663;</div>
            <h3>Royalty Package - 15 Lessons</h3>
            <p>CODE 08 - Light Motor Vehicle</p>
            <p>R1700.00</p>
            <p>Extended Practice, Theory Training, Test Preparation, Confidence Building</p>
            <a href="/Booking/BookPackage.aspx?package=Royalty Package - 15 Lessons&code=CODE 08 - Light Motor Vehicle&price=R1700.00" class="course-btn">Book This Package</a>
        </div>

        <div class="course-card">
            <div class="icon">&#128663;</div>
            <h3>Prince's Package - 20 Lessons</h3>
            <p>CODE 08 - Light Motor Vehicle</p>
            <p>R2000.00</p>
            <p>Comprehensive Training, Advanced Techniques, Multiple Test Routes, Full Support</p>
            <a href="/Booking/BookPackage.aspx?package=Prince's Package - 20 Lessons&code=CODE 08 - Light Motor Vehicle&price=R2000.00" class="course-btn">Book This Package</a>
        </div>

        <div class="course-card">
            <div class="icon">&#128663;</div>
            <h3>Full Course - Complete</h3>
            <p>CODE 08 - Light Motor Vehicle</p>
            <p>R3200.00</p>
            <p>Start to Finish, All Inclusive, Guaranteed Support, Unlimited Practice</p>
            <a href="/Booking/BookPackage.aspx?package=Full Course - Complete&code=CODE 08 - Light Motor Vehicle&price=R3200.00" class="course-btn">Book This Package</a>
        </div>
    </section>

   <%-- <!-- ADDITIONAL SERVICES -->
    <section class="additional-services">
        <h2>Additional Services</h2>
        <p class="subtitle">Extra services available for your convenience</p>

        <div class="service-grid">
            <div class="service-card">
                <h3>Special Car Hire</h3>
                <p class="price">R600</p>
                <button class="enquire-btn">Enquire Now</button>
            </div>

            <div class="service-card">
                <h3>Special Truck Hire</h3>
                <p class="price">R1000</p>
                <button class="enquire-btn">Enquire Now</button>
            </div>

            <div class="service-card">
                <h3>Learners Licence + Booking Fee</h3>
                <p class="price">R550</p>
                <button class="enquire-btn">Enquire Now</button>
            </div>
        </div>
    </section>--%>

    <!-- HOW IT WORKS SECTION -->
    <section class="how-it-works">
        <h2>How It Works</h2>
        <p class="intro">Getting started with your driving lessons is quick and simple!</p>

        <div class="steps-text">
            <p>* <strong>Create an account</strong> and book your first lesson online.</p>
            <p>* <strong>Meet your instructor</strong> and start learning with confidence.</p>
            <p>* <strong>Get ready for your test</strong> and earn your driver's licence!</p>
        </div>
    </section>

    <!-- CTA SECTION -->
    <section class="courses-cta">
        <h2>Ready to Start Your Journey?</h2>
        <p>Book your lessons today and drive with the experts!</p>
        <a href="Account/Login.aspx" class="cta-btn book">Book Now</a>
        <a href="Contact.aspx" class="cta-btn contact">Contact Us</a>
    </section>
</main>

</asp:Content>
