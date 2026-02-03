<?php include_once("../inc/header.inc.php"); ?>
<title>Contact Us</title>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="slider col-md-12">
                <div class="">
                    <div class="title col-md-12">
                        <h2>Contact Us</h2>
                    </div>
                </div>
            </div>

            <div class="container-main a-second-section">
                <div class="contactInfo">
                    <div class="box">
                        <div clss="icon"><i class="fas fa-home mr-3"></i></div>
                        <div class="text">
                            <h3>Adress</h3>
                            <p>Beirut, Lebanon</p>
                        </div>
                    </div>
                    <div class="box">
                        <div clss="icon"><i class="fas fa-envelope mr-3"></i></div>
                        <div class="text">
                            <h3>Email</h3>
                            <p>info@example.com</p>
                        </div>
                    </div>
                    <div class="box">
                        <div clss="icon"><i class="fas fa-phone mr-3"></i></div>
                        <div class="text">
                            <h3>Phone</h3>
                            <p>+ 961 03 030303</p>
                        </div>
                    </div>
                </div>
                <div class="contactForm">
                     <div class="alert alert-success" id="contact_form_alert" style="display:none"></div>
                    <form id="contact_form">
                        <h2>Send Message</h2>
                        <div class="inputBox">
                            <input type="text" name="fullname" required="required">
                            <span>Full Name</span>
                        </div>
                        <div class="inputBox">
                            <input type="email" name="email" required="required">
                            <span>Email</span>
                        </div>
                        <div class="inputBox">
                            <textarea type="text" name="content" required="required"></textarea>
                            <span>Type your message here...</span>
                        </div>
                        <div>
                            <button class="btn check">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>



    </div>



    <?php include_once("../inc/footer.inc.php"); ?>
</body>

</html>