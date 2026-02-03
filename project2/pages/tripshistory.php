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
$items = $db->getTripDetailsByUserId($_SESSION['id']);
$hide = count($items) === 0 ? 'display:none' : '';
?>

<title>Wish List</title>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="slider col-md-12">
                <div class="">
                    <div class="title col-md-12">
                        <h2>Trips History</h2>
                    </div>
                </div>
            </div>

            <?php if (count($items) === 0) { ?>
            <div class="col-md-6 col-12 text-center mx-auto py-3">
                <h1>Your trips history is currently empty.</h1>
            </div>
            <?php } ?>

            <div class="table-responsive mb-3 mt-3" style="<?php print($hide);?>">
                <table class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th>Check In Date</th>
                            <th>Check Out Date</th>
                            <th>Name</th>
                            <th>Country</th>
                            <th>Total Guests</th>
                            <th>Total Price</th>
                            <th>Payment Method</th>
                            <th>Payment Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach($items as $item) { ?>
                        <tr>
                            <td><?php print("{$item['check_in_date']}");?></td>
                            <td><?php print("{$item['check_out_date']}");?></td>
                            <td><?php print("{$item['title']}");?></td>
                            <td><?php print($db->getCountryNameByCode($item['country']));?></td>
                            <td><?php print("{$item['total_guests']}");?></td>
                            <td><?php print("{$item['total_price']}");?></td>
                            <td><?php print("{$item['payment_method']}");?></td>
                            <td><span class="badge bg-light text-dark"><?php print("{$item['payment_status']}"); ?></span></td>
                        </tr>
                        <?php } ?>

                    </tbody>
                </table>
            </div>

        </div>
    </div>
    </div>

    <?php include_once("../inc/footer.inc.php"); ?>