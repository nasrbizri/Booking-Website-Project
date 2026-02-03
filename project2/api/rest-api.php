<?php
require '../vendor/autoload.php';
require_once '../class/database.class.php';
require_once '../class/paramValidator.class.php';
require_once '../inc/config.inc.php';
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Http\Response as Response;
use Slim\Factory\AppFactory;

require_once __DIR__ . '/../vendor/autoload.php';
$db = new Database();
$app = AppFactory::create();

$app->post("${HOME_ROUTE}api/contact", function(Request $request, Response $response, $args) use ($db) {

    if($request->getAttribute("has_error")){
        return $response->withJson(['status' => 'error', 'message' => $request->getAttribute("error_message")], $request->getAttribute("code"), JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();
    try {
        $db->addContactMessage($data);
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while signing up'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'message sent successfully'], 200, JSON_PRETTY_PRINT);
})->add(new paramValidator());

$app->post("${HOME_ROUTE}api/concern", function (Request $request, Response $response, $args) use ($db) {

    if ($request->getAttribute("has_error")) {
        return $response->withJson(['status' => 'error', 'message' => $request->getAttribute("error_message")], $request->getAttribute("code"), JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();
    try {
        $db->addNeighborhoodConcern($data);
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while signing up'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'concern sent successfully'], 200, JSON_PRETTY_PRINT);
})->add(new paramValidator());

$app->post("${HOME_ROUTE}api/signup", function (Request $request, Response $response, $args) use ($db) {

    if ($request->getAttribute("has_error")) {
        return $response->withJson(['status' => 'error', 'message' => $request->getAttribute("error_message")], $request->getAttribute("code"), JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();

    try{
        $db->addUser($data);
    } catch(Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => $e->getMessage()], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'signed up successfully!'], 200, JSON_PRETTY_PRINT);
})->add(new paramValidator());

$app->post("${HOME_ROUTE}api/signin", function (Request $request, Response $response, $args) use ($db) {

    $data = $request->getParsedBody();

    try {
        $userData = $db->signIn($data['email'], $data['password']);
        if(!$userData){
            return $response->withJson(['status' => 'error', 'message' => "email or password are incorrect"], 400, JSON_PRETTY_PRINT);
        }

    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => $e->getMessage()], 500, JSON_PRETTY_PRINT);
    }

    foreach($userData as $key => $value){
        $_SESSION[$key] = $value;
    }
    
    return $response->withJson(['status' => 'success', 'message' => 'logged in successfully!'], 200, JSON_PRETTY_PRINT);
});


$app->get("${HOME_ROUTE}api/signout", function (Request $request, Response $response, $args) {
    if(PHP_SESSION_NONE !== session_status()){
        session_destroy();
    }
    return $response->withJson(['status' => 'success', 'message' => 'logged out successfully!'], 200, JSON_PRETTY_PRINT);
});


$app->post("${HOME_ROUTE}api/user/modify_password", function (Request $request, Response $response, $args) use ($db) {

    if(!isset($_SESSION["id"])){
        return $response->withJson(['status' => 'error', 'message' => "you're not logged in"], 403, JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();

    if(!password_verify($data['password'], $_SESSION['password'])){
        return $response->withJson(['status' => 'error', 'message' => "old password is incorrect"], 403, JSON_PRETTY_PRINT);
    }

    if ($data['new_password'] !== $data['repeated_password']) {
        return $response->withJson(['status' => 'error', 'message' => "new password doesn't match the repeated one"], 400, JSON_PRETTY_PRINT);
    }

    try {
        $newHashedPassword = $db->modifyPassword($_SESSION['id'], $data['new_password']);
        if(!$newHashedPassword){
            return $response->withJson(['status' => 'error', 'message' => "an unkown error has occured"], 500, JSON_PRETTY_PRINT);
        }

        $_SESSION['password'] = $newHashedPassword;

    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => $e->getMessage()], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'changed successfully!'], 200, JSON_PRETTY_PRINT);
});

$app->post("${HOME_ROUTE}api/add/booking_record", function (Request $request, Response $response, $args) use ($db) {
    if (!isset($_SESSION['id'])) {
        return $response->withJson(['status' => 'error', 'message' => 'unauthorized'], 403, JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();
    $checkInDate = $data['check_in_date'];
    $checkOutDate =$data['check_out_date'];

    if ($checkInDate > $checkOutDate) {
        return $response->withJson(['status' => 'error', 'message' => 'check in date cannot be greater than check out date'], 500, JSON_PRETTY_PRINT);
    }
    $placeId = $data['place_id'];
    $offerId = null;
    try {
        if(array_key_exists('offer_id', $data)){
            $offerId = $data['offer_id'];
            if (!$db->isPlaceInSpecialOffer($placeId, $offerId)) {
                return $response->withJson(['status' => 'error', 'message' => 'this offer is not valid for your chosen place.'], 403, JSON_PRETTY_PRINT);
            }
        }
        $db->addBookingDetails($_SESSION['id'], $placeId, $checkInDate, $checkOutDate, $offerId); 
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while placing your order'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'order placed successfully'], 200, JSON_PRETTY_PRINT);
});


$app->post("${HOME_ROUTE}api/user/add/wishlist", function (Request $request, Response $response, $args) use ($db) {
    if (!isset($_SESSION['id'])) {
        return $response->withJson(['status' => 'error', 'message' => 'unauthorized'], 403, JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();
    $placeId = $data['place_id'];
    try {
        $db->addToWishlist($_SESSION['id'],$placeId);
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while adding to wishlist, it is possible that this item already exists in your wishlist'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'successfully added to wishlist'], 200, JSON_PRETTY_PRINT);
});

$app->post("${HOME_ROUTE}api/user/delete/wishlist", function (Request $request, Response $response, $args) use ($db) {
    if (!isset($_SESSION['id'])) {
        return $response->withJson(['status' => 'error', 'message' => 'unauthorized'], 403, JSON_PRETTY_PRINT);
    }

    $data = $request->getParsedBody();
    $placeId = $data['place_id'];
    try {
        $result = $db->removeWishlistItem($_SESSION['id'], $placeId);
        if(!$result){
            $response->withJson(['status' => 'error', 'message' => 'error while removing wishlist item'], 500, JSON_PRETTY_PRINT);
        }
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while removing wishlist item'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status' => 'success', 'message' => 'successfully removed wishlist item'], 200, JSON_PRETTY_PRINT);
});

$app->get("${HOME_ROUTE}api/rentable_places", function (Request $request, Response $response, $args) use ($db) {
    
    if (!isset($_SESSION['id'])) {
        return $response->withJson(['status' => 'error', 'message' => 'unauthorized'], 403, JSON_PRETTY_PRINT);
    }

    $data = $request->getQueryParams();
    $result = null;
    $query = null;

    try {
        if (isset($data['query']) && !empty($data['query'])) {
            $query = $data['query'];
        }

        $result = $db->getRentablelPlaces($query);
    } catch (Exception $e) {
        return $response->withJson(['status' => 'error', 'message' => 'error while getting rentable places'], 500, JSON_PRETTY_PRINT);
    }

    return $response->withJson(['status'=> 'success', 'data' => $result],200, JSON_PRETTY_PRINT);
});

$app->addErrorMiddleware(true, true, true);
$app->run();
?>