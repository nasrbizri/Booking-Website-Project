-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2023 at 04:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `main_db`
--

DROP DATABASE IF EXISTS `main_db`;
CREATE DATABASE `main_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `main_db`;

-- --------------------------------------------------------

--
-- Table structure for table `booking_details`
--

CREATE TABLE `booking_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `booking_date` datetime DEFAULT current_timestamp(),
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `total_guests` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_status` enum('paid','pending','canceled') DEFAULT NULL,
  `payment_method` enum('cash') NOT NULL DEFAULT 'cash',
  `booking_cancellation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `id` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `iso_code` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `iso_code`) VALUES
(1, 'Afghanistan', 'AF'),
(2, 'Albania', 'AL'),
(3, 'Algeria', 'DZ'),
(4, 'Andorra', 'AD'),
(5, 'Angola', 'AO'),
(6, 'Antigua and Barbuda', 'AG'),
(7, 'Argentina', 'AR'),
(8, 'Armenia', 'AM'),
(9, 'Australia', 'AU'),
(10, 'Austria', 'AT'),
(11, 'Azerbaijan', 'AZ'),
(12, 'Bahamas', 'BS'),
(13, 'Bahrain', 'BH'),
(14, 'Bangladesh', 'BD'),
(15, 'Barbados', 'BB'),
(16, 'Belarus', 'BY'),
(17, 'Belgium', 'BE'),
(18, 'Belize', 'BZ'),
(19, 'Benin', 'BJ'),
(20, 'Bhutan', 'BT'),
(21, 'Bolivia', 'BO'),
(22, 'Bosnia and Herzegovina', 'BA'),
(23, 'Botswana', 'BW'),
(24, 'Brazil', 'BR'),
(25, 'Brunei', 'BN'),
(26, 'Bulgaria', 'BG'),
(27, 'Burkina Faso', 'BF'),
(28, 'Burundi', 'BI'),
(29, 'Cabo Verde', 'CV'),
(30, 'Cambodia', 'KH'),
(31, 'Cameroon', 'CM'),
(32, 'Canada', 'CA'),
(33, 'Central African Republic', 'CF'),
(34, 'Chad', 'TD'),
(35, 'Chile', 'CL'),
(36, 'China', 'CN'),
(37, 'Colombia', 'CO'),
(38, 'Comoros', 'KM'),
(39, 'Congo', 'CG'),
(40, 'Costa Rica', 'CR'),
(41, 'Côte d\'Ivoire', 'CI'),
(42, 'Croatia', 'HR'),
(43, 'Cuba', 'CU'),
(44, 'Cyprus', 'CY'),
(45, 'Czech Republic', 'CZ'),
(46, 'Denmark', 'DK'),
(47, 'Djibouti', 'DJ'),
(48, 'Dominica', 'DM'),
(49, 'Dominican Republic', 'DO'),
(50, 'Ecuador', 'EC'),
(51, 'Egypt', 'EG'),
(52, 'El Salvador', 'SV'),
(53, 'Equatorial Guinea', 'GQ'),
(54, 'Eritrea', 'ER'),
(55, 'Estonia', 'EE'),
(56, 'Eswatini', 'SZ'),
(57, 'Ethiopia', 'ET'),
(58, 'Fiji', 'FJ'),
(59, 'Finland', 'FI'),
(60, 'France', 'FR'),
(61, 'Gabon', 'GA'),
(62, 'Gambia', 'GM'),
(63, 'Georgia', 'GE'),
(64, 'Germany', 'DE'),
(65, 'Ghana', 'GH'),
(66, 'Greece', 'GR'),
(67, 'Grenada', 'GD'),
(68, 'Guatemala', 'GT'),
(69, 'Guinea', 'GN'),
(70, 'Guinea-Bissau', 'GW'),
(71, 'Guyana', 'GY'),
(72, 'Haiti', 'HT'),
(73, 'Honduras', 'HN'),
(74, 'Hungary', 'HU'),
(75, 'Iceland', 'IS'),
(76, 'India', 'IN'),
(77, 'Indonesia', 'ID'),
(78, 'Iran', 'IR'),
(79, 'Iraq', 'IQ'),
(80, 'Ireland', 'IE'),
(81, 'Israel', 'IL'),
(82, 'Italy', 'IT'),
(83, 'Jamaica', 'JM'),
(84, 'Japan', 'JP'),
(85, 'Jordan', 'JO'),
(86, 'Kazakhstan', 'KZ'),
(87, 'Kenya', 'KE'),
(88, 'Kiribati', 'KI'),
(89, 'Korea, North', 'KP'),
(90, 'Korea, South', 'KR'),
(91, 'Kosovo', 'XK'),
(92, 'Kuwait', 'KW'),
(93, 'Kyrgyzstan', 'KG'),
(94, 'Laos', 'LA'),
(95, 'Latvia', 'LV'),
(96, 'Lebanon', 'LB'),
(97, 'Lesotho', 'LS'),
(98, 'Liberia', 'LR'),
(99, 'Libya', 'LY'),
(100, 'Liechtenstein', 'LI'),
(101, 'Lithuania', 'LT'),
(102, 'Luxembourg', 'LU'),
(103, 'Madagascar', 'MG'),
(104, 'Malawi', 'MW'),
(105, 'Malaysia', 'MY'),
(106, 'Maldives', 'MV'),
(107, 'Mali', 'ML'),
(108, 'Malta', 'MT'),
(109, 'Marshall Islands', 'MH'),
(110, 'Mauritania', 'MR'),
(111, 'Mauritius', 'MU'),
(112, 'Mexico', 'MX'),
(113, 'Micronesia', 'FM'),
(114, 'Moldova', 'MD'),
(115, 'Monaco', 'MC'),
(116, 'Mongolia', 'MN'),
(117, 'Montenegro', 'ME'),
(118, 'Morocco', 'MA'),
(119, 'Mozambique', 'MZ'),
(120, 'Myanmar', 'MM'),
(121, 'Namibia', 'NA'),
(122, 'Nauru', 'NR'),
(123, 'Nepal', 'NP'),
(124, 'Netherlands', 'NL'),
(125, 'New Zealand', 'NZ'),
(126, 'Nicaragua', 'NI'),
(127, 'Niger', 'NE'),
(128, 'Nigeria', 'NG'),
(129, 'North Macedonia', 'MK'),
(130, 'Norway', 'NO'),
(131, 'Oman', 'OM'),
(132, 'Pakistan', 'PK'),
(133, 'Palau', 'PW'),
(134, 'Palestine', 'PS'),
(135, 'Panama', 'PA'),
(136, 'Papua New Guinea', 'PG'),
(137, 'Paraguay', 'PY'),
(138, 'Peru', 'PE'),
(139, 'Philippines', 'PH'),
(140, 'Poland', 'PL'),
(141, 'Portugal', 'PT'),
(142, 'Qatar', 'QA'),
(143, 'Romania', 'RO'),
(144, 'Russia', 'RU'),
(145, 'Rwanda', 'RW'),
(146, 'Saint Kitts and Nevis', 'KN'),
(147, 'Saint Lucia', 'LC'),
(148, 'Saint Vincent and the Grenadines', 'VC'),
(149, 'Samoa', 'WS'),
(150, 'San Marino', 'SM'),
(151, 'Sao Tome and Principe', 'ST'),
(152, 'Saudi Arabia', 'SA'),
(153, 'Senegal', 'SN'),
(154, 'Serbia', 'RS'),
(155, 'Seychelles', 'SC'),
(156, 'Sierra Leone', 'SL'),
(157, 'Singapore', 'SG'),
(158, 'Slovakia', 'SK'),
(159, 'Slovenia', 'SI'),
(160, 'Solomon Islands', 'SB'),
(161, 'Somalia', 'SO'),
(162, 'South Africa', 'ZA'),
(163, 'South Sudan', 'SS'),
(164, 'Spain', 'ES'),
(165, 'Sri Lanka', 'LK'),
(166, 'Sudan', 'SD'),
(167, 'Suriname', 'SR'),
(168, 'Sweden', 'SE'),
(169, 'Switzerland', 'CH'),
(170, 'Syria', 'SY'),
(171, 'Taiwan', 'TW'),
(172, 'Tajikistan', 'TJ'),
(173, 'Tanzania', 'TZ'),
(174, 'Thailand', 'TH'),
(175, 'Timor-Leste', 'TL'),
(176, 'Togo', 'TG'),
(177, 'Tonga', 'TO'),
(178, 'Trinidad and Tobago', 'TT'),
(179, 'Tunisia', 'TN'),
(180, 'Turkey', 'TR'),
(181, 'Turkmenistan', 'TM'),
(182, 'Tuvalu', 'TV'),
(183, 'Uganda', 'UG'),
(184, 'Ukraine', 'UA'),
(185, 'United Arab Emirates', 'AE'),
(186, 'United Kingdom', 'GB'),
(187, 'United States', 'US'),
(188, 'Uruguay', 'UY'),
(189, 'Uzbekistan', 'UZ'),
(190, 'Vanuatu', 'VU'),
(191, 'Vatican City', 'VA'),
(192, 'Venezuela', 'VE'),
(193, 'Vietnam', 'VN'),
(194, 'Yemen', 'YE'),
(195, 'Zambia', 'ZM'),
(196, 'Zimbabwe', 'ZW');

-- --------------------------------------------------------

--
-- Table structure for table `inbox_messages`
--

CREATE TABLE `inbox_messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `read` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `neighborhood_concern`
--

CREATE TABLE `neighborhood_concern` (
  `id` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('booking_confirmed','review_recieved','message_recieved') NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `sent` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `optimized_offers`
--

CREATE TABLE `optimized_offers` (
  `offer_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `discount_percentage` int(11) NOT NULL,
  `airbnb_id` int(11) NOT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `airbnbtype` varchar(255) NOT NULL,
  `numberofguests` int(11) NOT NULL,
  `numberofbedrooms` int(20) NOT NULL,
  `numberofbathrooms` int(11) NOT NULL,
  `cancellationpolicy` varchar(255) NOT NULL,
  `pricenight` decimal(10,2) NOT NULL,
  `newPrice` decimal(10,0) GENERATED ALWAYS AS (`pricenight` * (1 - `discount_percentage` / 100)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `optimized_offers`
--

INSERT INTO `optimized_offers` (`offer_id`, `title`, `discount_percentage`, `airbnb_id`, `coupon_code`, `country`, `state`, `address`, `city`, `airbnbtype`, `numberofguests`, `numberofbedrooms`, `numberofbathrooms`, `cancellationpolicy`, `pricenight`) VALUES
(1, 'Early Bird Discount', 10, 3, 'EARLYBIRD10', 'France', '', '45 Rue de Rivoli', 'Paris', 'apartment', 2, 1, 1, 'Moderate', 125.00),
(2, 'Last Minute Deal', 15, 1, 'LASTMINUTE15', 'USA', 'NV', '456 Mountain Lane', 'Lake Tahoe', 'cabin', 6, 4, 3, 'Strict', 200.00),
(3, 'Weekday Nights Deal!', 50, 5, 'WEEKDEALS', 'Italy', '', 'Via del Sole, Tuscany', 'Florence', 'guest suite', 8, 4, 3, 'Flexible', 300.00),
(4, 'Honeymoon Special', 15, 7, 'HONEYMOON15', 'Iceland', '', 'Jokulsarlon Glacier Lagoon', 'Vik i Myrdal', 'house', 2, 1, 1, 'Strict', 200.00),
(5, 'Birthday Surprise', 10, 4, 'BIRTHDAY10', 'Japan', '', 'Gion District, Kyoto', 'Kyoto', 'other', 4, 2, 2, 'Strict', 250.00);

-- --------------------------------------------------------

--
-- Table structure for table `rentable_places`
--

CREATE TABLE `rentable_places` (
  `id` int(11) NOT NULL,
  `image` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(2) NOT NULL,
  `type` enum('apartment','house','cabin','private room','hotel room','shared room','chalet','resort','guest suite','other') DEFAULT NULL,
  `total_guests` int(11) NOT NULL,
  `total_bedrooms` int(11) NOT NULL,
  `total_bathrooms` int(11) NOT NULL,
  `cancellation_policy` text DEFAULT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `minimum_stay` int(11) NOT NULL,
  `availability_calendar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rentable_places`
--

INSERT INTO `rentable_places` (`id`, `image`, `title`, `description`, `address`, `city`, `state`, `country`, `type`, `total_guests`, `total_bedrooms`, `total_bathrooms`, `cancellation_policy`, `price_per_night`, `minimum_stay`, `availability_calendar`) VALUES
(1, 'img/house1.jpg', 'Modern Mountain Lodge', 'Escape to the mountains and enjoy breathtaking views in this spacious lodge. ', '456 Mountain Lane', 'Lake Tahoe', 'NV', 'US', 'cabin', 6, 4, 3, 'Strict', 200.00, 3, '[\r\n  {\r\n    \"start_date\": \"2024-10-28\",\r\n    \"end_date\": \"2024-10-31\",\r\n    \"available\": true\r\n  },\r\n  {\r\n    \"start_date\": \"2024-11-05\",\r\n    \"end_date\": \"2024-11-07\",\r\n    \"available\": true\r\n  }\r\n]'),
(2, 'img/house2.jpg', 'Cozy Beachfront Apartment', 'Enjoy stunning ocean views and a relaxing beach getaway in this comfortable apartment.', '123 Main Street', 'Santa Monica', 'CA', 'US', 'apartment', 4, 2, 1, 'Flexible', 150.00, 2, '[\r\n    {\r\n      \"start_date\": \"2024-02-28\",\r\n      \"end_date\": \"2024-03-30\",\r\n      \"available\": true\r\n    },\r\n    {\r\n      \"start_date\": \"2024-05-05\",\r\n      \"end_date\": \"2024-05-09\",\r\n      \"available\": true\r\n    }\r\n  ]'),
(3, 'img/house3.jpg', 'Romantic Parisian Apartment', 'Experience Parisian charm in this cozy apartment with stunning city views. Perfect for couples.', '45 Rue de Rivoli', 'Paris', '', 'FR', 'apartment', 2, 1, 1, 'Moderate', 125.00, 3, '[{\"start_date\": \"2024-04-15\", \"end_date\": \"2025-06-05\", \"available\": true}]'),
(4, 'img/house4.jpg', 'Traditional Ryokan in Kyoto', 'Immerse yourself in Japanese culture in this authentic ryokan. Tatami mats, futons, and onsen included!', 'Gion District, Kyoto', 'Kyoto', '', 'JP', 'other', 4, 2, 2, 'Strict', 250.00, 2, '[{\"start_date\": \"2024-04-18\", \"end_date\": \"2024-06-25\", \"available\": true}]'),
(5, 'img/house5.jpg', 'Tuscan Villa with Pool', 'Unwind and enjoy the Italian countryside in this charming villa with a private pool.', 'Via del Sole, Tuscany', 'Florence', '', 'IT', 'guest suite', 8, 4, 3, 'Flexible', 300.00, 5, '[{\"start_date\": \"2024-06-15\", \"end_date\": \"2024-07-15\", \"available\": true}]'),
(6, 'img/house6.jpg', 'Luxurious Beachfront Villa', 'Indulge in luxury and beachfront living in this stunning villa with private pool and ocean views', 'Playa del Carmen', 'Quintana Roo', '', 'ME', 'chalet', 10, 5, 5, 'Flexible', 750.00, 7, '[{\"start_date\": \"2024-03-20\", \"end_date\": \"2025-01-05\", \"available\": true}]'),
(7, 'img/house7.jpg', 'Cozy house with Northern Lights View', 'Witness the magical aurora borealis from this secluded cabin in the Icelandic wilderness.', 'Jokulsarlon Glacier Lagoon', 'Vik i Myrdal', '', 'IS', 'house', 2, 1, 1, 'Strict', 200.00, 3, '[{\"start_date\": \"2024-10-20\", \"end_date\": \"2025-03-20\", \"available\": true}]'),
(8, 'img/house8.jpg', 'Charming apartment in the city center', 'This cozy apartment offers a perfect home base for exploring the city.', '123 Main Street', 'New York', 'NY', 'US', 'apartment', 2, 1, 1, 'Flexible cancellation', 100.00, 2, '[{\"start_date\": \"2024-10-24\", \"end_date\": \"2024-11-01\", \"available\": true}]'),
(9, 'img/house9.jpg', 'Cozy apartment in the city center', 'This cozy apartment offers a perfect home base for exploring the city.', '123 Main Street', 'New York', 'NY', 'US', 'apartment', 2, 1, 1, 'Flexible cancellation', 100.00, 2, '[\r\n    {\r\n      \"start_date\": \"2024-01-1\",\r\n      \"end_date\": \"2024-03-10\",\r\n      \"available\": true\r\n    },\r\n    {\r\n      \"start_date\": \"2024-05-05\",\r\n      \"end_date\": \"2024-05-09\",\r\n      \"available\": true\r\n    }\r\n  ]'),
(10, 'img/house10.jpg', 'Cozy apartment in the city center', 'This cozy apartment offers a perfect home base for exploring the city.', '123 Main Street', 'New York', 'NY', 'US', 'apartment', 2, 1, 1, 'Flexible cancellation', 100.00, 2, '[ { \"start_date\": \"2024-01-1\", \"end_date\": \"2024-03-10\", \"available\": true }, { \"start_date\": \"2024-05-05\", \"end_date\": \"2024-05-09\", \"available\": true } ]'),
(11, 'img/house11.jpg', 'Luxury beachfront villa', 'Enjoy stunning ocean views and private access to the beach.', '456 Ocean Drive', 'Miami', 'FL', 'US', '', 6, 3, 2, 'Strict cancellation', 500.00, 7, '[ { \"start_date\": \"2024-03-1\", \"end_date\": \"2024-03-10\", \"available\": true }, { \"start_date\": \"2024-05-024\", \"end_date\": \"2024-05-29\", \"available\": true } ]'),
(12, 'img/house12.jpg', 'Charming cottage in the countryside', 'Escape to the tranquility of this cozy cottage surrounded by rolling hills.', '789 Country Lane', 'Austin', 'TX', 'US', 'cabin', 4, 2, 1, 'Flexible cancellation', 250.00, 3, '[{\"start_date\": \"2024-04-15\", \"end_date\": \"2024-04-22\", \"available\": true}]'),
(13, 'img/house13.jpg', 'Modern loft apartment', 'Enjoy a stylish and spacious stay with breathtaking city views.', '1011 Main Street', 'Chicago', 'IL', 'US', 'apartment', 2, 1, 1, 'Strict cancellation', 400.00, 5, '[{\"start_date\": \"2024-02-01\", \"end_date\": \"2024-02-29\", \"available\": true}]'),
(14, 'img/house14.jpg', 'Tuscan villa with private pool', 'Enjoy the Italian countryside in this luxurious villa with breathtaking views.', '789 Villa Road', 'Siena', 'Italy', 'IT', 'chalet', 6, 3, 3, 'Strict cancellation', 800.00, 7, '[{\"start_date\": \"2024-06-15\", \"end_date\": \"2024-06-30\", \"available\": true}]'),
(16, 'img/house16.jpg', 'Beachfront bungalow in Tulum', 'Relax and unwind in this charming bungalow steps away from the pristine Caribbean Sea.', '1011 Playa del Carmen', 'Tulum', 'Mexico', 'ME', '', 2, 1, 1, 'Flexible cancellation', 100.00, 2, '[{\"start_date\": \"2024-05-01\", \"end_date\": \"2024-05-15\", \"available\": true}]'),
(17, 'img/house17.jpg', 'Modern apartment in Rio de Janeiro', 'Experience the vibrant energy of Rio in this stylish apartment with panoramic city views.', '123 Copacabana Beach', 'Rio de Janeiro', 'Brazil', 'BR', 'apartment', 4, 2, 2, 'Strict cancellation', 350.00, 5, '[{\"start_date\": \"2024-01-24\", \"end_date\": \"2025-02-15\", \"available\": true}]'),
(18, 'img/house18.jpg', 'Cozy Bavarian chalet', 'Enjoy breathtaking mountain views and charming Bavarian traditions in this cozy chalet.', '456 Alpenstraße', 'Garmisch-Partenkirchen', 'Bavaria', 'GE', 'chalet', 4, 2, 2, 'Moderate cancellation', 200.00, 3, '[{\"start_date\": \"2024-10-24\", \"end_date\": \"2024-11-01\", \"available\": true}]'),
(19, 'img/house19.jpg', 'Luxury safari lodge in Kruger National Park', 'Experience the thrill of a safari from this luxurious lodge with stunning wildlife encounters.', '789 Kruger Road', 'Skukuza', 'Mpumalanga', 'SO', '', 6, 3, 3, 'Strict cancellation', 500.00, 4, '[{\"start_date\": \"2024-08-05\", \"end_date\": \"2024-08-12\", \"available\": true}]'),
(22, 'img/house22.jpg', 'Beachfront apartment in Bondi Beach', 'Enjoy the iconic Bondi Beach lifestyle in this stylish apartment with stunning ocean views.', '1011 Beach Road', 'Sydney', 'New South Wales', 'AU', 'apartment', 2, 1, 1, 'Flexible cancellation', 150.00, 2, '[{\"start_date\": \"2024-12-20\", \"end_date\": \"2024-12-27\", \"available\": true}]');

-- --------------------------------------------------------

--
-- Table structure for table `special_offers`
--

CREATE TABLE `special_offers` (
  `id` int(11) NOT NULL,
  `image` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `discount` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `coupon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `special_offers`
--

INSERT INTO `special_offers` (`id`, `image`, `title`, `description`, `discount`, `start_date`, `end_date`, `place_id`, `coupon`) VALUES
(1, 'img/dest3.jpg', 'Early Bird Discount', 'Book your stay 30 days in advance and get 10% off!', 10, '2024-12-27', '2025-02-28', 3, 'EARLYBIRD10'),
(2, 'img/dest1.jpg', 'Last Minute Deal', 'Book your stay within 7 days of arrival and get 15% off!', 15, '2023-12-31', '2024-01-15', 1, 'LASTMINUTE15'),
(3, 'img/dest2.jpg', 'Weekday Nights Deal!', 'Book a week-long stay and get all weekdays at 50% off!', 50, '2023-11-30', '2024-02-29', 5, 'WEEKDEALS'),
(4, 'img/dest4.jpg', 'Honeymoon Special', 'Celebrate your honeymoon with a luxurious stay and 15% off!', 15, '2024-02-24', '2024-05-31', 7, 'HONEYMOON15'),
(5, 'img/dest5.jpg', 'Birthday Surprise', 'Enjoy 10% off your stay during your birthday month!', 10, '2023-12-31', '2024-12-31', 4, 'BIRTHDAY10'),
(6, 'img/dest6.jpg', 'Weekend Getaway', 'Relax and unwind at a beautiful beachfront Airbnb', 10, '2023-12-15', '2023-12-17', 4, 'WEEKEND20'),
(7, 'img/dest7.jpg', 'Free Breakfast for Two', 'Enjoy a delicious and complimentary breakfast during your stay.', 15, '2023-12-12', '2023-12-31', 13, 'FREEMEAL'),
(9, 'img/dest9.jpg', 'Weekend Getaway 20% Off', 'Book your weekend getaway and enjoy 20% off your stay!', 20, '2024-01-13', '2024-01-15', 6, 'WEEKENDGETAWAY'),
(10, 'img/dest10.jpg', 'Romantic Escape Package', 'Indulge in a special romantic getaway with a 10% discount and a complimentary bottle of champagne.', 0, '2024-02-14', '2024-02-17', 4, 'ROMANCE10'),
(11, 'img/dest11.jpg', 'Stay Longer, Save More!', 'Book a long-term stay of 7 nights or more and receive a 30% discount!', 30, '2024-03-01', '2024-03-31', 8, 'LONGSTAY30');

-- --------------------------------------------------------

--
-- Table structure for table `trips_history`
--

CREATE TABLE `trips_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `booking_details_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `sex` enum('male','female') NOT NULL,
  `birthdate` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `agreed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `firstname`, `lastname`, `sex`, `birthdate`, `phone`, `verified`, `agreed`) VALUES
(22, '$2y$10$5/4eP12NpyA67YyNMSmBeee3OF6CX/keTy/g0hxfU9kv0x1XbxcPi', 'yo@test.com', 'Some', 'One', 'male', '2023-12-15', '70432218', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `ProfileID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Bio` text DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `LanguagesSpoken` text DEFAULT NULL,
  `Interests` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_reviews`
--

CREATE TABLE `user_reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `ReviewText` text DEFAULT NULL,
  `posted` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `added_on` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_details`
--
ALTER TABLE `booking_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserID` (`user_id`),
  ADD KEY `AirbnbID` (`place_id`);

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inbox_messages`
--
ALTER TABLE `inbox_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SenderID` (`sender_id`),
  ADD KEY `ReceiverID` (`receiver_id`);

--
-- Indexes for table `neighborhood_concern`
--
ALTER TABLE `neighborhood_concern`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `optimized_offers`
--
ALTER TABLE `optimized_offers`
  ADD PRIMARY KEY (`offer_id`),
  ADD KEY `airbnb_id` (`airbnb_id`);

--
-- Indexes for table `rentable_places`
--
ALTER TABLE `rentable_places`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `special_offers`
--
ALTER TABLE `special_offers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `CouponCode` (`coupon`),
  ADD KEY `AirbnbID` (`place_id`);

--
-- Indexes for table `trips_history`
--
ALTER TABLE `trips_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserID` (`user_id`),
  ADD KEY `booking_detail_id` (`booking_details_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `PhoneNumber` (`phone`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`ProfileID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `user_reviews`
--
ALTER TABLE `user_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserID` (`user_id`),
  ADD KEY `AirbnbID` (`place_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `place_id` (`place_id`),
  ADD KEY `UserID` (`user_id`),
  ADD KEY `AirbnbID` (`place_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_details`
--
ALTER TABLE `booking_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `inbox_messages`
--
ALTER TABLE `inbox_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `neighborhood_concern`
--
ALTER TABLE `neighborhood_concern`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rentable_places`
--
ALTER TABLE `rentable_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `special_offers`
--
ALTER TABLE `special_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `trips_history`
--
ALTER TABLE `trips_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `ProfileID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_reviews`
--
ALTER TABLE `user_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_details`
--
ALTER TABLE `booking_details`
  ADD CONSTRAINT `booking_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `booking_details_ibfk_2` FOREIGN KEY (`place_id`) REFERENCES `rentable_places` (`id`);

--
-- Constraints for table `inbox_messages`
--
ALTER TABLE `inbox_messages`
  ADD CONSTRAINT `inbox_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inbox_messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `optimized_offers`
--
ALTER TABLE `optimized_offers`
  ADD CONSTRAINT `optimized_offers_ibfk_1` FOREIGN KEY (`airbnb_id`) REFERENCES `rentable_places` (`id`);

--
-- Constraints for table `special_offers`
--
ALTER TABLE `special_offers`
  ADD CONSTRAINT `special_offers_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `rentable_places` (`id`);

--
-- Constraints for table `trips_history`
--
ALTER TABLE `trips_history`
  ADD CONSTRAINT `trips_history_ibfk_1` FOREIGN KEY (`booking_details_id`) REFERENCES `booking_details` (`id`);

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_reviews`
--
ALTER TABLE `user_reviews`
  ADD CONSTRAINT `user_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_reviews_ibfk_2` FOREIGN KEY (`place_id`) REFERENCES `rentable_places` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
