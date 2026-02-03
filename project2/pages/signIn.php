<?php include_once("../inc/header.inc.php"); ?>
<title>Sign In</title>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h2 class="text-center text-dark mt-5"> Sign In</h2>
            <div class="card my-5">

                <form id="signin_form" class="card-body cardbody-color p-lg-5">
                   <div class="alert alert-success" id="signin_form_alert" style="display:none"></div>
                    <div class="text-center">
                        <h1 class="signLogo">RentMe</h1>
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email" placeholder="Email">
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password">
                    </div> 
                    <button class="btn btn-color px-5 mb-5 w-100">Login</button>
                    <div id="emailHelp" class="form-text text-center mb-5 text-dark">Not
                        Registered? <a href="signUp.php" class="text-dark fw-bold"> Create an Account</a>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<?php include_once("../inc/footer.inc.php"); ?>
</body>

</html>