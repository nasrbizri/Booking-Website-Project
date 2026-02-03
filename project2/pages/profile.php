<?php 
include_once("../inc/header.inc.php");

if (session_status() == PHP_SESSION_NONE) {
  session_start();
}
if (!isset($_SESSION['id'])) {
  print("<script>window.location = '{$HOME_URL}pages/signIn.php';</script>");
  die();
}

?>
<title>Profile</title>

<div class="container-fluid">
  <div class="row justify-content-center mb-5">
      <div class="col-md-5 col-12 mb-5 mt-5" style="height:450px;">
              <div class="card">
                  <div class="card-body">
                      <div class="alert alert-success" id="new_password_form_alert" style="display:none"></div>
                      <form id="new_password_form">
                          <div class="form-group">
                              <label >Current password</label>
                              <input type="password" class="form-control" name="password">
                          </div>
                          <div class="form-group">
                              <label >New password</label>
                              <input type="password" class="form-control" name="new_password">
                          </div>
                          <div class="form-group">
                              <label >Verify password</label>
                              <input type="password" class="form-control" name="repeated_password">
                          </div> 
                          
                          <button class="btn btn-primary">Save changes</button>
                      </form>
                  </div>
              </div>
      </div>
  </div>
</div>
  <?php include_once("../inc/footer.inc.php"); ?>
</body>
</html>