<?php
include_once("../inc/header.inc.php");

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
if (!isset($_SESSION['id'])) {
    print("<script>window.location = '{$HOME_URL}pages/signIn.php';</script>");
    die();
}

include_once("../class/database.class.php");
$db = new Database();
$items = $db->getWishlistForUser($_SESSION['id']);
$hide = count($items) === 0 ? 'display:none' : '';
?>

<title>Wish List</title>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="slider col-md-12">
                <div class="">
                    <div class="title col-md-12">
                        <h2>Wishlist</h2>
                    </div>
                </div>
            </div>

    <?php if (count($items) === 0) { ?>
        <div class="col-md-6 col-12 text-center mx-auto py-3">
            <h1>Your wish list is currently empty.</h1>
        </div>
    <?php } ?>

    <div class="offers-grid" style="<?php print($hide); ?>">
        <div class="grid-content">
            <?php
            foreach ($items as $item) {
                ?>
                <div class="card" data-item="book_item" data-place-id="<?php print($item['id']); ?>">
                    <img class="img-fluid" src="<?php print("$HOME_URL{$item['image']}"); ?>" />
                    <h3>
                        <?php print($item['title']); ?>
                    </h3>
                    <p>
                        <?php print($item['description']); ?>
                    </p>
                    <button name="removeWishListBtn" class="btn"><i class="fa fa-trash" aria-hidden="true"></i></button>
                </div>
            <?php } ?>

        </div>
    </div>
    </div>
    </div>
    </div>

    <?php include_once("../inc/footer.inc.php"); ?>