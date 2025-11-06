<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="M4_Website.Contact" %>

 <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* HERO SECTION */
        .contact-hero {
            text-align: center;
            padding: 150px 20px;
            background-color: #7a0000;
            color: #fff;
        }

        .contact-hero h1 span {
            color: #ff0000;
        }

        /* HERO PARAGRAPH SECTION (white background) */
        .hero-paragraph {
            background-color: #fff;
            text-align: center;
            padding: 40px 20px;
            color: #111;
        }

        .hero-paragraph h2 {
            color: #ff0000;
            margin-bottom: 15px;
        }

        .hero-paragraph p {
            max-width: 700px;
            margin: 0 auto;
            color: #444;
            font-size: 1.1rem;
        }

        /* CONTACT CARDS */
        .contact-card .icon {
            font-size: 40px;
            color: #ff0000;
            margin-bottom: 10px;
        }

        .contact-card h5 {
            color: #000;
        }

        .contact-btn {
            border: 2px solid #ff0000;
            color: #ff0000;
            transition: 0.3s;
        }

        .contact-btn:hover {
            background-color: #ff0000;
            color: #fff;
        }

        /* EMAIL FORM */
        .contact-form textarea {
            resize: none;
        }

        .send-btn {
            background-color: #ff0000;
            color: #fff;
        }

        .send-btn:hover {
            background-color: #7a0000;
        }

        /* MAP SECTION */
        .map-section {
            background-color: #e0e0e0;
            padding: 40px 20px;
        }

        iframe {
            border: none;
            border-radius: 15px;
            width: 100%;
            height: 400px;
        }

        .locate-btn {
            border: 2px solid #ff0000;
            color: #ff0000;
        }

        .locate-btn:hover {
            background-color: #ff0000;
            color: #fff;
        }

        /* Scroll animation */
        .fade-in {
            opacity: 0;
            transform: translateY(50px);
            transition: all 1s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>

    <main>

        <!-- HERO SECTION -->
        <section class="contact-hero">
            <h1>Contact <span>Us</span></h1>
            <p> Have questions? Need to book a lesson? We're here to help you get started on your driving journey.</p>
        </section>

        <!-- HERO PARAGRAPH -->
        <section class="hero-paragraph">
            <h2>Get In Touch</h2>
            <p>We're always happy to answer your questions and help you choose the right driving program.</p>
        </section>

        <!-- INFO CARDS (hidden initially) -->
        <section class="container py-5 fade-in" id="contactCards">
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="card contact-card text-center p-3 h-100 shadow-sm">
                        <div class="icon">&#128205;</div>
                        <h5>Visit Us</h5>
                        <p>UKZN Westville Campus<br />Available 08h00AM-17H30PM<br />Office No. 3</p>
                        <a href="#" class="btn contact-btn">Get Directions</a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card contact-card text-center p-3 h-100 shadow-sm">
                        <div class="icon">&#128222;</div>
                        <h5>Call Us</h5>
                        <p>074 667 2974 / 061 585 0684<br />Available 08h00AM-17H30PM</p>
                        <a href="tel:0746672974" class="btn contact-btn">Call Now</a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card contact-card text-center p-3 h-100 shadow-sm">
                        <div class="icon">&#128231;</div>
                        <h5>Email Us</h5>
                        <p>takananilg@gmail.com</p>
                        <a href="mailto:takananilg@gmail.com" class="btn contact-btn">Send Email</a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card contact-card text-center p-3 h-100 shadow-sm">
                        <div class="icon">&#128337;</div>
                        <h5>Business Hours</h5>
                        <p>Mon–Fri 08h00 – 17h30<br />Sat 08h00 – 12h00</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- EMAIL FORM (hidden initially) -->
        <section class="container py-5 fade-in" id="contactForm">
            <h2 class="mb-4">Send Us a Message</h2>
            <form>
                <div class="row g-3">
                    <div class="col-md-7">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" placeholder="Enter your full name">
                    </div>
                    <div class="col-md-5">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter your email">
                    </div>
                    <div class="col-md-7">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="phone" placeholder="Enter your phone number">
                    </div>
                    <div class="col-md-5">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" placeholder="What is this about?">
                    </div>
                    <div class="col-12">
                        <label for="message" class="form-label">Message</label>
                        <textarea class="form-control" id="message" rows="5" placeholder="Your message"></textarea>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn send-btn w-100">Send Message</button>
                    </div>
                </div>
            </form>
        </section>

        <!-- MAP -->
        <section class="map-section">
            <h2>Find Us Here</h2>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3446.7799723767814!2d30.944!3d-29.851!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1ef6fcb2b83f4e47%3A0x60a8d06f1ff86b0!2sUniversity%20of%20KwaZulu-Natal%20-%20Westville%20Campus!5e0!3m2!1sen!2sza!4v1686491056601!5m2!1sen!2sza" allowfullscreen="" loading="lazy"></iframe>
            <a href="#" class="btn locate-btn mt-3">Locate Us</a>
        </section>

    </main>

    <script>
        // Scroll animation: only shows cards and form when scrolling
        window.addEventListener('scroll', () => {
            document.querySelectorAll('.fade-in').forEach(el => {
                if (el.getBoundingClientRect().top < window.innerHeight - 100) {
                    el.classList.add('visible');
                }
            });
        });
    </script>
</asp:Content>
