<?php include("../inc/header.inc.php"); ?>
<title>Sign In</title>
      <div class="container-fluid py-5 h-100">
        <div class="row justify-content-center align-items-center h-100">
          <div class="col-12 col-lg-9 col-xl-7">
            <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
              <div class="card-body p-4 p-md-5">
                <div class="alert alert-success" id="signup_form_alert" style="display:none"></div>
                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Sign Up Now!</h3>
                <form id="signup_form">
    
                  <div class="row">
                    <div class="col-md-6 mb-4">
    
                      <div class="form-outline">
                         <label class="form-label" >First Name:</label>
                        <input type="text" name="firstname" class="form-control form-control-lg" />
                      </div>
    
                    </div>
                    <div class="col-md-6 mb-4">
    
                      <div class="form-outline">
                         <label class="form-label" >Last Name:</label>
                        <input type="text" name="lastname" class="form-control form-control-lg" />
                      </div>
    
                    </div>
                  </div>
    
                  <div class="row">
                    <div class="col-md-6 mb-4 d-flex align-items-center">
    
                    
                      <div class="form-outline datepicker w-100">
                        <label  class="form-label">Birthday:</label>
                        <input type="date" class="form-control form-control-lg" name="birthdate" />
                       
                      </div>
    
                    </div>
                    <div class="col-md-6 mb-4">
                       <label class="form-label" >Sex:</label>
                      <div class="form-check form-check-inline mt-2">
                        <input class="form-check-input" type="radio" name="sex"
                          value="male" checked />
                        <label class="form-check-label" >Male</label>
                      </div>
    
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="sex" 
                          value="female" />
                        <label class="form-check-label" >Female</label>
                      </div>
                    </div>
                  </div>
    
                  <div class="row">
                    <div class="col-md-6 mb-4 pb-2">
    
                      <div class="form-outline">
                         <label class="form-label" >Email:</label>
                        <input type="email" name="email" class="form-control form-control-lg" />
                      
                      </div>
    
                    </div>
                    <div class="col-md-6 mb-4 pb-2">
    
                      <div class="form-outline">
                         <label class="form-label" >Phone Number:</label>
                        <input type="tel" name="phone" class="form-control form-control-lg" />
                       
                      </div>
    
                    </div>
                  </div>
    
                  <div class="form-outline mb-4">
                    <label class="form-label" >Password:</label>
                    <input type="password" name="password" class="form-control form-control-lg" />
                  </div>
  
                  <div class="form-outline mb-4">
                     <label class="form-label" >Repeat your password:</label>
                    <input type="password" name="repeated_password" class="form-control form-control-lg" />
                  </div>
  
                  <div class="form-check d-flex justify-content-center">
                    <input class="form-check-input me-2" type="checkbox" value="0" name="agreed" />
                    <label class="form-check-label" >
                      I agree all statements in <a href="terms.html" class="text-body"><u>Terms of service</u></a>
                    </label>
                  </div>
    
                  <div class="mt-4 pt-2">
                    <button class="btn btn-color px-5 w-100">Sign Up</button>
                  </div>
    
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <?php include("../inc/footer.inc.php"); ?>
</body>
</html>