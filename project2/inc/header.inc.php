<?php include_once("config.inc.php");?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Book your trip with RentMe!">
    <meta name="keywords" content="renting, booking, hotels, vacations">
    <link rel="stylesheet" href="<?php print("{$HOME_URL}css/bootstrap/bootstrap.min.css"); ?>">
    <link rel="stylesheet" href="<?php print("{$HOME_URL}css/fontawesome/all.css"); ?>">
    <link rel="stylesheet" href="<?php print("{$HOME_URL}css/style.css"); ?>">
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-bg custom-nav">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <h3>RentMe</h3>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul id="navbar" class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" data-page="home" href="<?php print($HOME_URL); ?>">home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  data-page="about" href="<?php print("{$HOME_URL}pages/about.php"); ?>">about us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-page="contact" href="<?php print("{$HOME_URL}pages/contact.php"); ?>">contact us</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            Services
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item"  data-page="book" href="<?php print("{$HOME_URL}pages/book.php"); ?>">book</a>
                            </li>
                            <li><a class="dropdown-item"
                             data-page="specialoffers"
                                    href="<?php print("{$HOME_URL}pages/specialoffers.php"); ?>">special offers</a></li>
                        </ul>
                      
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            help
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item"
                             data-page="faq"
                                    href="<?php print("{$HOME_URL}pages/faq.php"); ?>">FAQ</a>
                            </li>
                            <li><a class="dropdown-item"
                             data-page="privacypolicy"
                                    href="<?php print("{$HOME_URL}pages/privacypolicy.php"); ?>">privacy policy</a>
                            </li>
                            <li><a class="dropdown-item"
                             data-page="tos"
                                    href="<?php print("{$HOME_URL}pages/tos.php"); ?>">terms of service</a>
                            </li>
                             <li><a class="dropdown-item" data-page="report" href="<?php print("{$HOME_URL}pages/report.php"); ?>">report a
                                    neighbourhood concern</a></li>
                        </ul>
                    </li>

                    <?php if(isset($_SESSION['id'])) { ?>
                    <li class="nav-item dropdown ">
                        <a class="nav-link dropdown-toggle nav-item " href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            profile
                        </a>
                        <ul class="dropdown-menu">
                            
                                    <li><a class="dropdown-item" data-page="tripshistory" href="<?php print("{$HOME_URL}pages/tripshistory.php"); ?>">trips history</a>
                                        </li>
                                <li><a class="dropdown-item" data-page="wishList" href="<?php print("{$HOME_URL}pages/wishList.php"); ?>">wish list</a></li>
                            </li>
                            <li><a class="dropdown-item"
                             data-page="profile"
                                    href="<?php print("{$HOME_URL}pages/profile.php"); ?>">Settings</a>
                                </li>

                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" id="signout_header_btn">sign out</a></li>

                            </ul>
                        </li>

                    <?php } ?>

                    <?php if(!isset($_SESSION['id'])) { ?>
                    <li class="nav-item dropdown ">
                        <a class="nav-link dropdown-toggle nav-item " href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            Profile
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<?php print("{$HOME_URL}pages/signIn.php"); ?>">sign
                                    in</a></li>
                            <li><a class="dropdown-item" href="<?php print("{$HOME_URL}pages/signUp.php"); ?>">sign
                                    up</a></li>
                        </ul>
                    </li>

                    <?php } ?>
                </ul>

            </div>
        </div>
    </nav>