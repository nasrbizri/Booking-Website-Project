<?php
include_once("inc/header.inc.php");
include_once("class/database.class.php");
$db = new Database();
?>
<title>Home</title>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="slider col-md-12">
                <div class="">
                    <div class="title col-md-12">
                        <h2>Home</h2>
                    </div>
                </div>
            </div>

            <div class="offers-grid">
                <div class="grid-content">
                    <?php
                    $offers = $db->getSpecialOffers();
                    foreach ($offers as $offer) {
                        ?>
                        <div class="card" data-item="offer_item" data-offer-coupon="<?php print($offer['coupon']); ?>"
                         data-offer-id="<?php print($offer['id']); ?>"
                          data-place-id="<?php print($offer['place_id']); ?>"
                             >
                                    <img class="img-fluid" src="<?php print("$HOME_URL{$offer['image']}"); ?>" />
                            <h3>
                                <?php print($db->getCountryNameByCode($offer['country'])); ?>
                            </h3>
                            <p>
                                <?php print($offer['description']); ?>
                            </p>
                        </div>
                    <?php } ?>
                </div>
            </div>

            <div class="col-md-12 text-center justify-content-center">
                 <button class="check btn btn-center mb-2 mt-2"><a href="pages/specialoffers.php">Check More...</a></button>
            </div>
        </div>
        
    </div>
    <?php include_once("inc/footer.inc.php"); ?>
    </div>
</body>