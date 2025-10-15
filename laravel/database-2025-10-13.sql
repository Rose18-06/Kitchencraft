

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";



CREATE TABLE `activity` (
  `dataid` int(10) NOT NULL,
  `title` varchar(80) NOT NULL,
  `activity` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `seen` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `add_ons` (
  `dataid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `priceSale` decimal(10,2) DEFAULT 0.00,
  `photo` text DEFAULT NULL,
  `status` varchar(3) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `add_ons`
--

INSERT INTO `add_ons` (`dataid`, `name`, `description`, `price`, `priceSale`, `photo`, `status`) VALUES
(2, 'KARAOKE', 'Like karaoke, it\'s a social activity where people sing along to instrumental tracks, however, videoke machines include a scoring system that rates your performance on a scale, typically out of 100', '1000.00', '700.00', 'IMG-12162024081529-WWB.png', '1'),
(3, 'Clown', 'Clown, familiar comic character of pantomime and circus, known by distinctive makeup and costume, ludicrous antics, and buffoonery, whose purpose is to induce hearty laughter. The clown, unlike the traditional fool or court jester, usually performs a set routine characterized by broad, graphic humour, absurd situations, and vigorous physical action.', '5000.00', '4500.00', 'IMG-12162024081443-4B3.png', '1'),
(13, 'Photographer', 'test description', '5000.00', '0.00', 'IMG-12162024081616-G52.png', '1');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `dataid` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` int(3) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`dataid`, `title`, `description`, `photo`, `status`, `created_at`) VALUES
(1, 'Reunion', 'Thankyou for choosing us!', 'IMG-12162024090014-13Z.png', 1, '2024-10-02 23:55:46'),
(4, '60th Birthday', 'Thankyou for Choosing Us!', 'IMG-12162024085904-AP9.png', 1, '2024-10-03 08:15:18'),
(7, '@18 Birthday', 'Thankyou for choosing us!', 'IMG-12162024085807-P5C.png', 0, '2024-10-20 18:14:07'),
(8, 'Happy 40th Anniversary', 'Thankyou for choosing Loretos Kitchenette', 'IMG-12162024085558-HQY.png', 0, '2024-10-20 18:15:39'),
(9, '55th Birthday!', 'Thankyou for Celebrating you Birthday here at Loreto\'s Kitchenette', 'IMG-12162024085232-2OH.png', 0, '2024-10-20 18:17:17'),
(10, 'AVON COSMETICS', 'Thankyou for celebrating here at loreto\'s kitchenette', 'IMG-12162024084831-RZX.png', 0, '2024-10-20 18:18:07');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `dataid` int(11) NOT NULL,
  `user_dataid` int(10) DEFAULT NULL,
  `event_dataid` int(10) DEFAULT NULL,
  `event_pax_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `event_theme_dataid` int(10) DEFAULT NULL,
  `event_location` varchar(80) DEFAULT NULL,
  `event_location_dataid` int(3) NOT NULL DEFAULT 0,
  `event_pax` int(10) NOT NULL DEFAULT 0,
  `event_applied_fee` decimal(10,2) NOT NULL DEFAULT 0.00,
  `event_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `event_date` date DEFAULT NULL,
  `event_start_time` time DEFAULT NULL,
  `event_end_time` time DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `valid_id_path` text DEFAULT NULL,
  `payment_receipt` text DEFAULT NULL,
  `payment_refid` varchar(60) DEFAULT NULL,
  `payment_sender` varchar(60) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT 0.00,
  `contract` int(3) NOT NULL DEFAULT 0,
  `status` int(3) NOT NULL DEFAULT 0,
  `path_contract` text DEFAULT NULL,
  `path_details` text DEFAULT NULL,
  `add_fee_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `add_fee_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `booking_activity` (
  `dataid` int(10) NOT NULL,
  `booking_dataid` int(10) DEFAULT NULL,
  `title` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sort` int(3) NOT NULL DEFAULT 0,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `booking_addons` (
  `dataid` int(10) NOT NULL,
  `booking_dataid` int(10) DEFAULT NULL,
  `addon_dataid` int(10) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `booking_foods` (
  `dataid` int(10) NOT NULL,
  `booking_dataid` int(10) DEFAULT NULL,
  `menu_dataid` int(10) DEFAULT NULL,
  `menu_category` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `categories` (
  `cat_id` int(255) NOT NULL,
  `cat_name` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `datecreated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `status`, `datecreated`) VALUES
(113, 'FAMILY', 0, '2024-10-20 11:31:27'),
(115, 'VILLA', 0, '2024-10-20 13:44:24'),
(116, 'MANUEL', 0, '2024-10-20 14:20:26'),
(117, 'STEPHANIE', 0, '2024-10-20 14:20:43'),
(118, 'ANDREA', 0, '2024-10-20 14:21:17');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `dataid` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `package` text DEFAULT NULL,
  `min_occupancy` int(10) NOT NULL DEFAULT 0,
  `max_occupancy` int(10) DEFAULT 0,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `photo` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`dataid`, `name`, `description`, `package`, `min_occupancy`, `max_occupancy`, `price`, `photo`, `created_at`) VALUES
(89, 'WEDDING', 'A wedding is a joyful celebration of love, made special with features like tables and chairs for guests, a fully air-conditioned venue for comfort, and existing décor that enhances the ambiance.', 'Tables and Chairs\nFully Air Condtioned\nExisting Decor', 20, 60, '500.00', 'IMG-12162024074358-I0H.png', '2024-12-06 01:02:19'),
(90, 'REUNION', 'A reunion is a joyful gathering of family or friends to reconnect and share memories, made special with tables and chairs for comfort, a fully air-conditioned venue to ensure everyone feels at ease, and existing décor that adds charm and warmth to the event.', 'Tables and Chairs\r\nFully Air Condtioned\r\nExisting Decor', 20, 60, '500.00', 'IMG-12162024074330-X1O.png', '2024-12-06 01:32:41'),
(91, 'BIRTHDAY', 'A birthday is a joyful celebration of life, made special with features like tables and chairs for guests, a fully air-conditioned venue for comfort, and existing décor that adds to the festive atmosphere.', 'Tables and Chairs\r\nFully Air Condtioned\r\nExisting Decor', 20, 60, '500.00', 'IMG-12162024074102-S7A.png', '2024-12-06 01:33:30'),
(92, 'GRADUATION', 'A graduation is a proud celebration of achievement, enhanced by features like tables and chairs for guests, a fully air-conditioned venue for comfort, and existing décor that adds to the formal and festive mood.', 'Tables and Chairs\r\nFully Air Condtioned\r\nExisting Decor', 20, 60, '500.00', 'IMG-12162024074319-KRP.png', '2024-12-06 01:34:18'),
(93, 'DEBUT', 'A debut is a grand celebration of a young woman’s 18th birthday, made memorable with tables and chairs for guests, a fully air-conditioned venue for comfort, and existing décor that adds elegance and charm to the event.', 'Tables and Chairs\r\nFully Air Condtioned\r\nExisting Decor', 20, 60, '500.00', 'IMG-12162024074212-G1A.png', '2024-12-06 01:34:56'),
(104, 'BAPTISM', 'TESTDESCRIPTION', 'SDAADADA', 25, 60, '500.00', 'IMG-12162024024435-K4L.png', '2024-12-16 06:45:27');

-- --------------------------------------------------------

--
-- Table structure for table `inquiry`
--

CREATE TABLE `inquiry` (
  `dataid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` text DEFAULT NULL,
  `message` text NOT NULL,
  `status` varchar(3) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `inventory_stocks` (
  `dataid` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock` decimal(10,2) NOT NULL DEFAULT 0.00,
  `lost` decimal(10,2) DEFAULT 0.00,
  `damage` decimal(10,2) DEFAULT 0.00,
  `status` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `inventory_stocks` (`dataid`, `name`, `price`, `stock`, `lost`, `damage`, `status`) VALUES
(2, 'Chairs', '97.00', '243.00', '0.00', '2.00', 1),
(3, 'Tables', '300.00', '140.00', NULL, '5.00', 1),
(4, 'Fork', '300.00', '-60.00', '2.00', '6.00', 1),
(5, 'Plates', '300.00', '140.00', NULL, NULL, 1),
(6, 'Sound System', '300.00', '90.00', '3.00', NULL, 1);

CREATE TABLE `location` (
  `dataid` int(10) NOT NULL,
  `location` varchar(80) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `venue` text DEFAULT NULL,
  `inclusions` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `applied_fee` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`dataid`, `location`, `price`, `venue`, `inclusions`, `remarks`, `applied_fee`) VALUES
(1, 'Loreto\'s Kitchenette', '350.00', 'FREE for the first 3 hours. Succeeding additional 500/hr', 'Tables and chairs, fully air conditioned and with existing decor.', 'Reservation of PHP1000 is applied', '1000.00'),
(2, 'Eric and Son', '450.00', 'See updated eric and sons rate', 'Sound system, table and chairs with dressing room', 'With rooms for rent incase visitor tend to stay and RESERVATION of 1000 is applied', '1000.00'),
(3, 'Within Urdaneta', '500.00', NULL, 'with tables and chairs', '20% Downpayment or 5000 is applied', '5000.00'),
(4, 'Outside Urdaneta', '650.00', NULL, 'with tables and chairs', '20% Downpayment or 5000 is applied', '5000.00');

CREATE TABLE `marketing` (
  `dataid` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `photo` text DEFAULT NULL,
  `status` int(3) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `marketing` (`dataid`, `title`, `content`, `photo`, `status`) VALUES
(18, 'SALE', 'SALE', 'IMG-12292024102549-CUP.png', 1),
(21, 'testtest', 'testtesttesttesttesttesttesttesttesttest', 'IMG-01102025082718-LH6.mp4', 1);

CREATE TABLE `menu` (
  `dataid` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `package` text DEFAULT NULL,
  `photo` text DEFAULT NULL,
  `status` int(3) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `menu` (`dataid`, `name`, `category`, `description`, `package`, `photo`, `status`) VALUES
(42, 'Fried Chicken', 'Chicken', 'Fried chicken is crispy, golden chicken seasoned and deep-fried to perfection, tender and juicy inside.', 'Good for 10 pax', 'IMG-12162024075823-U50.png', 1),
(43, 'Estofado', 'Beef', 'Beef estofado is a Filipino dish of tender beef in a savory-sweet sauce, paired with carrots, potatoes, and sometimes fried plantains. Perfect with steamed rice.', 'test offer', 'IMG-12162024075605-MLH.png', 1),
(44, 'Kaldereta', 'Beef', 'Kaldereta is a Filipino stew of tender meat in a rich tomato-based sauce with potatoes, carrots, bell peppers, and a touch of liver spread or cheese.', 'test offer', 'IMG-12162024080006-V0R.png', 1),
(45, 'Korean', 'Beef', 'Korean beef features tender slices marinated in soy sauce, garlic, sesame oil, and sugar, often grilled or stir-fried.', 'test offer', 'IMG-12162024080040-KN4.png', 1),
(46, 'Beefy Mushroom', 'Beef', 'Beefy mushroom is a savory dish of tender beef and mushrooms in a creamy, flavorful sauce. Perfect over rice or pasta.', 'test offer', 'IMG-12162024074651-P1R.png', 1),
(47, 'Embotido', 'Pork', 'Pork embotido is a Filipino meatloaf made of ground pork, eggs, breadcrumbs, and seasonings, often with fillings like sausage or eggs.', 'test offer', 'IMG-12162024075531-RC0.png', 1),
(48, 'Spring Roll/Shanghai', 'Pork', 'Spring roll Shanghai is a Filipino snack of crispy fried rolls filled with seasoned ground meat, often pork, and vegetables.', 'test offer', 'IMG-12162024080253-QKC.png', 1),
(49, 'Sweet and Sour', 'Pork', 'Sweet and sour pork features crispy fried pork tossed in a tangy-sweet sauce with bell peppers, pineapple, and onions.', 'test offer', 'IMG-12162024080326-D7Z.png', 1),
(50, 'Cordon Bleu', 'Chicken', 'Chicken cordon bleu is breaded chicken stuffed with ham and cheese, fried or baked until golden and crispy.', 'test offer', 'IMG-12162024075505-2AE.png', 1),
(51, 'Honey Glazed', 'Chicken', 'Honey glazed chicken is tender chicken coated in a sweet, sticky honey sauce, often with hints of garlic and soy for added flavor.', 'test offer', 'IMG-12162024075922-P81.png', 1),
(52, 'Lemon', 'Chicken', 'Lemon chicken is a dish where tender chicken is coated in a tangy, zesty lemon sauce, often with garlic and herbs.', 'test offer', 'IMG-12162024080128-6FP.png', 1),
(53, 'Salt and Pepper Fillet', 'Fish', 'Salt and pepper fillet fish is a crispy, lightly seasoned fish fillet fried with salt, pepper, and sometimes garlic for a simple, flavorful dish.', 'test offer', 'IMG-12162024080224-T82.png', 1),
(54, 'Fillet With Tar-tar', 'Fish', 'Fillet with tartar sauce features a crispy fried fish fillet served with a creamy, tangy tartar sauce made with mayo, pickles, and herbs.', 'test offer', 'IMG-12162024075804-6NH.png', 1),
(55, 'Fillet With Sweet and Sour', 'Fish', 'Fillet with sweet and sour features a crispy fish fillet topped with a tangy-sweet sauce, often with bell peppers, pineapple, and onions.', 'test offer', 'IMG-12162024075628-GMG.png', 1),
(56, 'Chopsuey', 'Vegetable', 'Chopsuey is a stir-fried dish made with a variety of vegetables like carrots, cabbage, and bell peppers, cooked in a savory sauce.', 'test offer', 'IMG-12162024075313-D5P.png', 1),
(57, 'Brocolli With Tofu', 'Vegetable', 'Broccoli with tofu is a dish featuring tender broccoli and crispy tofu, typically cooked in a savory sauce with garlic and seasonings.', 'test offer', 'IMG-12162024075046-5IG.png', 1),
(58, 'Buttered Vegetable', 'Vegetable', 'Buttered vegetables are a mix of vegetables, like carrots, peas, and corn, sautéed in butter for a rich and flavorful dish.', 'test offer', 'IMG-12162024075252-7F5.png', 1),
(59, 'Macaroni Salad', 'Dessert', 'Macaroni salad is a creamy dish made with cooked macaroni, mayonnaise, and mixed vegetables, often including peas, carrots, and onions.', 'test offer', 'IMG-12162024080201-7DX.png', 1),
(60, 'Buko Salad', 'Dessert', 'Buko salad is a Filipino dessert made with young coconut, mixed fruits, and a creamy dressing of sweetened condensed milk and cream.', 'test', NULL, 1),
(61, 'Buko Pandan', 'Dessert', 'Buko pandan is a Filipino dessert made with young coconut, pandan-flavored jelly, and a sweet, creamy mixture of condensed milk and cream.', 'test offer', 'IMG-12162024075208-EL6.png', 1),
(62, 'Coffee Jelly', 'Dessert', 'Coffee jelly is a dessert made of coffee-flavored jelly cubes served with sweetened cream or milk.', 'test offer', 'IMG-12162024075432-H6G.png', 1),
(63, 'Graham Cake', 'Dessert', 'Graham cake is a no-bake dessert made with layers of graham crackers, sweetened cream.', 'test offer', 'IMG-12162024075849-L2N.png', 1);


CREATE TABLE `menu_categories` (
  `dataid` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_categories`
--

INSERT INTO `menu_categories` (`dataid`, `name`, `description`) VALUES
(1, 'Pork', 'The fresh or salted flesh of swine when dressed for food.'),
(2, 'Beef', 'The flesh of an adult domestic bovine (such as a steer or cow) used as food.'),
(10, 'Chicken', 'The common domestic fowl (Gallus gallus) especially when young. also : its flesh used as food compare jungle fowl'),
(12, 'Fish', NULL),
(13, 'Dessert', NULL),
(20, 'Vegetable', 'A usually herbaceous plant (such as the cabbage, bean, or potato) grown for an edible part that is usually eaten as part of a meal.');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `dataid` int(11) NOT NULL,
  `user_dataid` int(10) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `seen` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `template` (
  `dataid` int(10) NOT NULL,
  `access_code` varchar(26) DEFAULT NULL,
  `content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `template` (`dataid`, `access_code`, `content`) VALUES
(1, 'CONTRACT_TEMPLATE', '<p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:20:21\" data-v-3a7e46ba=\"\">Catering Service Agreement Form EDITED111</p><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:21:21\" data-v-3a7e46ba=\"\">This Agreement is made between Loreto\'s Kitchenette (\"the Caterer\") and the Customer (\"the Client\"). By signing this Agreement, the Client agrees to the following terms and conditions:</p><hr data-v-inspector=\"src/components/ModalContractEditor.vue:22:21\" data-v-3a7e46ba=\"\"><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:23:21\" data-v-3a7e46ba=\"\">Charges Outside Venue EDITED1</p><ol data-v-inspector=\"src/components/ModalContractEditor.vue:24:21\" data-v-3a7e46ba=\"\"><li data-v-inspector=\"src/components/ModalContractEditor.vue:25:23\" data-v-3a7e46ba=\"\">Event Extension: If the event extends beyond the agreed duration, an additional charge of Php 1,000 per hour will apply.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:26:23\" data-v-3a7e46ba=\"\"> Menu Changes After Reservation: <ul style=\"list-style-type:circle;\" data-v-inspector=\"src/components/ModalContractEditor.vue:28:25\" data-v-3a7e46ba=\"\"><li data-v-inspector=\"src/components/ModalContractEditor.vue:29:27\" data-v-3a7e46ba=\"\"><span data-v-inspector=\"src/components/ModalContractEditor.vue:29:31\" data-v-3a7e46ba=\"\"></span>The Client may request changes to the menu 2-5 days before the reservation date, provided that the preparation of the menu has not yet commenced.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:30:27\" data-v-3a7e46ba=\"\"><span data-v-inspector=\"src/components/ModalContractEditor.vue:30:31\" data-v-3a7e46ba=\"\"></span>Any menu changes requested after the specified timeframe or once preparation has begun will incur additional charges, which will depend on the complexity and cost of the new menu.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:31:27\" data-v-3a7e46ba=\"\"><span data-v-inspector=\"src/components/ModalContractEditor.vue:31:31\" data-v-3a7e46ba=\"\"></span>Additional charges may apply if the requested changes result in costs exceeding the original menu price.</li></ul></li></ol><hr data-v-inspector=\"src/components/ModalContractEditor.vue:35:21\" data-v-3a7e46ba=\"\"><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:36:21\" data-v-3a7e46ba=\"\">Salary of Staff (Overtime)</p><ol data-v-inspector=\"src/components/ModalContractEditor.vue:37:21\" data-v-3a7e46ba=\"\"><li data-v-inspector=\"src/components/ModalContractEditor.vue:38:23\" data-v-3a7e46ba=\"\">The usual duration of an event is 3-4 hours.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:39:23\" data-v-3a7e46ba=\"\">If the event exceeds this duration, a corresponding overtime charge will apply, and the staff\'s salary will be doubled for the extended hours.</li></ol><hr data-v-inspector=\"src/components/ModalContractEditor.vue:41:21\" data-v-3a7e46ba=\"\"><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:42:21\" data-v-3a7e46ba=\"\">Policy on Cancellation and Incidents</p><ol data-v-inspector=\"src/components/ModalContractEditor.vue:43:21\" data-v-3a7e46ba=\"\"><li data-v-inspector=\"src/components/ModalContractEditor.vue:44:23\" data-v-3a7e46ba=\"\">In the event of a cancellation by the Client, 20% of the down payment will be forfeited.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:45:23\" data-v-3a7e46ba=\"\">This forfeiture also applies to other unforeseen incidents that may prevent the event from proceeding as planned.</li></ol><hr data-v-inspector=\"src/components/ModalContractEditor.vue:47:21\" data-v-3a7e46ba=\"\"><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:48:21\" data-v-3a7e46ba=\"\">Damages to Property&nbsp;</p><ol data-v-inspector=\"src/components/ModalContractEditor.vue:49:21\" data-v-3a7e46ba=\"\"><li data-v-inspector=\"src/components/ModalContractEditor.vue:50:23\" data-v-3a7e46ba=\"\">The Client is responsible for any damagsdsds</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:50:23\" data-v-3a7e46ba=\"\">e to items or property owned by Loreto\'s Kitchenette during the event.</li><li data-v-inspector=\"src/components/ModalContractEditor.vue:51:23\" data-v-3a7e46ba=\"\">Examples include, but are not limited to, broken plates, chairs, or other equipment. The Client will be charged the cost of repair or replacement for any damaged items</li></ol><hr data-v-inspector=\"src/components/ModalContractEditor.vue:53:21\" data-v-3a7e46ba=\"\"><p class=\"text-dark fw-bold\" data-v-inspector=\"src/components/ModalContractEditor.vue:54:21\" data-v-3a7e46ba=\"\">Acknowledgment and Agreement&nbsp;</p><p data-v-inspector=\"src/components/ModalContractEditor.vue:55:21\" data-v-3a7e46ba=\"\">By signing below, the Client acknowledges that they have read, understood, and agree to the terms and conditions outlined in this Agreement.</p>');



CREATE TABLE `themes` (
  `dataid` int(10) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`dataid`, `name`, `description`) VALUES
(2, 'Casual Theme', NULL),
(3, 'Festive Theme', NULL),
(4, 'Minimilastic Design', NULL),
(5, 'Rustic / Vintage Theme', NULL),
(6, 'Bold and Vibrant Theme', 'They\'re vibrant, full of life, and they tend to have a high saturation.'),
(7, 'Whimsical / Fairy Tale Theme', NULL),
(8, 'Echo-friendly Theme', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_customer`
--

CREATE TABLE `users_customer` (
  `dataid` int(11) NOT NULL,
  `firstname` varchar(60) DEFAULT NULL,
  `lastname` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `email_verified` int(3) NOT NULL DEFAULT 0,
  `password` varchar(60) DEFAULT NULL,
  `contact` varchar(26) DEFAULT NULL,
  `token` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_customer`
--

INSERT INTO `users_customer` (`dataid`, `firstname`, `lastname`, `email`, `email_verified`, `password`, `contact`, `token`) VALUES
(23, 'Jason', 'Lipreso', 'jasonlipreso@gmail.com', 1, 'admin123', '639353152023', 'oT9|W6vpq*jS8lBiD3k_znL@MVN7I5Qg'),
(24, 'Jessie', 'Narciso', 'jessielnarciso@gmail.com', 1, 'undercater_account', '639919321016', 'qk2(oxi)JCXuQvVDFsh3m0U4Nz_AeInJ'),
(25, 'Justine', 'Otoman', 'namotootoman8@gmail.com', 1, 'Coolbro1', '639459720107', '8Unvbr3FNpO9P|1d5kyK0DXm2uCSjT@Y'),
(26, 'Narciso', 'Jessie', 'jessienarciso02@gmail.com', 1, 'customer1', '639123456789', 'sgpIY_F|ua(bLBfEVO@v*0yKo-j49teD'),
(27, 'JUSTINE', 'OTOMAN', 'Namotojustine@gmail.com', 1, 'Coolbro1', '639459720107', 'cEJBA79f3H@bpFq1I*_)lmiyCu(TMhza'),
(28, 'Vanessa Julia', 'Salatan', 'salatanvanessajulia@gmail.com', 1, 'kukoko09', '639620863269', '4AZayxXu_71sHMUR3rbzBKtF@Qvm0DcJ'),
(29, 'Narciso', 'Jessie', 'narcisojessie02@gmail.com', 1, 'undercater', '639123456789', 'WbnJmHrIU5gRvxlpeF24oc_(uDMYSiV0'),
(30, 'patric', 'alabas', 'patrickalabaso69@gmail.com', 1, '12345678', '63admin@unde', '9-JrbD(i6dI|s)LXoYZMU0aOqPhtCgzR'),
(31, 'Rose Ann', 'Padin', 'roseannpadin4@gmail.com', 1, 'rose21', '639942261186', ')KIaXDRQJm0PS-hNYki82o5ed4JfvxCj'),
(32, 'John Leemarc', 'tanya', 'makentanya8@gmail.com', 0, '123456789', '639511584632', 'r9lkB42t-_nP0E)ofywh(jiTA1s7H5Op'),
(33, 'dens', 'candia', 'aborotoy31@gmail.com', 0, 'candia321x', '639505239454', '1E0mTNQLOFKRDynYi7j_J8*kl3v(rq-b'),
(34, 'dens', 'candia', 'aborotoy@gmail.com', 1, 'CANDIA321X', '639505239454', 'r(nvhe7MQcPxzLE*I5aNTZuDR98|CWgp'),
(35, 'Richard', 'Labanda', 'bombomweee@gmail.com', 1, 'richard123', '630923434609', 'ELQNdjq-ypUAk8KW9R7YbFc6mvOePC3u'),
(36, 'Christine', 'Borata', 'christinerosevillarineborata@gmail.com', 0, '011303', '639634576970', 'dEZs|XbcBkJ4(wNu*RfnmMVryzxLvptD'),
(37, 'John Paul', 'Abayata', 'abayatajohnpaul119512@gmail.com', 0, '0987654321', '639433311683', 'zT4h_A5I2q|76bnW0FO319DwCiZURYuk'),
(38, 'Christine Rose', 'Borata', 'christinerosevillarinborata@gmail.com', 1, 'Tine011303', '639634576970', '8JA|r9-5kbSnOalYv6wsi2J4QtToNedK'),
(39, 'John Paul', 'Abayata', 'abayatajohnpaul119518@gmail.com', 1, '0987654321', '639433311683', '@8|W_QlLtwJA)b(YhX4Ja9Rkec2BoZuE'),
(40, 'jogie', 'aliviano', 'alivianojogie32@gmail.com', 1, '123456', '630969457186', '09q3kYZJatlFLw*24uof7D)5rdv_6XhB'),
(41, 'John', 'Tanya', 'johntanya95@gmail.com', 1, '123456', '639511584632', 'MWusyF@8JcZ5hmPr0_i)j(*NA36BlSIt'),
(42, 'Richard', 'Labanda', 'labandafamily13@gmail.com', 1, 'triplestriker', '639224346095', '|_8VPLKf2k0tvl91XqT)3z5nSER7J@Or'),
(43, 'alchris', 'compuesto', 'compuestoalchris@gmail.com', 1, '1234567890', '639970752879', 'qRpwhWZB)Q-mlsg2TDOfu7o6xnj9A*1r'),
(44, 'Rose Ann', 'Padin', 'wyne425@gmail.com', 1, 'wyne425', '639942261186', 'MYOcfnAjIw5FrJ2@atS_o(1DR3iH678N');

-- --------------------------------------------------------

--
-- Table structure for table `users_system`
--

CREATE TABLE `users_system` (
  `dataid` int(10) NOT NULL,
  `first_name` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `last_name` varchar(60) DEFAULT NULL,
  `email` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `contact` varchar(255) NOT NULL DEFAULT '''09383483111''',
  `password` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `role` int(3) NOT NULL DEFAULT 0,
  `status` varchar(3) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_system`
--

INSERT INTO `users_system` (`dataid`, `first_name`, `last_name`, `email`, `contact`, `password`, `role`, `status`) VALUES
(1, 'LORETO\'S', 'KITCHENETTE', 'admin@undercater.com', '09383483111', 'admin123', 1, '1'),
(2, 'Jenny', 'Legazpi', 'jessienarciso070202@gmail.com', '\'09383483111\'', 'eqeweqq', 2, '1'),
(3, 'STAFF', 'TEST', 'patrickalabaso69@gmail.com', '\'09383483111\'', 'Coolbro1', 2, '1'),
(4, 'Jason', 'Lipreso', 'jasonlipreso@gmail.com', '09353152023', 'admin123', 1, '1'),
(5, 'STAFF', 'STAFF', 'markgotgotao24@gmail.com', '\'09383483111\'', 'Coolbro1', 2, '1'),
(6, 'Staff', 'Staff', 'namotojustine@gmail.com', '\'09383483111\'', 'Coolbro1', 2, '1'),
(7, 'Tresha', 'Lipreso', 'treshalipreso@gmail.com', '\'09383483111\'', 'treshagwapa', 1, '1'),
(8, 'jessie', 'naricis', 'jessielnariciso@gmail.com', '\'09383483111\'', 'Coolbro1', 2, '1'),
(9, 'John', 'Lawton', 'jessienarciso070202@gmail.com', '\'09383483111\'', 'Coolbro1', 2, '1');

-- --------------------------------------------------------

--
-- Table structure for table `users_system_role`
--

CREATE TABLE `users_system_role` (
  `dataid` int(10) NOT NULL,
  `role_code` int(3) NOT NULL DEFAULT 0,
  `description` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_system_role`
--

INSERT INTO `users_system_role` (`dataid`, `role_code`, `description`) VALUES
(1, 1, 'Admin'),
(2, 2, 'Staff');

ALTER TABLE `activity`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `add_ons`
--
ALTER TABLE `add_ons`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `booking_activity`
--
ALTER TABLE `booking_activity`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `booking_addons`
--
ALTER TABLE `booking_addons`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `booking_foods`
--
ALTER TABLE `booking_foods`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `inventory_stocks`
--
ALTER TABLE `inventory_stocks`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `marketing`
--
ALTER TABLE `marketing`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `menu_categories`
--
ALTER TABLE `menu_categories`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `template`
--
ALTER TABLE `template`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `users_customer`
--
ALTER TABLE `users_customer`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `users_system`
--
ALTER TABLE `users_system`
  ADD PRIMARY KEY (`dataid`);

--
-- Indexes for table `users_system_role`
--
ALTER TABLE `users_system_role`
  ADD PRIMARY KEY (`dataid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity`
--
ALTER TABLE `activity`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `add_ons`
--
ALTER TABLE `add_ons`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `booking_activity`
--
ALTER TABLE `booking_activity`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `booking_addons`
--
ALTER TABLE `booking_addons`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `booking_foods`
--
ALTER TABLE `booking_foods`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=440;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `inquiry`
--
ALTER TABLE `inquiry`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `inventory_stocks`
--
ALTER TABLE `inventory_stocks`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `marketing`
--
ALTER TABLE `marketing`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `menu_categories`
--
ALTER TABLE `menu_categories`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `template`
--
ALTER TABLE `template`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users_customer`
--
ALTER TABLE `users_customer`
  MODIFY `dataid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `users_system`
--
ALTER TABLE `users_system`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users_system_role`
--
ALTER TABLE `users_system_role`
  MODIFY `dataid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
