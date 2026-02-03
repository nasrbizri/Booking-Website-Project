<?php
class Database
{
    private $host;
    private $dbname;
    private $username;
    private $password;
    private $charset;
    private $pdo;

    public function __construct($charset = 'utf8mb4')
    {
        $this->host = "127.0.0.1";
        $this->dbname = "main_db";
        $this->username = "root";
        $this->password = "";
        $this->charset = $charset;

        $this->connect();
    }

    private function connect()
    {
        $dsn = "mysql:host={$this->host};dbname={$this->dbname};charset={$this->charset}";

        try {
            $this->pdo = new PDO($dsn, $this->username, $this->password);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Connection failed: " . $e->getMessage());
        }
    }

    public function query($sql, $params = [])
    {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    public function fetchAll($sql, $params = [])
    {
        $stmt = $this->query($sql, $params);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function fetch($sql, $params = [])
    {
        $stmt = $this->query($sql, $params);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }


    public function addUser($userData)
    {
        $userData['password'] = password_hash($userData['password'], PASSWORD_BCRYPT);
        $sql = "INSERT INTO users (password, email, firstname, lastname, sex, birthdate, phone, agreed) 
                VALUES (:password, :email, :firstname, :lastname, :sex, :birthdate, :phone, :agreed)";
        return $this->query($sql, $userData);
    }

    public function getUsers()
    {
        $sql = "SELECT * FROM users";
        return $this->fetchAll($sql);
    }

    public function deleteUser($userId)
    {
        $sql = "DELETE FROM users WHERE id = :id";
        return $this->query($sql, ['id' => $userId]);
    }

    public function addContactMessage($contactData)
    {
        $sql = "INSERT INTO contact_us (fullname, email, content) 
                VALUES (:fullname, :email, :content)";
        return $this->query($sql, $contactData);
    }


    public function addNeighborhoodConcern($concernData)
    {
        $sql = "INSERT INTO neighborhood_concern (fullname, email, content) 
                VALUES (:fullname, :email, :content)";
        return $this->query($sql, $concernData);
    }

    public function signIn($email, $password)
    {
        $sql = "SELECT `password` FROM `users` WHERE `email` = ?";
        $result = $this->fetch($sql, [$email]);

        if ($result) {
            $hashedPassword = $result['password'];
            if (password_verify($password, $hashedPassword)) {
                $userData = $this->getUserDataByEmail($email);
                return $userData;
            }
        }

        return false;
    }

    private function getUserDataByEmail($email)
    {
        $sql = "SELECT * FROM `users` WHERE `email` = ?";
        return $this->fetch($sql, [$email]);
    }

    public function modifyPassword($userId, $newPassword)
    {
        $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);
        $sql = "UPDATE `users` SET `password` = ? WHERE `id` = ?";
        $params = [$hashedPassword, $userId];
        
        if($this->query($sql, $params)){
            return $hashedPassword;
        }

        return false;
    }

    public function getSpecialOffers($limit = true)
    {
        $sql = "SELECT special_offers.id, special_offers.title, special_offers.image, special_offers.coupon, special_offers.description, 
                       special_offers.place_id, rentable_places.country 
                FROM special_offers
                INNER JOIN rentable_places ON special_offers.place_id = rentable_places.id";

        if($limit){
            $sql .= " LIMIT 6";
        }

        return $this->fetchAll($sql);
    }

    public function getSpecialOfferById($offerId)
    {
        $sql = "SELECT special_offers.*, rentable_places.*, special_offers.image as special_offer_image, rentable_places.image as retable_place_image
                FROM special_offers
                INNER JOIN rentable_places ON special_offers.place_id = rentable_places.id
                WHERE special_offers.id = :offerId";
        $params = [':offerId' => $offerId];
        return $this->fetch($sql, $params);
    }

    public function getRentablelPlaces($query = null)
    {
        $sql = "SELECT * FROM rentable_places";
        $params = [];

        if($query !== null && trim($query) !== "") {
            $params[':title'] = "%$query%";
            $sql .= " WHERE title LIKE :title";
        }

        return $this->fetchAll($sql, $params);
    }

    public function getPlaceById($placeId)
    {
        $sql = "SELECT * FROM rentable_places WHERE id = :placeId";
        $params = [':placeId' => $placeId];
        return $this->fetch($sql, $params);
    }

    public function addTripToHistory($userId, $bookingDetailsId)
    {
        $sql = "INSERT INTO trips_history (user_id, booking_details_id) VALUES (:userId, :bookingDetailsId)";
        $params = [
            ':userId' => $userId,
            ':bookingDetailsId' => $bookingDetailsId,
        ];
        $this->query($sql, $params);
        return $this->pdo->lastInsertId();
    }

    public function getTripDetailsByUserId($userId)
    {
        $sql = "SELECT trips_history.id as trip_id,
                       trips_history.user_id,
                       booking_details.place_id,
                       rentable_places.title,
                       rentable_places.country,
                       booking_details.check_in_date,
                       booking_details.check_out_date,
                       booking_details.total_guests,
                       booking_details.total_price,
                       booking_details.payment_status,
                       booking_details.payment_method,
                       booking_details.booking_cancellation
                FROM trips_history
                JOIN booking_details ON trips_history.booking_details_id = booking_details.id
                JOIN rentable_places ON booking_details.place_id = rentable_places.id
                WHERE trips_history.user_id = :userId";

        $params = [
            ':userId' => $userId,
        ];

        $result = $this->query($sql, $params);
        $tripDetails = $result->fetchAll(PDO::FETCH_ASSOC);

        return $tripDetails;
    }

    public function addBookingDetails($userId, $placeId, $checkInDate, $checkOutDate, $offerId, $paymentStatus = 'pending', $bookingCancellation = null)
    {
        $place = $this->getPlaceById($placeId);
        $checkInDateObj = new DateTime($checkInDate);
        $checkOutDateObj = new DateTime($checkOutDate);
        $dateDifference = $checkInDateObj->diff($checkOutDateObj);
        $numberOfDays = $dateDifference->days;
        if($numberOfDays === 0){
            $numberOfDays = 1;
        }

        if($offerId !== null){
            $discount = $this->getSpecialOfferById($offerId)['discount'];
            $place['price_per_night'] = $place['price_per_night'] * (1 - $discount / 100);
        }
    
        $totalPrice = $numberOfDays * $place['price_per_night'];
        
        $sql = "INSERT INTO booking_details 
                (user_id, place_id, check_in_date, check_out_date, total_guests, total_price, payment_status, booking_cancellation) 
                VALUES 
                (:userId, :placeId, :checkInDate, :checkOutDate, {$place['total_guests']}, :totalPrice, :paymentStatus, :bookingCancellation)";

        $params = [
            ':userId' => $userId,
            ':placeId' => $placeId,
            ':checkInDate' => $checkInDate,
            ':checkOutDate' => $checkOutDate,
            ':totalPrice' => $totalPrice,
            ':paymentStatus' => $paymentStatus,
            ':bookingCancellation' => $bookingCancellation,
        ];

        $this->query($sql, $params);
        return $this->addTripToHistory($userId, $this->pdo->lastInsertId());
    }

    public function parseCalendar($calendar){
        $datesOnly = array();
        foreach($calendar as $item){
            array_push($datesOnly, $item['start_date']);
            array_push($datesOnly, $item['end_date']);
        }
        $uniqueDateArray = array_unique($datesOnly);
        usort($uniqueDateArray, function ($a, $b) {
            return strtotime($b) - strtotime($a);
        });
        return($uniqueDateArray);
    }

    public function getCountryNameByCode($countryCode)
    {
        $countryCode = strtoupper($countryCode);
        $sql = "SELECT `name` FROM `countries` WHERE `iso_code` = ?";
        $params = [$countryCode];

        $result = $this->fetch($sql, $params);

        return $result['name'] ?? null;
    }

    public function addToWishlist($userId, $placeId)
    {
        $sql = "INSERT INTO `wishlist` (`user_id`, `place_id`) VALUES (?, ?)";
        $params = [$userId, $placeId];
        $this->query($sql, $params);
    }

    public function getWishlistForUser($userId)
    {
        $sql = "SELECT wishlist.*, rentable_places.* 
                FROM wishlist
                JOIN rentable_places ON wishlist.place_id = rentable_places.id
                WHERE wishlist.user_id = :userId";
        $params = [':userId' => $userId];

        return $this->fetchAll($sql, $params);
    }

    public function removeWishlistItem($userId, $placeId)
    {
        $sql = "DELETE FROM wishlist WHERE user_id = :userId AND place_id = :placeId";
        $params = [':userId' => $userId, ':placeId' => $placeId];
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        $rowCount = $stmt->rowCount();
        if ($rowCount > 0) {
            return true; 
        } else {
             return false; 
        }
    }

    public function isPlaceInSpecialOffer($placeId, $offerId)
    {
        $sql = "SELECT *
                FROM special_offers
                WHERE id = :offerId AND place_id = :placeId";

        $params = [
            ":offerId" => $offerId,
            ':placeId' => $placeId
        ];

        $result = $this->query($sql, $params);
        return $result->rowCount() > 0;
    }

    public function getRenablePlacesCountries(){
        $sql = "SELECT DISTINCT countries.name, countries.iso_code 
        FROM `rentable_places` INNER JOIN countries 
        ON rentable_places.country = countries.iso_code ORDER BY countries.name ASC";
        return $this->fetchAll($sql);
    }
}
?>