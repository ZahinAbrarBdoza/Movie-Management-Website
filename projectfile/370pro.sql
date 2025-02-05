-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 23, 2024 at 02:26 AM
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
-- Database: `370pro`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `screening_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seats` int(11) NOT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `payment_status` varchar(20) DEFAULT 'Pending',
  `confirmation_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `screening_id`, `user_id`, `seats`, `total_cost`, `payment_status`, `confirmation_date`) VALUES
(4, 16, 1520, 4, 85.26, 'Paid', '2024-12-23 05:56:12'),
(5, 4, 1520, 5, 49.00, 'Paid', '2024-12-23 06:02:27'),
(13, 4, 1520, 5, 40.00, 'Paid', '2024-12-23 06:19:29');

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `discount_rate` decimal(5,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`id`, `user_id`, `discount_rate`) VALUES
(1, 1520, 2.00),
(2, 1520, 4.00),
(3, 1520, 6.00),
(4, 1520, 8.00),
(5, 1520, 10.00),
(6, 1520, 12.00),
(7, 1520, 14.00),
(8, 1520, 16.00),
(9, 1520, 18.00),
(10, 1520, 20.00),
(11, 1520, 20.00),
(12, 1520, 20.00),
(13, 1520, 20.00),
(14, 1520, 20.00),
(15, 1520, 20.00),
(16, 1520, 20.00),
(17, 1520, 20.00),
(18, 1520, 20.00),
(19, 1520, 20.00),
(20, 1520, 20.00),
(21, 1521, 2.00),
(22, 1520, 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `discussion`
--

CREATE TABLE `discussion` (
  `DiscussionId` int(11) NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discussion`
--

INSERT INTO `discussion` (`DiscussionId`, `UserId`, `UserName`, `Comment`) VALUES
(1, 101, 'JohnDoe21', 'I really enjoyed Stranger Things!'),
(2, 202, 'MarySmith84', 'Game of Thrones is my all-time favorite.'),
(3, 303, 'AlexJohnson', 'Attack on Titan has such intense moments.'),
(4, 404, 'SarahBrown', 'Stranger Things keeps me on the edge of my seat.'),
(5, 505, 'RobertGreen', 'Looking forward to more thriller shows.'),
(6, 606, 'EmilyWhite', 'Stranger Things and Game of Thrones are amazing.'),
(7, 707, 'MichaelTaylor', 'Black Mirror offers thought-provoking stories.'),
(8, 808, 'LisaAnderson', 'Fantasy genre always captures my imagination.'),
(9, 909, 'DanielLee', 'Attack on Titan is a masterpiece.'),
(10, 1010, 'SophiaWong', 'Any recommendations for family-friendly shows?'),
(11, 1111, 'WilliamHarris', 'Chernobyl was a hauntingly accurate depiction.'),
(12, 1212, 'OliviaBrown', 'Interstellar is mind-bending.'),
(13, 1313, 'JamesMiller', 'Documentaries provide valuable insights.'),
(14, 1414, 'AvaClark', 'Breaking Bad and The Witcher are my top picks.'),
(15, 1515, 'EthanYoung', 'Stranger Things and Game of Thrones are epic.'),
(16, 1516, 'tgnr', 'ki ase jibone, parai holo jibon'),
(17, NULL, 'Unknown', 'areh joss'),
(18, 1516, 'tgnr', 'areh mama ki obostha'),
(19, 1516, 'tgnr', 'just chill chill'),
(22, NULL, 'Unknown', 'whats up'),
(23, 1516, 'tgnr', 'good morning');

-- --------------------------------------------------------

--
-- Table structure for table `screenings`
--

CREATE TABLE `screenings` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `theater` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `screenings`
--

INSERT INTO `screenings` (`id`, `movie_id`, `theater`, `time`, `ticket_price`) VALUES
(1, 1014, 'Regal Cinema', '2024-12-18 15:00:00', 12.50),
(2, 1014, 'AMC Theaters', '2024-12-18 18:00:00', 15.00),
(3, 1016, 'Cinemark XD', '2024-12-19 14:00:00', 18.75),
(4, 1016, 'Regal Cinema', '2024-12-19 19:30:00', 10.00),
(5, 1031, 'IMAX Theater', '2024-12-20 20:00:00', 20.50),
(6, 1039, 'AMC Theaters', '2024-12-21 17:30:00', 13.25),
(7, 1014, 'Regal Cinema', '2024-12-18 14:00:00', 14.75),
(8, 1014, 'AMC Theaters', '2024-12-18 18:30:00', 19.00),
(9, 1014, 'Cinemark XD', '2024-12-19 12:00:00', 11.50),
(10, 1014, 'IMAX Theater', '2024-12-19 19:00:00', 17.25),
(11, 1014, 'Regal Cinema', '2024-12-20 15:30:00', 16.50),
(12, 1014, 'AMC Theaters', '2024-12-20 20:00:00', 14.00),
(13, 1014, 'Cinemark XD', '2024-12-21 13:00:00', 18.00),
(14, 1014, 'IMAX Theater', '2024-12-21 17:30:00', 10.50),
(15, 1014, 'Regal Cinema', '2024-12-22 16:00:00', 22.00),
(16, 1014, 'AMC Theaters', '2024-12-22 21:00:00', 21.75);

-- --------------------------------------------------------

--
-- Table structure for table `showlist`
--

CREATE TABLE `showlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `show_id` int(11) NOT NULL,
  `list_type` enum('watched','planned') NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `showlist`
--

INSERT INTO `showlist` (`id`, `user_id`, `show_id`, `list_type`, `added_at`) VALUES
(6, 1520, 1029, 'planned', '2024-12-22 22:59:11'),
(8, 1520, 1029, 'watched', '2024-12-22 23:46:45'),
(10, 1520, 1029, 'watched', '2024-12-23 00:03:01'),
(25, 1520, 1034, 'watched', '2024-12-23 00:04:19'),
(27, 1521, 1001, 'watched', '2024-12-23 00:22:36');

-- --------------------------------------------------------

--
-- Table structure for table `tvshows`
--

CREATE TABLE `tvshows` (
  `ShowId` int(11) NOT NULL,
  `ShowName` varchar(200) DEFAULT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `Genre` varchar(200) DEFAULT NULL,
  `Rating` decimal(3,1) DEFAULT NULL,
  `Language` varchar(50) DEFAULT NULL,
  `ShowType` varchar(50) DEFAULT NULL,
  `MovieLink` varchar(500) DEFAULT NULL,
  `MoviePoster` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tvshows`
--

INSERT INTO `tvshows` (`ShowId`, `ShowName`, `ReleaseDate`, `Genre`, `Rating`, `Language`, `ShowType`, `MovieLink`, `MoviePoster`) VALUES
(1001, 'Stranger Things', '2016-07-15', 'Science Fiction, Horror, Fantasy', 4.8, 'English', 'Series', 'https://www.youtube.com/watch?v=rIo5sTSwm5E\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWN8AkViFHvaTTH0C7fRRJCnLiYL3CtpbTdw&s\n\n'),
(1002, 'Breaking Bad', '2008-01-20', 'Crime, Drama, Thriller', 4.9, 'English', 'Series', 'https://www.youtube.com/watch?v=1JLUn2DFW4w\n\n', 'https://tdhicks.com/wp-content/uploads/2013/08/breaking-bad-poster-walt.jpg?w=584\n\n'),
(1003, 'The Mandalorian', '2019-11-12', 'Science Fiction, Action, Adventure', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=eW7Twd85m2g\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToGSqPh-E6Xs3mnd4-ZmtysUkWHvKsnbcDDg&s\n\n'),
(1004, 'Friends', '1994-09-22', 'Comedy, Romance', 4.5, 'English', 'Series', 'https://www.youtube.com/watch?v=Lhpu3GdlV3w\n\n', 'https://uniathenaprods3.uniathena.com/s3fs-public/insights-article/seriesreview-e2-80-9cfriends-e2-80-9d_0.jpg\n\n'),
(1005, 'Game of Thrones', '2011-04-17', 'Fantasy, Drama, Adventure', 4.6, 'English', 'Series', 'https://www.youtube.com/watch?v=KPLWWIOCOOQ\n\n', 'https://assets-prd.ignimgs.com/2022/01/14/gameofthrones-allseasons-sq-1642120207458.jpg\n\n'),
(1006, 'The Crown', '2016-11-04', 'Drama, History', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=JWtnJjn6ng0\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWKjKpH0KkHF_6Bnr8L7bOPv1agVZEqfaIAKLxRa05C365mVR2pGgzGPC1AMtchkAODmI&usqp=CAU\n\n'),
(1007, 'Black Mirror', '2011-12-04', 'Science Fiction, Drama, Thriller', 4.8, 'English', 'Series', 'https://www.youtube.com/watch?v=yef_HfQoBd8\n\n', 'https://tellyvisions.org/sites/default/files/black-mirror-logo.jpg\n\n'),
(1008, 'The Simpsons', '1989-12-17', 'Animation, Comedy', 4.5, 'English', 'Series', 'https://www.youtube.com/watch?v=K7gjjN0uZys&list=PLLhOnau-tupSI1kqwyeBIQTgxmz0BHDUx\n\n', 'https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/0E97E967C1744CB09006B7A86EEB05F4B070665074177C32E159BEBE22D22D7C/scale?width=1200&aspectRatio=1.78&format=webp\n\n'),
(1009, 'Attack on Titan', '2013-04-07', 'Action, Dark Fantasy', 4.8, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=LV-nazLVmgo\n\n', 'https://m.media-amazon.com/images/M/MV5BYWI3ODE3OTYtMWMzMS00OWY0LThkYWYtYTdjMmY0YjFlODAzXkEyXkFqcGc@._V1_QL75_UY281_CR31,0,500,281_.jpg\n\n'),
(1010, 'The Office', '2005-03-24', 'Comedy', 4.6, 'English', 'Series', 'https://www.youtube.com/watch?v=242HMrCscEo\n\n', 'https://resizing.flixster.com/tHKs2YTLfsihrCw0otVjSLBO9vM=/fit-in/705x460/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p185008_b_h8_ae.jpg'),
(1011, 'Chernobyl', '2019-05-06', 'Drama, History, Thriller', 4.9, 'English', 'Series', 'https://www.youtube.com/watch?v=s9APLXM9Ei8\n\n', 'https://beam-images.warnermediacdn.com/BEAM_LWM_DELIVERABLES/396999a6-3fff-4af3-802b-10c46d10deff/b2551336ecc42f4e68fe8f10c4a441a3ec388e28.jpg?host=wbd-images.prod-vod.h264.io&partner=beamcom\n\n'),
(1012, 'Death Note', '2006-10-04', 'Thriller, Psychological, Supernatural', 4.7, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=MT04dmyrreU\n\n', 'https://m.media-amazon.com/images/M/MV5BYWM1MDA5MmEtNDZhMy00YmZlLTk3NzYtZjNmZjE1MzNlYTlhXkEyXkFqcGc@._V1_.jpg\n\n'),
(1014, 'Interstellar', '2014-11-05', 'Science Fiction, Adventure, Drama', 4.6, 'English', 'Movie', 'https://www.youtube.com/watch?v=zSWdZVtXT7E\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZgarY79EPQu_BBe86NdqmVxRhgH0N6AgLEA&s\n\n'),
(1015, 'The Witcher', '2019-12-20', 'Fantasy, Action, Adventure', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=ndl1W4ltcmg\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1S5-xAC4iRVuPVLJ5ni9oYsDFYH9WfhzYwwsi9hP4VbgkQ7ebQ37v4SLZigD-NlG0uDA&usqp=CAU\n\n'),
(1016, 'Forrest Gump', '1994-07-06', 'Drama, Romance', 4.8, 'English', 'Movie', 'https://www.youtube.com/watch?v=bLvqoHBptjg\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm96J68_N1aAShQu6Z6JbyNOTy-ekLNRK1KQ&s\n\n'),
(1017, 'Ozark', '2017-07-21', 'Crime, Drama, Thriller', 4.9, 'English', 'movie', 'https://www.youtube.com/watch?v=5hAXVqrljbs', 'https://resizing.flixster.com/3ko6zO6791p1QPOXHUI2eCwmHXQ=/ems.cHJkLWVtcy1hc3NldHMvdHZzZXJpZXMvMDIyOTBmN2QtMzM0Yi00ODUxLWE0MWYtMmViYWJiOGViZjRkLmpwZw=='),
(1018, 'Jack Ryan', '2018-08-30', 'Action, Drama, Thriller', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=1KsyZF590NM\n\n', 'https://m.media-amazon.com/images/S/pv-target-images/5b4ae0efa96c09972da167f70b30f4f723fa0b4b99d5b85fd1c3ab266468fef8.jpg\n\n'),
(1019, 'Spider-Man: No Way Home', '2021-12-17', 'Action, Adventure, Sci-Fi', 4.6, 'English', 'Movie', 'https://www.youtube.com/watch?v=JfVOs4VSpmA\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3UDKhzJt_dbeWN11cTpTf-vZcrslhlmnfJw&s\n\n'),
(1020, 'My Hero Academia', '2016-04-03', 'Action, Superhero, Comedy', 4.7, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=EPVkcwyLQQ8\n\n', 'https://m.media-amazon.com/images/S/pv-target-images/2d91f2d189f181e31a98bd6573977619ed1e0b8425905b8ba2df17ad6b4ccb07.jpg\n\n'),
(1021, 'Inception', '2010-07-16', 'Science Fiction, Action, Adventure', 4.8, 'English', 'Movie', 'https://www.youtube.com/watch?v=8hP9D6kZse\n\n', 'https://m.media-amazon.com/images/M/MV5BZjhkNjM0ZTMtNGM5MC00ZTQ3LTk3YmYtZTkzYzdiNWE0ZTA2XkEyXkFqcGc@._V1_.jpg\n\n'),
(1022, 'Naruto', '2002-10-03', 'Action, Adventure, Fantasy', 4.6, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=-G9BqkgZXRA\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-9TDmDP-XINSNtUsDq-Ban8OvSmcqvHJoFw&s\n\n\n'),
(1023, 'The Matrix', '1999-03-31', 'Science Fiction, Action', 4.9, 'English', 'Movie', 'https://www.youtube.com/watch?v=vKQi3bBA1\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-9TDmDP-XINSNtUsDq-Ban8OvSmcqvHJoFw&s\n\n'),
(1024, 'One Piece', '1999-10-20', 'Adventure, Action, Comedy', 4.7, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=Ades3pQbeh8\n\n', 'https://imgsrv.crunchyroll.com/cdn-cgi/image/fit=contain,format=auto,quality=85,width=1200,height=675/catalog/crunchyroll/a249096c7812deb8c3c2c907173f3774.jpg\n\n'),
(1025, 'Pulp Fiction', '1994-10-14', 'Crime, Drama', 4.8, 'English', 'Movie', 'https://www.youtube.com/watch?v=tGpTpVyI_OQ\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjEy4u-NcIu_uqNSt7_V4WC_FHUJHz6r7MUQ&s\n\n'),
(1026, 'Fullmetal Alchemist: Brotherhood', '2009-04-05', 'Action, Adventure, Fantasy', 4.9, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=-GoNo0DGroU\n\n', 'https://imgsrv.crunchyroll.com/cdn-cgi/image/fit=contain,format=auto,quality=85,width=1200,height=675/catalog/crunchyroll/ac0052958fa876ed2ef926920a88ec75.jpg\n\n'),
(1027, 'Avatar', '2009-12-18', 'Science Fiction, Action, Adventure', 4.6, 'English', 'Movie', 'https://www.youtube.com/watch?v=d9MyW72ELq0\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe1aAQvu6KxtqYUq8LH3OWgmCuvh9M8lPhkw&s\n\n'),
(1028, 'Sex Education', '2019-01-11', 'Comedy, Drama, Fantasy', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=uKvmUiNOaz4&list=PLJfbbtqxDeMx4ev51jmD7ocdni2V3P3Q4\n\n', 'https://movingpicturereview.com/wp-content/uploads/2021/09/ed9pm.jpg\n\n'),
(1029, 'The Dark Knight', '2008-07-18', 'Action, Crime, Drama', 4.9, 'English', 'Movie', 'https://www.youtube.com/watch?v=EXeTwQWrcwY\n\n', 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_QL75_UX190_CR0,0,190,281_.jpg\n\n'),
(1030, 'Cowboy Bebop', '1998-04-03', 'Action, Space, Drama', 4.8, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=ULCIHP5dc44\n\n', 'https://m.media-amazon.com/images/M/MV5BM2VhZjk2MWMtZjc2OC00YzA4LWI0NzAtZGQ1YjVkOTk5YzVlXkEyXkFqcGc@._V1_.jpg\n\n'),
(1031, 'The Shawshank Redemption', '1994-09-23', 'Drama', 4.9, 'English', 'Movie', 'https://www.youtube.com/watch?v=PLl99DlL6b4\n\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGW2qwTdrk1f3en-qqPCu7PyoIVZZktkJfrw&s\n\n'),
(1032, 'Dragon Ball Z Kai', '2009-04-05', 'Action, Action, Adventure', 4.8, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=Bh481ps0sGE\n\n', 'https://img3.hulu.com/user/v3/artwork/878dfb40-872c-478c-b146-1e809365302b?base_image_bucket_name=image_manager&base_image=f788b80d-99a4-490c-afd7-bfa433540e10&size=1200x630&format=webp\n\n'),
(1033, 'The Avengers', '2012-05-04', 'Action, Adventure, Sci-Fi', 4.7, 'English', 'Movie', 'https://www.youtube.com/watch?v=eOrNdBpGMv8\n\n', 'https://m.media-amazon.com/images/M/MV5BNGE0YTVjNzUtNzJjOS00NGNlLTgxMzctZTY4YTE1Y2Y1ZTU4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg\n\n'),
(1034, 'Death Note: The Last Name', '2006-11-03', 'Thriller, Psychological, Supernatural', 4.6, 'Japanese', 'Movie', 'https://www.youtube.com/watch?v=MT04dmyrreU\n\n', 'https://m.media-amazon.com/images/M/MV5BYWM1MDA5MmEtNDZhMy00YmZlLTk3NzYtZjNmZjE1MzNlYTlhXkEyXkFqcGc@._V1_.jpg\n\n'),
(1035, 'Westworld', '2016-10-02', 'Science Fiction, Drama, Mystery', 4.7, 'English', 'Series', 'https://www.youtube.com/watch?v=9BqKiZhEFFw\n\n', 'https://episodedergi.com/wp-content/uploads/2022/06/westworld-4-850x560.jpg\n\n'),
(1036, 'Spirited Away', '2001-07-20', 'Animation, Adventure, Family', 4.8, 'Japanese', 'Movie', 'https://www.youtube.com/watch?v=ByXuk9QqQ', 'https://m.media-amazon.com/images/M/MV5BNTEyNmEwOWUtYzkyOC00ZTQ4LTllZmUtMjk0Y2YwOGUzYjRiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg'),
(1037, 'Sherlock', '2010-07-25', 'Crime, Drama, Mystery', 4.9, 'English', 'Series', 'https://www.youtube.com/watch?v=xK7S9mrFWL4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDE4PF2QXxcU0Z822jMfHM8FS5-2FRI6GajQ&s'),
(1038, 'Neon Genesis Evangelion', '1995-10-04', 'Action, Dementia, Drama', 4.7, 'Japanese', 'Anime', 'https://www.youtube.com/watch?v=13nSISwxrY4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQRZ3RhbDRKaEBohAqANyfQn88BUgyY6Th3w&s'),
(1039, 'The Godfather', '1972-03-24', 'Crime, Drama', 4.9, 'English', 'Movie', 'https://www.youtube.com/watch?v=UaVTIH8mujA', 'https://m.media-amazon.com/images/M/MV5BOWE1MWE3ZDktOThlZS00ZmRiLWE4ZGEtNWJkMTVlZjdhZDIyXkEyXkFqcGdeQW1pYnJ5YW50._V1_.jpg'),
(1040, 'Money Heist', '2017-05-02', 'Action, Crime, Drama', 4.8, 'Spanish', 'Series', 'https://www.youtube.com/watch?v=_InqQJRqGW4', 'https://www.hollywoodreporter.com/wp-content/uploads/2018/12/MoneyHeist.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserId` int(11) NOT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `LikedCategory` varchar(50) DEFAULT NULL,
  `Watched` varchar(5000) DEFAULT NULL,
  `Planned` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserId`, `Password`, `UserName`, `Email`, `Country`, `LikedCategory`, `Watched`, `Planned`) VALUES
(101, 'Pass123!', 'JohnDoe21', 'john.doe@example.com', 'USA', 'Action', '(1001, \"Stranger Things\"), (1003, \"The Mandalorian\"),(1040, \'Money Heist\'),(1014, \'Interstellar\'),(1039, \'The Godfather\'),(1038, \'Neon Genesis Evangelion\'),(1038, \'Neon Genesis Evangelion\')', '(1002, \"Breaking Bad\"), (1010, \"The Office\"),(1039, \'The Godfather\'),(1039, \'The Godfather\'),(1039, \'The Godfather\'),(1038, \'Neon Genesis Evangelion\')'),
(202, 'Secret567', 'MarySmith84', 'mary.smith@example.com', 'Canada', 'Comedy', '(1005, \"Game of Thrones\"), (1006, \"The Crown\"),(1040, \'Money Heist\'),(1038, \'Neon Genesis Evangelion\')', '(1004, \"Friends\"), (1014, \"Interstellar\"),(1038, \'Neon Genesis Evangelion\'),(1038, \'Neon Genesis Evangelion\'),(1038, \'Neon Genesis Evangelion\'),(1038, \'Neon Genesis Evangelion\')'),
(303, 'SecurePwd55', 'AlexJohnson', 'alex.johnson@example.com', 'UK', 'Drama', '(1008, \"The Simpsons\"), (1009, \"Attack on Titan\")', '(1011, \"Chernobyl\"), (1012, \"Death Note\")'),
(404, 'P@ssw0rd12', 'SarahBrown', 'sarah.brown@example.com', 'Australia', 'Romance', '(1013, \"Stranger Things\"), (1015, \"The Witcher\")', ''),
(505, 'Strong123$', 'RobertGreen', 'robert.green@example.com', 'Germany', 'Thriller', '', ''),
(606, 'SafePass2023', 'EmilyWhite', 'emily.white@example.com', 'USA', 'Adventure', '', '(1001, \"Stranger Things\"), (1005, \"Game of Thrones\")'),
(707, 'Pa$$w0rd789', 'MichaelTaylor', 'michael.taylor@example.com', 'Canada', 'Sci-Fi', '(1007, \"Black Mirror\"), (1008, \"The Simpsons\")', '(1003, \"The Mandalorian\"), (1010, \"The Office\")'),
(808, 'Secret9876', 'LisaAnderson', 'lisa.anderson@example.com', 'UK', 'Fantasy', '', ''),
(909, 'Protected55', 'DanielLee', 'daniel.lee@example.com', 'Australia', 'Animation', '(1009, \"Attack on Titan\"), (1014, \"Interstellar\")', ''),
(1010, 'P@ssw0rd2023', 'SophiaWong', 'sophia.wong@example.com', 'Singapore', 'Family', '', ''),
(1111, 'SafePwd67', 'WilliamHarris', 'william.harris@example.com', 'USA', 'Mystery', '(1011, \"Chernobyl\"), (1015, \"The Witcher\")', ''),
(1212, 'StrongPwd13', 'OliviaBrown', 'olivia.brown@example.com', 'Canada', 'Horror', '(1021, \'Inception\')', '(1013, \"Stranger Things\"), (1014, \"Interstellar\"),(1023, \'Avatar\'),(1009, \'Attack on Titan\')'),
(1313, 'SecurePass22', 'JamesMiller', 'james.miller@example.com', 'UK', 'Documentary', '', ''),
(1414, 'Protected321', 'AvaClark', 'ava.clark@example.com', 'Australia', 'Fantasy', '(1002, \"Breaking Bad\"), (1015, \"The Witcher\")', ''),
(1515, 'SecretPwd77', 'EthanYoung', 'ethan.young@example.com', 'USA', 'Action', '(1001, \"Stranger Things\"), (1005, \"Game of Thrones\")', ''),
(1516, 'password', 'tgnr', 'tgnr@gmail.com', 'Bangladesh', 'Romance', '(1014, \'Interstellar\'),(1039, \'The Godfather\')', '(1002, \'Breaking Bad\'),(1038, \'Neon Genesis Evangelion\')'),
(1517, '12345', 'rafi', 'rafi@gmail.com', 'Bangladesh', 'Action', '', ''),
(1518, '123', 'Rafi', 'smth@gmail.com', 'bd', 'Action', '', ''),
(1519, '123', 'aal@#21301347', 'ijsad@gmail.com', 'bd', 'Action', '', ''),
(1520, '123', 'Ishmum', 'smth@gmail.com', 'Bangladesh', 'Action', '(1040, \'Money Heist\')', '(1038, \'Neon Genesis Evangelion\')'),
(1521, '123', 'Rafid', 'smth@gmail.com', 'bd', 'Horror', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `discussion`
--
ALTER TABLE `discussion`
  ADD PRIMARY KEY (`DiscussionId`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `showlist`
--
ALTER TABLE `showlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `discussion`
--
ALTER TABLE `discussion`
  MODIFY `DiscussionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `showlist`
--
ALTER TABLE `showlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `discounts`
--
ALTER TABLE `discounts`
  ADD CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`UserId`);

--
-- Constraints for table `discussion`
--
ALTER TABLE `discussion`
  ADD CONSTRAINT `discussion_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
