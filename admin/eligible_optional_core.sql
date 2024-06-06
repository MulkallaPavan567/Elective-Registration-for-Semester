-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2024 at 08:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onlinecourse`
--

-- --------------------------------------------------------

--
-- Table structure for table `eligible_optional_core`
--

CREATE TABLE `eligible_optional_core` (
  `id` int(11) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `courseName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eligible_optional_core`
--

INSERT INTO `eligible_optional_core` (`id`, `stream_id`, `stream_name`, `courseName`) VALUES
(42, 3, 'MTECH_CS', 'ACN'),
(43, 3, 'MTECH_CS', 'Advance Algo'),
(44, 3, 'MTECH_CS', 'DL'),
(45, 3, 'MTECH_CS', 'Machine Learning'),
(46, 3, 'MTECH_CS', 'System Security'),
(60, 4, 'MTECH_IT', 'Internet of Things'),
(61, 4, 'MTECH_IT', 'System Security'),
(62, 4, 'MTECH_IT', 'Virtualization'),
(63, 2, 'MTECH_AI', 'Advance Algo'),
(64, 2, 'MTECH_AI', 'Machine Learning'),
(65, 2, 'MTECH_AI', 'System Security');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  ADD CONSTRAINT `eligible_optional_core_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`),
  ADD CONSTRAINT `eligible_optional_core_ibfk_2` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
