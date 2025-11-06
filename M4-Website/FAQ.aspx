 <%@ Page Title="FAQ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="M4_Website.FAQ" %>

 <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

 <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #000;
        }

        /* ===== HERO SECTION ===== */
        .faq-hero {
            text-align: center;
            padding: 100px 20px;
            background-color: #7a0000;
            color: #fff;
        }

        .faq-hero h1 {
            font-size: 3rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .faq-hero p {
            font-size: 1.2rem;
            margin-top: 15px;
            max-width: 700px;
            margin: 15px auto 0 auto;
            color: #f0f0f0;
        }

        /* ===== FAQ SECTION ===== */
        .faq-section {
            background-color: #fff;
            color: #111;
            padding: 80px 20px;
        }

        .faq-section h2 {
            color: #ff0000;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 40px;
        }

        .accordion-item {
            border: 1px solid #ddd;
            border-left: 5px solid #ff0000;
            border-radius: 10px;
            margin-bottom: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .accordion-button {
            background-color: #fff;
            color: #111;
            font-weight: 600;
            padding: 18px;
            font-size: 1.1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: none;
            width: 100%;
            text-align: left;
            transition: background-color 0.3s ease;
        }

        .accordion-button::after {
            content: '\25BC'; /* Down arrow */
            font-size: 1rem;
            transition: transform 0.3s ease;
        }

        .accordion-button.collapsed::after {
            transform: rotate(0deg);
        }

        .accordion-button:not(.collapsed)::after {
            transform: rotate(180deg);
        }

        .accordion-button:hover {
            background-color: #f9f9f9;
        }

        .accordion-body {
            padding: 20px;
            font-size: 1rem;
            color: #444;
            background-color: #fff;
            border-top: 1px solid #eee;
        }

        /* Fade-in animation */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* ===== FOOTER SECTION ===== */
        .faq-footer {
            text-align: center;
            background-color: #fff;
            padding: 60px 20px;
            color: #444;
        }

        .faq-footer h3 {
            font-weight: 700;
            color: #000;
            font-size: 1.8rem;
        }

        .faq-footer p {
            margin-top: 10px;
            font-size: 1.1rem;
            color: #555;
        }

        .faq-footer .btn-group {
            margin-top: 25px;
        }

        .faq-footer .btn-custom {
            display: inline-block;
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 8px;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-contact {
            background-color: #7a0000;
            color: #fff;
        }

        .btn-contact:hover {
            background-color: #a00000;
            transform: translateY(-2px);
        }

        .btn-courses {
            background-color: #ff0000;
            color: #fff;
        }

        .btn-courses:hover {
            background-color: #ff3333;
            transform: translateY(-2px);
        }
    </style>

    <main>
        <!-- HERO SECTION -->
        <section class="faq-hero">
            <h1>Frequently Asked Questions</h1>
            <p>We’ve compiled answers to the most common questions our students ask.</p>
        </section>

        <!-- FAQ SECTION -->
        <section class="faq-section fade-in">
            <h2>Get Informed</h2>

            <div class="accordion" id="faqAccordion">

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q1">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a1" aria-expanded="false" aria-controls="a1">
                            How do I book a driving lesson?
                        </button>
                    </h2>
                    <div id="a1" class="accordion-collapse collapse" aria-labelledby="q1" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            You can book a lesson online through our website or call us directly. Our receptionist will confirm your booking and available time slots.
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q2">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a2" aria-expanded="false" aria-controls="a2">
                            What do I need to bring for my first lesson?
                        </button>
                    </h2>
                    <div id="a2" class="accordion-collapse collapse" aria-labelledby="q2" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Please bring your learner’s license, ID, and comfortable shoes. Our instructor will guide you through everything you need before driving.
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q3">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a3" aria-expanded="false" aria-controls="a3">
                            Can I reschedule my lesson?
                        </button>
                    </h2>
                    <div id="a3" class="accordion-collapse collapse" aria-labelledby="q3" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Yes, you can reschedule your lesson at least 24 hours in advance without penalties. Please contact us directly to make changes.
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q4">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a4" aria-expanded="false" aria-controls="a4">
                            How much do your driving packages cost?
                        </button>
                    </h2>
                    <div id="a4" class="accordion-collapse collapse" aria-labelledby="q4" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Our packages vary depending on the number of lessons. Visit our Packages page or contact us for detailed pricing and discounts.
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q5">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a5" aria-expanded="false" aria-controls="a5">
                            What happens if I miss my lesson?
                        </button>
                    </h2>
                    <div id="a5" class="accordion-collapse collapse" aria-labelledby="q5" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Missed lessons without prior notice may be forfeited. Please contact us immediately if you experience an emergency or unexpected delay.
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="q6">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#a6" aria-expanded="false" aria-controls="a6">
                            Do you provide vehicles for the driving test?
                        </button>
                    </h2>
                    <div id="a6" class="accordion-collapse collapse" aria-labelledby="q6" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Yes, we provide test-day vehicles for students at an affordable rate. Be sure to book this option in advance to ensure availability.
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- FOOTER SECTION -->
        <section class="faq-footer fade-in">
            <h3>Still Have Questions?</h3>
            <p>Can't find what you're looking for? Our team is here to help.</p>

            <div class="btn-group">
                <a href="Contact.aspx" class="btn-custom btn-contact">Contact Us</a>
                <a href="Courses.aspx" class="btn-custom btn-courses">View Courses</a>
            </div>
        </section>
    </main>

    <script>
        // Fade-in animation
        window.addEventListener('scroll', () => {
            document.querySelectorAll('.fade-in').forEach(el => {
                if (el.getBoundingClientRect().top < window.innerHeight - 100) {
                    el.classList.add('visible');
                }
            });
        });
    </script>
</asp:Content>
