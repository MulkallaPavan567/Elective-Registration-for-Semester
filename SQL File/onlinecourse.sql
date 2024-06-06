-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Jun 06, 2024 at 01:11 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

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
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `creationDate`, `updationDate`) VALUES
(1, 'admin', '12345', '2022-01-31 16:21:18', '0000-00-00 00:00:00'),
(2, 'AP', '121212', '2023-04-03 16:05:18', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_code` varchar(255) NOT NULL,
  `courseName` varchar(255) DEFAULT NULL,
  `bucket_number` varchar(11) NOT NULL,
  `seats_for_MCA` int(11) DEFAULT NULL,
  `seats_for_MTECH_AI` int(11) DEFAULT NULL,
  `seats_for_MTECH_CS` int(11) DEFAULT NULL,
  `seats_for_MTECH_IT` int(11) DEFAULT NULL,
  `seats_for_IMTECH_3_4` int(11) DEFAULT NULL,
  `seats_for_IMTECH_5_6` int(11) DEFAULT NULL,
  `seats_for_IMTECH_7_8` int(11) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_code`, `courseName`, `bucket_number`, `seats_for_MCA`, `seats_for_MTECH_AI`, `seats_for_MTECH_CS`, `seats_for_MTECH_IT`, `seats_for_IMTECH_3_4`, `seats_for_IMTECH_5_6`, `seats_for_IMTECH_7_8`, `creationDate`, `updationDate`) VALUES
('ACN – V Radha*', 'ACN', 'E6', 0, 50, 50, 48, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('AdvAlgo-RPL', 'Advance Algo', 'E3', 0, 50, 50, 49, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('Biometrics – MVNK *', 'Biometrics', 'E5', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('CC – RW', 'Cloud Computing', 'E1', 6, 5, 50, 0, 0, 5, 5, '2023-04-11 10:44:17', NULL),
('CIP – CB', 'CIP', 'E6', 4, 10, 15, 4, 0, 5, 15, '2023-04-11 10:44:17', NULL),
('Data Comp – VCV', 'Data Compression', 'E3', 0, 50, 0, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('DDPC-SNS', 'DDPC', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('DL – AN', 'DL', 'E5', 0, 50, 50, 50, 0, 0, 50, '2023-04-11 10:44:17', NULL),
('EHCF – DP', 'EHFC', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('IoT – NKS', 'Internet of Things', 'E3', 8, 5, 15, 0, 0, 0, 15, '2023-04-11 10:44:17', NULL),
('Meta Heuristics – AS', 'Meta Heuristics', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('ML – VN', 'Machine Learning', 'E2', 0, 50, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('NWSec – WN', 'Network Security', 'E2', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SM – CRR', 'SM', 'E5', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('SNA – SDB', 'SNA', 'E6', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SocSys-HM', 'Social System', 'E6', 49, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SP-MNM', 'SP', 'E3', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('SysSec-BMM*', 'System Security', 'E1', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:16', NULL),
('Virtualization- PSK *', 'Virtualization', 'E2', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `courseenrolls`
--

CREATE TABLE `courseenrolls` (
  `id` int(11) NOT NULL,
  `studentRegno` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `session` int(11) DEFAULT NULL,
  `department` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `course` int(11) DEFAULT NULL,
  `enrollDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `courseenrolls`
--

INSERT INTO `courseenrolls` (`id`, `studentRegno`, `pincode`, `session`, `department`, `level`, `semester`, `course`, `enrollDate`) VALUES
(1, '10806121', '822894', 1, 1, 2, 3, 1, '2022-02-11 00:59:33'),
(2, '10806121', '822894', 1, 1, 1, 2, 2, '2022-02-11 01:01:07'),
(3, '12356', '181793', 1, 1, 2, 3, 2, '2023-04-02 10:05:59'),
(5, '12356', '181793', 1, 1, 1, 2, 1, '2023-04-02 10:32:08');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `courseName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `faculty_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bucket_number` varchar(11) NOT NULL,
  `seats_for_MCA` int(11) NOT NULL,
  `seats_for_IMTECH_3_4` int(11) NOT NULL,
  `seats_for_IMTECH_5_6` int(11) NOT NULL,
  `seats_for_IMTECH_7_8` int(11) NOT NULL,
  `seats_for_MTECH_AI` int(11) NOT NULL,
  `seats_for_MTECH_CS` int(11) NOT NULL,
  `seats_for_MTECH_IT` int(11) NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_code`, `courseName`, `faculty_name`, `bucket_number`, `seats_for_MCA`, `seats_for_IMTECH_3_4`, `seats_for_IMTECH_5_6`, `seats_for_IMTECH_7_8`, `seats_for_MTECH_AI`, `seats_for_MTECH_CS`, `seats_for_MTECH_IT`, `creationDate`, `updationDate`) VALUES
('CA511', 'AdvancedAlgo', 'ASK', 'E1', 50, 50, 50, 50, 50, 50, 50, '2024-03-07 09:51:11', ''),
('CA512', 'DBMS', 'RPL', 'E1', 50, 50, 50, 50, 50, 50, 50, '2024-03-07 09:51:11', '');

-- --------------------------------------------------------

--
-- Table structure for table `courses_allocated`
--

CREATE TABLE `courses_allocated` (
  `courses_allocated_id` int(11) NOT NULL,
  `courseName` varchar(50) NOT NULL,
  `bucket_number` varchar(11) NOT NULL,
  `student_reg_no` varchar(50) NOT NULL,
  `stream_name` varchar(50) NOT NULL,
  `course_type` varchar(255) NOT NULL,
  `allocation_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses_allocated`
--

INSERT INTO `courses_allocated` (`courses_allocated_id`, `courseName`, `bucket_number`, `student_reg_no`, `stream_name`, `course_type`, `allocation_date`) VALUES
(1, 'System Security', 'E1', '21MCMB05', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(2, 'Virtualization', 'E2', '21MCMB05', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(3, 'System Security', 'E1', '21MCMB01', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(4, 'Virtualization', 'E2', '21MCMB01', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(5, 'Virtualization', 'E2', '21MCMB03', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(6, 'System Security', 'E1', '21MCMB03', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(7, 'Virtualization', 'E2', '21MCMB08', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(8, 'System Security', 'E1', '21MCMB08', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(9, 'System Security', 'E1', '21MCMB04', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(10, 'Virtualization', 'E2', '21MCMB04', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(11, 'System Security', 'E1', '21MCMB06', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(12, 'Virtualization', 'E2', '21MCMB06', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(13, 'System Security', 'E1', '21MCMB07', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(14, 'Virtualization', 'E2', '21MCMB07', 'MTECH_IT', 'Optional Core', '2024-04-16 18:35:43'),
(15, 'Machine Learning', 'E2', '21MCMI16', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(16, 'System Security', 'E1', '21MCMI16', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(17, 'Advance Algo', 'E3', '21MCMI18', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(18, 'System Security', 'E1', '21MCMI18', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(19, 'Network Security', 'E2', '23MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(20, 'System Security', 'E1', '23MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(21, 'Machine Learning', 'E2', '21MCMI25', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(22, 'Advance Algo', 'E3', '21MCMI25', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(23, 'System Security', 'E1', '21MCMI14', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(24, 'Machine Learning', 'E2', '21MCMI14', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(25, 'Machine Learning', 'E2', '21MCMI05', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(26, 'Advance Algo', 'E3', '21MCMI05', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(27, 'Machine Learning', 'E2', '21MCMI20', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(28, 'Advance Algo', 'E3', '21MCMI20', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:51'),
(29, 'Machine Learning', 'E2', '21MCMI09', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(30, 'Advance Algo', 'E3', '21MCMI09', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(31, 'Machine Learning', 'E2', '21MCMI08', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(32, 'Advance Algo', 'E3', '21MCMI08', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(33, 'Machine Learning', 'E2', '21MCMI02', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(34, 'Advance Algo', 'E3', '21MCMI02', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(35, 'Machine Learning', 'E2', '21MCMI21', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(36, 'System Security', 'E1', '21MCMI21', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(37, 'Machine Learning', 'E2', '21MCMI23', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(38, 'Advance Algo', 'E3', '21MCMI23', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(39, 'Machine Learning', 'E2', '21MCMI06', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(40, 'Advance Algo', 'E3', '21MCMI06', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(41, 'Machine Learning', 'E2', '21MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(42, 'Advance Algo', 'E3', '21MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(43, 'Machine Learning', 'E2', '21MCMI15', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(44, 'Advance Algo', 'E3', '21MCMI15', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(45, 'ACN', 'E6', '23MCMI12', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(46, 'System Security', 'E1', '23MCMI12', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(47, 'Machine Learning', 'E2', '21MCMI01', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(48, 'Advance Algo', 'E3', '21MCMI01', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:52'),
(49, 'Machine Learning', 'E2', '21MCMI11', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(50, 'Advance Algo', 'E3', '21MCMI11', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(51, 'Machine Learning', 'E2', '21MCMI04', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(52, 'Advance Algo', 'E3', '21MCMI04', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(53, 'Machine Learning', 'E2', '21MCMI07', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(54, 'Advance Algo', 'E3', '21MCMI07', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(55, 'Advance Algo', 'E3', '21MCMI03', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(56, 'Machine Learning', 'E2', '21MCMI03', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(57, 'Machine Learning', 'E2', '21MCMI10', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(58, 'Advance Algo', 'E3', '21MCMI10', 'MTECH_AI', 'Optional Core', '2024-04-16 18:35:53'),
(681, 'Advance Algo', 'E3', '23MCMT09', 'MTECH_CS', 'Optional Core', '2024-04-26 09:10:13'),
(682, 'System Security', 'E1', '23MCMT09', 'MTECH_CS', 'Optional Core', '2024-04-26 09:10:13'),
(683, 'System Security', 'E1', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-04-26 09:10:13'),
(684, 'Advance Algo', 'E3', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-04-26 09:10:13'),
(1088, 'Social System', 'E6', '22MCMC18', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1089, 'Internet of Things', 'E3', '22MCMC16', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1090, 'CIP', 'E6', '22MCMC19', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1091, 'Cloud Computing', 'E1', '22MCMC18', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1092, 'Cloud Computing', 'E1', '22MCMC16', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1093, 'Internet of Things', 'E3', '22MCMC19', 'MCA', 'Elective', '2024-05-09 10:10:30'),
(1108, 'ACN', 'E6', '21MCMB05', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1109, 'Advance Algo', 'E3', '21MCMB01', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1110, 'Internet of Things', 'E3', '21MCMB03', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1111, 'Internet of Things', 'E3', '21MCMB08', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1112, 'Internet of Things', 'E3', '21MCMB04', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1113, 'CIP', 'E6', '21MCMB06', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20'),
(1114, 'ACN', 'E6', '21MCMB07', 'MTECH_IT', 'Elective', '2024-05-09 10:17:20');

-- --------------------------------------------------------

--
-- Table structure for table `courses_allocated1`
--

CREATE TABLE `courses_allocated1` (
  `courses_allocated_id` int(11) NOT NULL,
  `courseName` varchar(50) NOT NULL,
  `student_reg_no` varchar(50) NOT NULL,
  `stream_name` varchar(50) NOT NULL,
  `course_type` varchar(255) NOT NULL,
  `allocation_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses_allocated1`
--

INSERT INTO `courses_allocated1` (`courses_allocated_id`, `courseName`, `student_reg_no`, `stream_name`, `course_type`, `allocation_date`) VALUES
(1, 'System Security', '21MCMB05', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:20'),
(2, 'Virtualization', '21MCMB05', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:20'),
(3, 'System Security', '21MCMB01', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:21'),
(4, 'Virtualization', '21MCMB01', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:22'),
(5, 'Virtualization', '21MCMB03', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:22'),
(6, 'System Security', '21MCMB03', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:22'),
(7, 'Virtualization', '21MCMB08', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:23'),
(8, 'System Security', '21MCMB08', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:23'),
(9, 'System Security', '21MCMB04', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:23'),
(10, 'Virtualization', '21MCMB04', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:24'),
(11, 'System Security', '21MCMB06', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:24'),
(12, 'Virtualization', '21MCMB06', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:24'),
(13, 'System Security', '21MCMB07', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:25'),
(14, 'Virtualization', '21MCMB07', 'MTECH_IT', 'Optional Core', '2024-04-01 17:31:25'),
(15, 'Machine Learning', '21MCMI16', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(16, 'System Security', '21MCMI16', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(17, 'Advance Algo', '21MCMI18', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(18, 'System Security', '21MCMI18', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(19, 'Network Security', '23MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(20, 'System Security', '23MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(21, 'Machine Learning', '21MCMI25', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:46'),
(22, 'Advance Algo', '21MCMI25', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(23, 'System Security', '21MCMI14', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(24, 'Machine Learning', '21MCMI14', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(25, 'Machine Learning', '21MCMI20', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(26, 'Advance Algo', '21MCMI20', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(27, 'Machine Learning', '21MCMI05', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(28, 'Advance Algo', '21MCMI05', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(29, 'Machine Learning', '21MCMI09', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(30, 'Advance Algo', '21MCMI09', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(31, 'Machine Learning', '21MCMI08', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(32, 'Advance Algo', '21MCMI08', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(33, 'Machine Learning', '21MCMI02', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(34, 'Advance Algo', '21MCMI02', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(35, 'Machine Learning', '21MCMI21', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(36, 'System Security', '21MCMI21', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(37, 'Machine Learning', '21MCMI23', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(38, 'Advance Algo', '21MCMI23', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(39, 'Machine Learning', '21MCMI06', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(40, 'Advance Algo', '21MCMI06', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(41, 'Machine Learning', '21MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(42, 'Advance Algo', '21MCMI22', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(43, 'Machine Learning', '21MCMI15', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(44, 'Advance Algo', '21MCMI15', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(45, 'ACN', '23MCMI12', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(46, 'System Security', '23MCMI12', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(47, 'Machine Learning', '21MCMI01', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(48, 'Advance Algo', '21MCMI01', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(49, 'Machine Learning', '21MCMI11', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(50, 'Advance Algo', '21MCMI11', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:47'),
(51, 'Machine Learning', '21MCMI04', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(52, 'Advance Algo', '21MCMI04', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(53, 'Machine Learning', '21MCMI07', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(54, 'Advance Algo', '21MCMI07', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(55, 'Advance Algo', '21MCMI03', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(56, 'Machine Learning', '21MCMI03', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(57, 'Machine Learning', '21MCMI10', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(58, 'Advance Algo', '21MCMI10', 'MTECH_AI', 'Optional Core', '2024-04-01 17:31:48'),
(59, 'Advance Algo', '23MCMT09', 'MTECH_CS', 'Optional Core', '2024-04-01 17:32:05'),
(60, 'System Security', '23MCMT09', 'MTECH_CS', 'Optional Core', '2024-04-01 17:32:05'),
(61, 'System Security', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-04-01 17:32:05'),
(62, 'Advance Algo', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-04-01 17:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `courses_allocated2`
--

CREATE TABLE `courses_allocated2` (
  `courses_allocated_id` int(11) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  `student_reg_no` varchar(50) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `course_type` varchar(255) NOT NULL,
  `allocation_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses_allocated2`
--

INSERT INTO `courses_allocated2` (`courses_allocated_id`, `course_code`, `student_reg_no`, `course_name`, `course_type`, `allocation_date`) VALUES
(33, 'Machine Learning', '21MCMI16', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:05'),
(34, 'System Security', '21MCMI16', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:13'),
(35, 'Advance Algo', '21MCMI18', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:22'),
(36, 'System Security', '21MCMI18', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:32'),
(37, 'Network Security', '23MCMI22', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:42'),
(38, 'System Security', '23MCMI22', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:27:52'),
(39, 'Machine Learning', '21MCMI25', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:28:02'),
(40, 'Advance Algo', '21MCMI25', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:28:24'),
(41, 'System Security', '21MCMI14', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:28:33'),
(42, 'Machine Learning', '21MCMI14', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:28:45'),
(43, 'Machine Learning', '21MCMI20', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:28:58'),
(44, 'Advance Algo', '21MCMI20', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:29:08'),
(45, 'Machine Learning', '21MCMI05', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:29:20'),
(46, 'Advance Algo', '21MCMI05', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:29:31'),
(47, 'Machine Learning', '21MCMI09', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:29:43'),
(48, 'Advance Algo', '21MCMI09', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:29:55'),
(49, 'Machine Learning', '21MCMI08', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:30:07'),
(50, 'Advance Algo', '21MCMI08', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:30:23'),
(51, 'Machine Learning', '21MCMI02', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:30:34'),
(52, 'Advance Algo', '21MCMI02', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:30:45'),
(53, 'Machine Learning', '21MCMI21', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:30:55'),
(54, 'System Security', '21MCMI21', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:14'),
(55, 'Machine Learning', '21MCMI23', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:04'),
(56, 'Advance Algo', '21MCMI23', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:23'),
(57, 'Machine Learning', '21MCMI06', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:33'),
(58, 'Advance Algo', '21MCMI06', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:44'),
(59, 'Machine Learning', '21MCMI22', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:31:54'),
(60, 'Advance Algo', '21MCMI22', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:32:04'),
(61, 'Machine Learning', '21MCMI15', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:32:16'),
(62, 'Advance Algo', '21MCMI15', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:32:27'),
(63, 'ACN', '23MCMI12', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:32:38'),
(64, 'System Security', '23MCMI12', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:32:50'),
(65, 'Machine Learning', '21MCMI01', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:02'),
(66, 'Advance Algo', '21MCMI01', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:12'),
(67, 'Machine Learning', '21MCMI11', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:23'),
(68, 'Advance Algo', '21MCMI11', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:34'),
(69, 'Machine Learning', '21MCMI04', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:45'),
(70, 'Advance Algo', '21MCMI04', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:33:57'),
(71, 'Machine Learning', '21MCMI07', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:34:10'),
(72, 'Advance Algo', '21MCMI07', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:34:24'),
(73, 'Advance Algo', '21MCMI03', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:34:35'),
(74, 'Machine Learning', '21MCMI03', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:34:48'),
(75, 'Machine Learning', '21MCMI10', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:35:04'),
(76, 'Advance Algo', '21MCMI10', 'MTECH_AI', 'Optional Core\r\n', '2024-03-17 10:35:17'),
(77, 'System Security', '21MCMB05', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:35:30'),
(78, 'Virtualization', '21MCMB05', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:35:43'),
(79, 'System Security', '21MCMB01', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:35:54'),
(80, 'Virtualization', '21MCMB01', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:36:12'),
(81, 'Virtualization', '21MCMB03', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:36:27'),
(82, 'System Security', '21MCMB03', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:36:39'),
(83, 'Virtualization', '21MCMB08', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:36:51'),
(84, 'System Security', '21MCMB08', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:37:07'),
(85, 'System Security', '21MCMB04', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:37:40'),
(86, 'Virtualization', '21MCMB04', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:37:55'),
(87, 'System Security', '21MCMB06', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:38:10'),
(88, 'Virtualization', '21MCMB06', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:26:53'),
(89, 'System Security', '21MCMB07', 'MTECH_IT', 'Optional Core\r\n', '2024-03-17 10:26:37'),
(90, 'Virtualization', '21MCMB07', 'MTECH_IT', 'Optional Core', '2024-03-17 10:26:21'),
(99, 'System Security', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-03-18 10:36:34'),
(100, 'Advance Algo', '23MCMT10', 'MTECH_CS', 'Optional Core', '2024-03-18 10:36:34');

-- --------------------------------------------------------

--
-- Table structure for table `course_backup`
--

CREATE TABLE `course_backup` (
  `course_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `courseName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `bucket_number` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `seats_for_MCA` int(11) DEFAULT NULL,
  `seats_for_MTECH_AI` int(11) DEFAULT NULL,
  `seats_for_MTECH_CS` int(11) DEFAULT NULL,
  `seats_for_MTECH_IT` int(11) DEFAULT NULL,
  `seats_for_IMTECH_3_4` int(11) DEFAULT NULL,
  `seats_for_IMTECH_5_6` int(11) DEFAULT NULL,
  `seats_for_IMTECH_7_8` int(11) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_backup`
--

INSERT INTO `course_backup` (`course_code`, `courseName`, `bucket_number`, `seats_for_MCA`, `seats_for_MTECH_AI`, `seats_for_MTECH_CS`, `seats_for_MTECH_IT`, `seats_for_IMTECH_3_4`, `seats_for_IMTECH_5_6`, `seats_for_IMTECH_7_8`, `creationDate`, `updationDate`) VALUES
('ACN – V Radha*', 'ACN', 'E6', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('AdvAlgo-RPL', 'Advance Algo', 'E3', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('Biometrics – MVNK *', 'Biometrics', 'E5', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('CC – RW', 'Cloud Computing', 'E1', 8, 5, 50, 0, 0, 5, 5, '2023-04-11 10:44:17', NULL),
('CIP – CB', 'CIP', 'E6', 5, 10, 15, 5, 0, 5, 15, '2023-04-11 10:44:17', NULL),
('Data Comp – VCV', 'Data Compression', 'E3', 0, 50, 0, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('DDPC-SNS', 'DDPC', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('DL – AN', 'DL', 'E5', 0, 50, 50, 50, 0, 0, 50, '2023-04-11 10:44:17', NULL),
('EHCF – DP', 'EHFC', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('IoT – NKS', 'Internet of Things', 'E3', 10, 5, 15, 5, 0, 0, 15, '2023-04-11 10:44:17', NULL),
('Meta Heuristics – AS', 'Meta Heuristics', 'E4', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('ML – VN', 'Machine Learning', 'E2', 0, 50, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('NWSec – WN', 'Network Security', 'E2', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SM – CRR', 'SM', 'E5', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('SNA – SDB', 'SNA', 'E6', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SocSys-HM', 'Social System', 'E6', 50, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL),
('SP-MNM', 'SP', 'E3', 0, 0, 0, 0, 0, 0, 0, '2023-04-11 10:44:17', NULL),
('SysSec-BMM*', 'System Security', 'E1', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:16', NULL),
('Virtualization- PSK *', 'Virtualization', 'E2', 0, 50, 50, 50, 0, 50, 50, '2023-04-11 10:44:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `department`, `creationDate`) VALUES
(1, 'IT', '2022-02-10 17:23:04'),
(2, 'HR', '2022-02-10 17:23:09');

-- --------------------------------------------------------

--
-- Table structure for table `elective_preference`
--

CREATE TABLE `elective_preference` (
  `elective_preference_id` int(11) NOT NULL,
  `studentRegno` varchar(255) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `E1` varchar(255) DEFAULT NULL,
  `E2` varchar(255) DEFAULT NULL,
  `E3` varchar(255) DEFAULT NULL,
  `E4` varchar(255) DEFAULT NULL,
  `E5` varchar(255) DEFAULT NULL,
  `E6` varchar(255) DEFAULT NULL,
  `E7` varchar(255) DEFAULT NULL,
  `E8` varchar(255) DEFAULT NULL,
  `E9` varchar(255) DEFAULT NULL,
  `E10` varchar(255) DEFAULT NULL,
  `E11` varchar(255) DEFAULT NULL,
  `E12` varchar(255) DEFAULT NULL,
  `E13` varchar(255) DEFAULT NULL,
  `E14` varchar(255) DEFAULT NULL,
  `E15` varchar(255) DEFAULT NULL,
  `E16` varchar(255) DEFAULT NULL,
  `E17` varchar(255) DEFAULT NULL,
  `E18` varchar(255) DEFAULT NULL,
  `E19` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elective_preference`
--

INSERT INTO `elective_preference` (`elective_preference_id`, `studentRegno`, `stream_name`, `E1`, `E2`, `E3`, `E4`, `E5`, `E6`, `E7`, `E8`, `E9`, `E10`, `E11`, `E12`, `E13`, `E14`, `E15`, `E16`, `E17`, `E18`, `E19`) VALUES
(1, '21MCMB01', 'MTECH_IT', 'Advance Algo', 'DDPC', 'DL', 'ACN', 'CIP', 'SNA', 'Social System', 'Internet of Things', 'Data Compression', 'Meta Heuristics', 'EHFC', 'Network Security', 'Cloud Computing', 'Machine Learning', 'SP', 'Biometrics', 'SM', 'NULL', 'NULL'),
(2, '21MCMB03', 'MTECH_IT', 'Internet of Things', 'Meta Heuristics', 'DL', 'ACN', 'Advance Algo', 'SNA', 'Social System', 'CIP', 'Network Security', 'Data Compression', 'DDPC', 'EHFC', 'SP', 'SM', 'Machine Learning', 'Biometrics', 'Cloud Computing', 'NULL', 'NULL'),
(3, '21MCMB04', 'MTECH_IT', 'Internet of Things', 'EHFC', 'DL', 'CIP', 'Social System', 'SNA', 'Network Security', 'Meta Heuristics', 'Data Compression', 'DDPC', 'Advance Algo', 'ACN', 'Biometrics', 'SP', 'SM', 'Machine Learning', 'Cloud Computing', 'NULL', 'NULL'),
(4, '21MCMB05', 'MTECH_IT', 'ACN', 'DL', 'Internet of Things', 'Advance Algo', 'Network Security', 'Meta Heuristics', 'SNA', 'Social System', 'Data Compression', 'EHFC', 'DDPC', 'CIP', 'Cloud Computing', 'Biometrics', 'Machine Learning', 'SP', 'SM', 'NULL', 'NULL'),
(5, '21MCMB06', 'MTECH_IT', 'Internet of Things', 'CIP', 'DL', 'Network Security', 'Data Compression', 'SNA', 'EHFC', 'Social System', 'DDPC', 'Meta Heuristics', 'Advance Algo', 'ACN', 'SM', 'SP', 'Machine Learning', 'Biometrics', 'Cloud Computing', 'NULL', 'NULL'),
(6, '21MCMB07', 'MTECH_IT', 'Internet of Things', 'ACN', 'Advance Algo', 'Meta Heuristics', 'Social System', 'EHFC', 'Network Security', 'SNA', 'DDPC', 'DL', 'CIP', 'Data Compression', 'SP', 'SM', 'Biometrics', 'Machine Learning', 'Cloud Computing', 'NULL', 'NULL'),
(7, '21MCMB08', 'MTECH_IT', 'Internet of Things', 'ACN', 'CIP', 'Network Security', 'Social System', 'DL', 'EHFC', 'SNA', 'Meta Heuristics', 'Data Compression', 'DDPC', 'Advance Algo', 'SP', 'Cloud Computing', 'Machine Learning', 'SM', 'Biometrics', 'NULL', 'NULL'),
(8, '23MCMT10', 'MTECH_CS', 'Cloud Computing', 'Virtualization', 'Data Compression', 'EHFC', 'DDPC', 'Machine Learning', 'Internet of Things', 'SP', 'Social System', 'SM', 'ACN', 'Biometrics', 'DL', 'CIP', 'Network Security', 'SNA', 'Meta Heuristics', 'NULL', 'NULL'),
(9, '23MCMT09', 'MTECH_CS', 'Cloud Computing', 'Data Compression', 'Virtualization', 'Network Security', 'EHFC', 'DDPC', 'CIP', 'ACN', 'Internet of Things', 'Biometrics', 'Meta Heuristics', 'SNA', 'Social System', 'SP', 'SM', 'Machine Learning', 'DL', 'NULL', 'NULL'),
(12, '22MCMC16', 'MCA', 'Data Compression', 'Internet of Things', 'Cloud Computing', 'Social System', 'CIP', 'Advance Algo', 'Virtualization', 'Machine Learning', 'DL', 'ACN', 'System Security', 'SM', 'DDPC', 'Network Security', 'Biometrics', 'SP', 'SNA', 'Meta Heuristics', 'EHFC'),
(13, '22MCMC19', 'MCA', 'CIP', 'Data Compression', 'Social System', 'Internet of Things', 'Cloud Computing', 'ACN', 'DDPC', 'Virtualization', 'System Security', 'SP', 'SNA', 'Network Security', 'Machine Learning', 'Meta Heuristics', 'EHFC', 'Biometrics', 'Advance Algo', 'SM', 'DL'),
(14, '22MCMC18', 'MCA', 'Social System', 'Cloud Computing', 'Data Compression', 'Internet of Things', 'CIP', 'Advance Algo', 'Network Security', 'System Security', 'Virtualization', 'SP', 'SM', 'SNA', 'Machine Learning', 'Meta Heuristics', 'DL', 'EHFC', 'DDPC', 'ACN', 'Biometrics');

-- --------------------------------------------------------

--
-- Table structure for table `elective_preference1`
--

CREATE TABLE `elective_preference1` (
  `elective_preference_id` int(11) NOT NULL,
  `studentRegno` varchar(255) NOT NULL,
  `E1` varchar(255) DEFAULT NULL,
  `E2` varchar(255) DEFAULT NULL,
  `E3` varchar(255) DEFAULT NULL,
  `E4` varchar(255) DEFAULT NULL,
  `E5` varchar(255) DEFAULT NULL,
  `E6` varchar(255) DEFAULT NULL,
  `E7` varchar(255) DEFAULT NULL,
  `E8` varchar(255) DEFAULT NULL,
  `E9` varchar(255) DEFAULT NULL,
  `E10` varchar(255) DEFAULT NULL,
  `E11` varchar(255) DEFAULT NULL,
  `E12` varchar(255) DEFAULT NULL,
  `E13` varchar(255) DEFAULT NULL,
  `E14` varchar(255) DEFAULT NULL,
  `E15` varchar(255) DEFAULT NULL,
  `E16` varchar(255) DEFAULT NULL,
  `E17` varchar(255) DEFAULT NULL,
  `E18` varchar(255) DEFAULT NULL,
  `E19` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elective_preference1`
--

INSERT INTO `elective_preference1` (`elective_preference_id`, `studentRegno`, `E1`, `E2`, `E3`, `E4`, `E5`, `E6`, `E7`, `E8`, `E9`, `E10`, `E11`, `E12`, `E13`, `E14`, `E15`, `E16`, `E17`, `E18`, `E19`) VALUES
(1, '21MCMB01', 'Advance Algo', 'DDPC', 'DL', 'ACN', 'CIP', 'SNA', 'Social System', 'Internet of Things', 'Data Compression', 'Meta Heuristics', 'EHFC', 'Network Security', 'Cloud Computing', 'Machine Learning', 'SP', 'Biometrics', 'SM', 'NULL', 'NULL'),
(2, '21MCMB03', 'Internet of Things', 'Meta Heuristics', 'DL', 'ACN', 'Advance Algo', 'SNA', 'Social System', 'CIP', 'Network Security', 'Data Compression', 'DDPC', 'EHFC', 'SP', 'SM', 'Machine Learning', 'Biometrics', 'Cloud Computing', 'NULL', 'NULL'),
(3, '21MCMB04', 'Internet of Things', 'EHFC', 'DL', 'CIP', 'Social System', 'SNA', 'Network Security', 'Meta Heuristics', 'Data Compression', 'DDPC', 'Advance Algo', 'ACN', 'Biometrics', 'SP', 'SM', 'Machine Learning', 'Cloud Computing', 'NULL', 'NULL'),
(4, '21MCMB05', 'ACN', 'DL', 'Internet of Things', 'Advance Algo', 'Network Security', 'Meta Heuristics', 'SNA', 'Social System', 'Data Compression', 'EHFC', 'DDPC', 'CIP', 'Cloud Computing', 'Biometrics', 'Machine Learning', 'SP', 'SM', 'NULL', 'NULL'),
(5, '21MCMB06', 'Internet of Things', 'CIP', 'DL', 'Network Security', 'Data Compression', 'SNA', 'EHFC', 'Social System', 'DDPC', 'Meta Heuristics', 'Advance Algo', 'ACN', 'SM', 'SP', 'Machine Learning', 'Biometrics', 'Cloud Computing', 'NULL', 'NULL'),
(6, '21MCMB07', 'Internet of Things', 'ACN', 'Advance Algo', 'Meta Heuristics', 'Social System', 'EHFC', 'Network Security', 'SNA', 'DDPC', 'DL', 'CIP', 'Data Compression', 'SP', 'SM', 'Biometrics', 'Machine Learning', 'Cloud Computing', 'NULL', 'NULL'),
(7, '21MCMB08', 'Internet of Things', 'ACN', 'CIP', 'Network Security', 'Social System', 'DL', 'EHFC', 'SNA', 'Meta Heuristics', 'Data Compression', 'DDPC', 'Advance Algo', 'SP', 'Cloud Computing', 'Machine Learning', 'SM', 'Biometrics', 'NULL', 'NULL'),
(8, '23MCMT10', 'Cloud Computing', 'Data Compression', 'Internet of Things', 'Network Security', 'DDPC', 'Machine Learning', 'Virtualization', 'SP', 'Social System', 'SM', 'ACN', 'Biometrics', 'DL', 'CIP', 'EHFC', 'SNA', 'Meta Heuristics', 'NULL', 'NULL'),
(9, '22MCMC16', 'Data Compression', 'Social System', 'Internet of Things', 'Cloud Computing', 'CIP', 'SP', 'System Security', 'Virtualization', 'DL', 'SM', 'SNA', 'Meta Heuristics', 'Machine Learning', 'Network Security', 'EHFC', 'DDPC', 'Biometrics', 'Advance Algo', 'ACN');

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
(43, 3, 'MTECH_CS', 'Advance Algo'),
(45, 3, 'MTECH_CS', 'Machine Learning'),
(46, 3, 'MTECH_CS', 'System Security'),
(61, 4, 'MTECH_IT', 'System Security'),
(62, 4, 'MTECH_IT', 'Virtualization'),
(63, 2, 'MTECH_AI', 'Advance Algo'),
(64, 2, 'MTECH_AI', 'Machine Learning'),
(65, 2, 'MTECH_AI', 'System Security'),
(67, 3, 'MTECH_CS', 'Cloud Computing'),
(68, 4, 'MTECH_IT', 'Network Security'),
(69, 4, 'MTECH_IT', 'Advance Algo');

-- --------------------------------------------------------

--
-- Table structure for table `eligible_optional_core1`
--

CREATE TABLE `eligible_optional_core1` (
  `id` int(11) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `courseName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eligible_optional_core1`
--

INSERT INTO `eligible_optional_core1` (`id`, `stream_id`, `stream_name`, `courseName`) VALUES
(22, 2, 'MTECH_AI', 'ACN'),
(23, 2, 'MTECH_AI', 'Network Security'),
(24, 2, 'MTECH_AI', 'System Security'),
(25, 2, 'MTECH_AI', 'Virtualization'),
(42, 3, 'MTECH_CS', 'ACN'),
(43, 3, 'MTECH_CS', 'Advance Algo'),
(44, 3, 'MTECH_CS', 'DL'),
(45, 3, 'MTECH_CS', 'Machine Learning'),
(46, 3, 'MTECH_CS', 'System Security'),
(60, 4, 'MTECH_IT', 'Internet of Things'),
(61, 4, 'MTECH_IT', 'System Security'),
(62, 4, 'MTECH_IT', 'Virtualization');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `id` int(11) NOT NULL,
  `level` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`id`, `level`, `creationDate`) VALUES
(1, '1', '2022-02-11 00:59:02'),
(2, '2', '2022-02-11 00:59:02'),
(3, '3', '2022-02-11 00:59:09');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `newstitle` varchar(255) DEFAULT NULL,
  `newsDescription` mediumtext DEFAULT NULL,
  `postingDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `newstitle`, `newsDescription`, `postingDate`) VALUES
(2, 'Test News', 'This is for testing. This is for testing.This is for testing.This is for testing.This is for testing.This is for testing.This is for testing.This is for testing.This is for testing.This is for testing.', '2022-02-10 17:36:50'),
(3, 'New Course Started C#', 'This is sample text for testing.', '2022-02-11 00:54:38'),
(4, 'Deadline', 'Today is the last date to register for OC', '2023-04-06 10:46:59'),
(5, '', '', '2023-04-17 06:26:40');

-- --------------------------------------------------------

--
-- Table structure for table `semester`
--

CREATE TABLE `semester` (
  `id` int(11) NOT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`id`, `semester`, `creationDate`, `updationDate`) VALUES
(1, '8', '2022-02-10 17:22:49', NULL),
(2, '4', '2022-02-10 17:22:55', NULL),
(3, '3', '2022-02-11 00:51:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `session` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `session`, `creationDate`) VALUES
(1, '2022', '2022-02-10 17:10:59');

-- --------------------------------------------------------

--
-- Table structure for table `set_oc_electives`
--

CREATE TABLE `set_oc_electives` (
  `stream_id` int(11) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `optional_cores_count` int(10) NOT NULL,
  `electives` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `set_oc_electives`
--

INSERT INTO `set_oc_electives` (`stream_id`, `stream_name`, `optional_cores_count`, `electives`) VALUES
(1, 'MCA', 0, 2),
(2, 'MTECH_AI', 2, 1),
(3, 'MTECH_CS', 2, 2),
(4, 'MTECH_IT', 2, 1),
(5, 'IMTECH_3_4', 0, 0),
(6, 'IMTECH_5_6', 0, 0),
(7, 'IMTECH_7_8', 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `stream`
--

CREATE TABLE `stream` (
  `stream_id` int(11) NOT NULL,
  `stream_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stream`
--

INSERT INTO `stream` (`stream_id`, `stream_name`) VALUES
(1, 'MCA'),
(2, 'MTECH_AI'),
(3, 'MTECH_CS'),
(4, 'MTECH_IT'),
(5, 'IMTECH_3_4'),
(6, 'IMTECH_5_6'),
(7, 'IMTECH_7_8');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `studentRegno` varchar(255) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `studentPhoto` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `studentName` varchar(255) DEFAULT NULL,
  `course_name` varchar(200) NOT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `cgpa` decimal(10,2) DEFAULT NULL,
  `courses_allocated_id` int(11) NOT NULL COMMENT 'course codes',
  `enrolment_status_OptionalCore` tinyint(1) NOT NULL,
  `enrolment_status_elective` tinyint(1) NOT NULL,
  `optional_core_choice_1` varchar(50) DEFAULT NULL,
  `optional_core_choice_2` varchar(50) DEFAULT NULL,
  `optional_core_choice_3` varchar(50) DEFAULT NULL,
  `optional_core_choice_4` varchar(50) DEFAULT NULL,
  `optional_core_choice_5` varchar(50) DEFAULT NULL,
  `password_status` tinyint(1) NOT NULL DEFAULT 0,
  `ecount` int(11) NOT NULL DEFAULT 0,
  `creationdate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentRegno`, `stream_id`, `studentPhoto`, `password`, `studentName`, `course_name`, `pincode`, `session`, `department`, `semester`, `cgpa`, `courses_allocated_id`, `enrolment_status_OptionalCore`, `enrolment_status_elective`, `optional_core_choice_1`, `optional_core_choice_2`, `optional_core_choice_3`, `optional_core_choice_4`, `optional_core_choice_5`, `password_status`, `ecount`, `creationdate`, `updationDate`) VALUES
('16MCME02', 7, '', 'Team@123', 'yaswanth chouturi ', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 10.00, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME01', 7, '', 'Team@123', 'Shruti Patchigolla', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.06, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME02', 7, '', 'Team@123', 'Amruta Jandhyala', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.95, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME03', 7, '', 'Team@123', 'Arun Kumar Dharavath', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.68, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME04', 7, '', 'Team@123', 'Gayathri G', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.41, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME07', 7, '', 'Team@123', 'Preethi Kajjayam', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.08, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME09', 7, '', 'Team@123', 'Challa Subramanyam', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.90, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME10', 7, '', 'Team@123', 'K. Parikshit Rao', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.19, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME11', 7, '', 'Team@123', 'P Sai Teja', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.30, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME13', 7, '', 'Team@123', 'A.Pavan kumar', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.09, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME14', 7, '', 'Team@123', 'Harshitha Bingi', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME15', 7, '', 'Team@123', 'Mallu Rakesh Reddy', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.20, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME16', 7, '', 'Team@123', 'Rohan', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.81, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME17', 7, '', 'Team@123', 'V. Sai Koushik', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.19, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME18', 7, '', 'Team@123', 'K. Roopa Yashaswini', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.63, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME19', 7, '', 'Team@123', 'Chinthakindi Tarun', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.77, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME21', 7, '', 'Team@123', 'Piyush Parwani', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.02, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:46', NULL),
('18MCME22', 7, '', 'Team@123', 'Yasaswini Tiramdas', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.80, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME23', 7, '', 'Team@123', 'Sucharitha Isukapalli', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.58, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('18MCME24', 7, '', 'Team@123', 'Nitin Sai Bommi', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.74, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-09 09:22:45', NULL),
('21MCMB01', 4, '', 'Team@123', 'CHINMAYEE MOHAPATRA', 'MTECH_IT', NULL, NULL, NULL, NULL, 415.00, 0, 1, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB03', 4, '', 'Team@123', 'SRINIVASA S SAI YALAMANCHILI', 'MTECH_IT', NULL, NULL, NULL, NULL, 387.00, 0, 1, 1, 'Virtualization', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB04', 4, '', 'Team@123', 'KRISHNA MOHAN RAM', 'MTECH_IT', NULL, NULL, NULL, NULL, 266.00, 0, 1, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB05', 4, '', 'Test@123', 'SHARMISTHA CHOUDHURY', 'MTECH_IT', NULL, NULL, NULL, NULL, 481.00, 0, 1, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB06', 4, '', 'Team@123', 'AKEPOGU ANUSHA', 'MTECH_IT', NULL, NULL, NULL, NULL, 263.00, 0, 1, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB07', 4, '', 'Team@123', 'KESHAV', 'MTECH_IT', NULL, NULL, NULL, NULL, 258.00, 0, 1, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCMB08', 4, '', 'Team@123', 'MOHAMMAD AZEEM KHAN', 'MTECH_IT', NULL, NULL, NULL, NULL, 384.00, 0, 1, 1, 'Virtualization', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-09 09:57:39', NULL),
('21MCME09', 6, NULL, 'Test@123', 'Kumar', 'IMTECH_5-6', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-07 17:00:48', NULL),
('21MCMI01', 2, '', 'Team@123', 'Ravi Teja Gundimeda', 'MTECH_AI', NULL, NULL, NULL, NULL, 392.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI02', 2, '', 'Team@123', 'Gorla Vivek Yadav', 'MTECH_AI', NULL, NULL, NULL, NULL, 464.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI03', 2, '', 'Team@123', 'Mahitha Kodali', 'MTECH_AI', NULL, NULL, NULL, NULL, 308.00, 0, 1, 0, 'Advance Algo', 'Machine Learning', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI04', 2, '', 'Team@123', 'Yashwanth Marrapu', 'MTECH_AI', NULL, NULL, NULL, NULL, 363.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI05', 2, '', 'Team@123', 'Ch Saiman Naidu', 'MTECH_AI', NULL, NULL, NULL, NULL, 548.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI06', 2, '', 'Team@123', 'Pramod Kumar Dwivedi', 'MTECH_AI', NULL, NULL, NULL, NULL, 415.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI07', 2, '', 'Team@123', 'Jagjeet Suryawanshi', 'MTECH_AI', NULL, NULL, NULL, NULL, 321.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI08', 2, '', 'Team@123', 'SAYAN DAS', 'MTECH_AI', NULL, NULL, NULL, NULL, 469.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI09', 2, '', 'Team@123', 'Sai Sanjana Madaram', 'MTECH_AI', NULL, NULL, NULL, NULL, 481.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI10', 2, '', 'Team@123', 'Manzoor Murtaza', 'MTECH_AI', NULL, NULL, NULL, NULL, 285.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI11', 2, '', 'Team@123', 'AMARJEET KUMAR', 'MTECH_AI', NULL, NULL, NULL, NULL, 370.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI14', 2, '', 'Team@123', 'Rajesh Thalla', 'MTECH_AI', NULL, NULL, NULL, NULL, 562.00, 0, 1, 0, 'System Security', 'Machine Learning', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI15', 2, '', 'Team@123', 'Kayala Jeevan Prakash', 'MTECH_AI', NULL, NULL, NULL, NULL, 397.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI16', 2, '', 'Team@123', 'R P Yashasvi', 'MTECH_AI', NULL, NULL, NULL, NULL, 608.00, 0, 1, 0, 'Machine Learning', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI18', 2, '', 'Team@123', 'Dipyaman Mukhopadhyay', 'MTECH_AI', NULL, NULL, NULL, NULL, 606.00, 0, 1, 0, 'Advance Algo', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI20', 2, '', 'Team@123', 'Drishty gupta', 'MTECH_AI', NULL, NULL, NULL, NULL, 548.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI21', 2, '', 'Team@123', 'KRISHNA CHANDRA YADAV', 'MTECH_AI', NULL, NULL, NULL, NULL, 459.00, 0, 1, 0, 'Machine Learning', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI22', 2, '', 'Team@123', 'Vikas Koleti', 'MTECH_AI', NULL, NULL, NULL, NULL, 408.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI23', 2, '', 'Team@123', 'M Pranayraj', 'MTECH_AI', NULL, NULL, NULL, NULL, 437.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('21MCMI25', 2, '', 'Team@123', 'Pralhad Kolambkar', 'MTECH_AI', NULL, NULL, NULL, NULL, 565.00, 0, 1, 0, 'Machine Learning', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-13 06:54:10', NULL),
('22MCMC16', 1, '', '12345', 'Pavan', 'MCA', NULL, NULL, NULL, NULL, 7.44, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-07 18:20:24', NULL),
('22MCMC18', 1, '', '12345', 'Ravi', 'MCA', NULL, NULL, NULL, NULL, 8.02, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-26 18:50:43', NULL),
('22MCMC19', 1, '', '12345', 'Nag', 'MCA', NULL, NULL, NULL, NULL, 7.00, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-23 09:53:44', NULL),
('22MCME18', 5, NULL, 'Team@123', 'Suman', 'IMTECH_3-4', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, '2024-03-07 17:00:48', NULL),
('23MCMI12', 2, '', '12345', 'Ayushi', 'MTECH_AI', NULL, NULL, NULL, NULL, 393.00, 0, 1, 0, 'ACN', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-07 17:00:48', NULL),
('23MCMI22', 2, '', 'Team@123', 'Vernika', 'MTECH_AI', NULL, NULL, NULL, NULL, 600.00, 0, 1, 0, 'Network Security', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-07 17:00:48', NULL),
('23MCMT09', 3, NULL, '12345', 'Krithi', 'MTECH_CS', NULL, NULL, NULL, NULL, 625.00, 0, 1, 0, 'Advance Algo', 'System Security', 'NULL', 'NULL', 'NULL', 0, 0, '2024-04-01 17:20:36', NULL),
('23MCMT10', 3, NULL, '12345', 'Putin', 'MTECH_CS', NULL, NULL, NULL, NULL, 597.00, 0, 1, 0, 'System Security', 'Advance Algo', 'NULL', 'NULL', 'NULL', 0, 0, '2024-03-07 17:00:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students1`
--

CREATE TABLE `students1` (
  `studentRegno` varchar(255) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `studentPhoto` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `studentName` varchar(255) DEFAULT NULL,
  `course_name` varchar(200) NOT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `cgpa` decimal(10,2) DEFAULT NULL,
  `courses_allocated_id` int(11) NOT NULL COMMENT 'course codes',
  `enrolment_status` tinyint(1) NOT NULL,
  `optional_core_choice_1` varchar(50) DEFAULT NULL,
  `optional_core_choice_2` varchar(50) DEFAULT NULL,
  `optional_core_choice_3` varchar(50) DEFAULT NULL,
  `optional_core_choice_4` varchar(50) DEFAULT NULL,
  `optional_core_choice_5` varchar(50) DEFAULT NULL,
  `password_status` tinyint(1) NOT NULL DEFAULT 0,
  `creationdate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `students1`
--

INSERT INTO `students1` (`studentRegno`, `stream_id`, `studentPhoto`, `password`, `studentName`, `course_name`, `pincode`, `session`, `department`, `semester`, `cgpa`, `courses_allocated_id`, `enrolment_status`, `optional_core_choice_1`, `optional_core_choice_2`, `optional_core_choice_3`, `optional_core_choice_4`, `optional_core_choice_5`, `password_status`, `creationdate`, `updationDate`) VALUES
('16MCME02', 7, '', 'Team@123', 'yaswanth chouturi', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 10.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME01', 7, '', 'Team@123', 'Shruti Patchigolla', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.06, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME02', 7, '', 'Team@123', 'Amruta Jandhyala', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.95, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME03', 7, '', 'Team@123', 'Arun Kumar Dharavath', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.68, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME04', 7, '', 'Team@123', 'Gayathri G', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.41, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME07', 7, '', 'Team@123', 'Preethi Kajjayam', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.08, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME09', 7, '', 'Team@123', 'Challa Subramanyam', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.90, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME10', 7, '', 'Team@123', 'K. Parikshit Rao', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.19, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME11', 7, '', 'Team@123', 'P Sai Teja', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.30, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME13', 7, '', 'Team@123', 'A.Pavan kumar', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.09, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME14', 7, '', 'Team@123', 'Harshitha Bingi', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.10, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME15', 7, '', 'Team@123', 'Mallu Rakesh Reddy', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.20, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME16', 7, '', 'Team@123', 'Rohan', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 8.81, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME17', 7, '', 'Team@123', 'V. Sai Koushik', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.19, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME18', 7, '', 'Team@123', 'K. Roopa Yashaswini', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.63, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME19', 7, '', 'Team@123', 'Chinthakindi Tarun', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.77, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME21', 7, '', 'Team@123', 'Piyush Parwani', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 7.02, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:46', NULL),
('18MCME22', 7, '', 'Team@123', 'Yasaswini Tiramdas', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.80, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME23', 7, '', 'Team@123', 'Sucharitha Isukapalli', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.58, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('18MCME24', 7, '', 'Team@123', 'Nitin Sai Bommi', 'IMTECH_7_8', NULL, NULL, NULL, NULL, 9.74, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-09 09:22:45', NULL),
('21MCMB01', 4, '', 'Team@123', 'CHINMAYEE MOHAPATRA', 'MTECH_IT', NULL, NULL, NULL, NULL, 415.00, 0, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB03', 4, '', 'Team@123', 'SRINIVASA S SAI YALAMANCHILI', 'MTECH_IT', NULL, NULL, NULL, NULL, 387.00, 0, 1, 'Virtualization', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB04', 4, '', 'Team@123', 'KRISHNA MOHAN RAM', 'MTECH_IT', NULL, NULL, NULL, NULL, 266.00, 0, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB05', 4, '', '12345', 'SHARMISTHA CHOUDHURY', 'MTECH_IT', NULL, NULL, NULL, NULL, 481.00, 0, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB06', 4, '', 'Team@123', 'AKEPOGU ANUSHA', 'MTECH_IT', NULL, NULL, NULL, NULL, 263.00, 0, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB07', 4, '', 'Team@123', 'KESHAV', 'MTECH_IT', NULL, NULL, NULL, NULL, 258.00, 0, 1, 'System Security', 'Virtualization', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCMB08', 4, '', 'Team@123', 'MOHAMMAD AZEEM KHAN', 'MTECH_IT', NULL, NULL, NULL, NULL, 384.00, 0, 1, 'Virtualization', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-09 09:57:39', NULL),
('21MCME09', 6, NULL, 'Test@123', 'Kumar', 'IMTECH_5-6', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 17:00:48', NULL),
('22MCMC16', 1, NULL, '12345', 'Pavan', 'MCA', '930514', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 18:20:24', NULL),
('22MCME18', 5, NULL, 'Team@123', 'Suman', 'IMTECH_3-4', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 17:00:48', NULL),
('23MCMI12', 2, NULL, '12345', 'Ayushi', 'MTECH_AI', NULL, NULL, NULL, NULL, NULL, 0, 0, 'ACN', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MCMI22', 2, NULL, 'Team@123', 'Vernika', 'MTECH_AI', NULL, NULL, NULL, NULL, NULL, 0, 0, 'Network Security', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MCMT10', 3, NULL, 'Team@123', 'Putin', 'MTECH_CS', NULL, NULL, NULL, NULL, NULL, 0, 0, 'Advance Algo', 'Machine Learning', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MTIT13', 4, NULL, 'Team@123', 'Thiru', 'MTECH_IT', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 17:00:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `userlog`
--

CREATE TABLE `userlog` (
  `id` int(11) NOT NULL,
  `studentRegno` varchar(255) DEFAULT NULL,
  `userip` binary(16) DEFAULT NULL,
  `loginTime` timestamp NULL DEFAULT current_timestamp(),
  `logout` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `userlog`
--

INSERT INTO `userlog` (`id`, `studentRegno`, `userip`, `loginTime`, `logout`, `status`) VALUES
(1, '10806121', 0x3a3a3100000000000000000000000000, '2022-02-11 00:55:07', NULL, 1),
(2, '10806121', 0x3a3a3100000000000000000000000000, '2022-02-11 00:57:00', NULL, 1),
(3, '10806121', 0x3a3a3100000000000000000000000000, '2022-02-11 00:57:22', '11-02-2022 06:31:26 AM', 1),
(4, '10806121', 0x3a3a3100000000000000000000000000, '2023-03-31 19:12:45', NULL, 1),
(5, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:21:13', '02-04-2023 02:55:53 PM', 1),
(6, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:36:15', NULL, 1),
(7, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:37:49', '02-04-2023 03:10:25 PM', 1),
(8, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:41:29', '02-04-2023 03:13:21 PM', 1),
(9, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:49:02', '02-04-2023 03:20:10 PM', 1),
(10, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:50:15', '02-04-2023 03:27:21 PM', 1),
(11, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 09:58:47', '02-04-2023 03:32:00 PM', 1),
(12, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:02:41', '02-04-2023 03:33:04 PM', 1),
(13, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:03:13', '02-04-2023 03:35:10 PM', 1),
(14, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:05:23', '02-04-2023 03:41:56 PM', 1),
(15, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:19:40', NULL, 1),
(16, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:20:05', NULL, 1),
(17, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:23:31', '02-04-2023 04:01:41 PM', 1),
(18, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:31:50', '02-04-2023 04:05:45 PM', 1),
(19, '10806121', 0x3a3a3100000000000000000000000000, '2023-04-02 10:46:35', '02-04-2023 04:21:57 PM', 1),
(20, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:52:06', '02-04-2023 04:22:21 PM', 1),
(21, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:52:43', '02-04-2023 04:23:57 PM', 1),
(22, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 10:59:53', '02-04-2023 04:31:06 PM', 1),
(23, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 11:01:13', '02-04-2023 05:11:23 PM', 1),
(24, '12356', 0x3a3a3100000000000000000000000000, '2023-04-02 11:41:30', '02-04-2023 05:11:37 PM', 1),
(25, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-03 16:34:30', '03-04-2023 10:04:55 PM', 1),
(26, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-03 16:35:24', '03-04-2023 10:07:22 PM', 1),
(27, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-05 17:17:11', '05-04-2023 10:49:45 PM', 1),
(28, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-06 05:56:17', NULL, 1),
(29, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-06 10:26:52', '06-04-2023 03:57:57 PM', 1),
(30, '21mcmc12', 0x3a3a3100000000000000000000000000, '2023-04-06 10:47:49', '06-04-2023 04:18:34 PM', 1),
(31, '12356', 0x3a3a3100000000000000000000000000, '2023-04-08 20:10:27', NULL, 1),
(32, '12356', 0x3a3a3100000000000000000000000000, '2023-04-10 08:01:57', '10-04-2023 02:14:33 PM', 1),
(33, '12356', 0x3a3a3100000000000000000000000000, '2023-04-10 08:44:38', '10-04-2023 02:51:59 PM', 1),
(34, '12356', 0x3a3a3100000000000000000000000000, '2023-04-10 09:22:04', NULL, 1),
(35, '12356', 0x3a3a3100000000000000000000000000, '2023-04-10 15:40:42', NULL, 1),
(36, '16MCME02', 0x3a3a3100000000000000000000000000, '2023-04-11 06:20:46', NULL, 1),
(37, '18MCME01', 0x3a3a3100000000000000000000000000, '2023-04-11 10:48:48', NULL, 1),
(38, '12356', 0x3a3a3100000000000000000000000000, '2023-04-16 18:12:29', NULL, 1),
(39, '12356', 0x3a3a3100000000000000000000000000, '2023-04-16 19:06:38', NULL, 1),
(40, '12356', 0x3a3a3100000000000000000000000000, '2023-04-17 06:34:02', NULL, 1),
(41, '12356', 0x3a3a3100000000000000000000000000, '2024-02-02 13:43:36', '02-02-2024 07:52:57 PM', 1),
(42, '12356', 0x3a3a3100000000000000000000000000, '2024-02-03 18:34:05', NULL, 1),
(43, '12356', 0x3a3a3100000000000000000000000000, '2024-02-08 04:49:53', '08-02-2024 10:38:36 AM', 1),
(44, '12356', 0x3a3a3100000000000000000000000000, '2024-02-09 05:22:24', '09-02-2024 10:58:27 AM', 1),
(45, '22mcmc16', 0x3a3a3100000000000000000000000000, '2024-02-09 05:31:07', NULL, 1),
(46, '12356', 0x3a3a3100000000000000000000000000, '2024-02-14 16:58:14', '14-02-2024 10:29:33 PM', 1),
(47, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-14 16:59:51', '14-02-2024 10:35:46 PM', 1),
(48, '12356', 0x3a3a3100000000000000000000000000, '2024-02-15 05:43:26', '15-02-2024 11:13:56 AM', 1),
(49, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-15 05:44:17', NULL, 1),
(50, '22MCMI22', 0x3a3a3100000000000000000000000000, '2024-02-22 05:58:35', '22-02-2024 11:36:48 AM', 1),
(51, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-22 06:07:11', '22-02-2024 12:24:33 PM', 1),
(52, '23MCCS21', 0x3a3a3100000000000000000000000000, '2024-02-22 06:55:39', '22-02-2024 12:35:57 PM', 1),
(53, '12356', 0x3a3a3100000000000000000000000000, '2024-02-22 07:06:09', NULL, 1),
(54, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-23 08:37:19', '23-02-2024 02:14:15 PM', 1),
(55, '21MTAI10', 0x3a3a3100000000000000000000000000, '2024-02-23 08:44:35', '23-02-2024 02:47:37 PM', 1),
(56, '21MTAI10', 0x3a3a3100000000000000000000000000, '2024-02-23 09:17:55', NULL, 1),
(57, '20IMTC09', 0x3a3a3100000000000000000000000000, '2024-02-23 09:27:36', '23-02-2024 02:58:57 PM', 1),
(58, '21IMCS18', 0x3a3a3100000000000000000000000000, '2024-02-23 09:34:01', NULL, 1),
(59, '21IMCS18', 0x3a3a3100000000000000000000000000, '2024-02-23 09:37:09', '23-02-2024 03:46:53 PM', 1),
(60, '20IMTC09', 0x3a3a3100000000000000000000000000, '2024-02-23 10:17:12', NULL, 1),
(61, '12356', 0x3a3a3100000000000000000000000000, '2024-02-26 07:03:33', NULL, 1),
(62, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-28 10:49:30', NULL, 1),
(63, '12356', 0x3a3a3100000000000000000000000000, '2024-02-29 06:24:00', '29-02-2024 12:04:18 PM', 1),
(64, '22MCMC19', 0x3a3a3100000000000000000000000000, '2024-02-29 07:11:34', '29-02-2024 12:52:03 PM', 1),
(65, '22MCMC19', 0x3a3a3100000000000000000000000000, '2024-02-29 09:18:30', NULL, 1),
(66, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-29 18:38:46', NULL, 1),
(67, '22MCMI12', 0x3a3a3100000000000000000000000000, '2024-02-29 19:12:38', '01-03-2024 01:17:31 AM', 1),
(68, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-02-29 19:48:27', '01-03-2024 01:19:03 AM', 1),
(69, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-02-29 19:49:15', '01-03-2024 01:22:08 AM', 1),
(70, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-02-29 19:52:28', '01-03-2024 01:26:38 AM', 1),
(71, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-02-29 19:56:52', '01-03-2024 01:31:42 AM', 1),
(72, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-02-29 20:01:54', NULL, 1),
(73, '22MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-01 07:28:55', NULL, 1),
(74, '22MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-01 07:53:51', '01-03-2024 02:46:51 PM', 1),
(75, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-01 09:17:13', '01-03-2024 02:47:44 PM', 1),
(76, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-01 09:19:34', '01-03-2024 03:04:12 PM', 1),
(77, '20MCME09', 0x3a3a3100000000000000000000000000, '2024-03-01 09:34:29', '01-03-2024 03:15:16 PM', 1),
(78, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-01 09:46:47', '01-03-2024 03:20:17 PM', 1),
(79, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-01 09:50:39', '01-03-2024 03:54:15 PM', 1),
(80, '22MCMC19', 0x3a3a3100000000000000000000000000, '2024-03-01 10:24:43', '01-03-2024 03:56:12 PM', 1),
(81, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-01 10:26:26', NULL, 1),
(82, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-01 18:31:07', '02-03-2024 12:57:09 AM', 1),
(83, '20MCME09', 0x3a3a3100000000000000000000000000, '2024-03-01 19:27:23', NULL, 1),
(84, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-04 05:56:49', '04-03-2024 11:33:05 AM', 1),
(85, '22MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-04 06:03:49', '04-03-2024 11:34:31 AM', 1),
(86, '21MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-04 06:04:52', '04-03-2024 11:35:30 AM', 1),
(87, '21mcme18', 0x3a3a3100000000000000000000000000, '2024-03-04 06:06:09', '04-03-2024 11:43:05 AM', 1),
(88, '21MCMC17', 0x3a3a3100000000000000000000000000, '2024-03-04 06:42:18', '04-03-2024 12:24:02 PM', 1),
(89, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-04 09:42:45', '04-03-2024 03:16:10 PM', 1),
(90, '22MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-04 09:46:50', '04-03-2024 03:17:39 PM', 1),
(91, '20MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 10:28:54', '07-03-2024 04:03:27 PM', 1),
(92, '22MTIT14', 0x3a3a3100000000000000000000000000, '2024-03-07 10:33:43', NULL, 1),
(93, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:08:17', '07-03-2024 10:39:34 PM', 1),
(94, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:10:49', '07-03-2024 10:41:24 PM', 1),
(95, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:14:59', '07-03-2024 10:46:48 PM', 1),
(96, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 17:17:51', '07-03-2024 10:50:33 PM', 1),
(97, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:20:41', '07-03-2024 10:51:09 PM', 1),
(98, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 17:21:18', '07-03-2024 10:51:51 PM', 1),
(99, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:22:03', '07-03-2024 10:52:43 PM', 1),
(100, '23MTIT13', 0x3a3a3100000000000000000000000000, '2024-03-07 17:23:52', '07-03-2024 10:54:11 PM', 1),
(101, '22MCME18', 0x3a3a3100000000000000000000000000, '2024-03-07 17:24:47', '07-03-2024 10:56:30 PM', 1),
(102, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-07 17:27:24', '07-03-2024 11:04:39 PM', 1),
(103, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:34:46', '07-03-2024 11:17:31 PM', 1),
(104, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:48:03', NULL, 1),
(105, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:55:27', '07-03-2024 11:29:06 PM', 1),
(106, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 17:59:18', '07-03-2024 11:29:59 PM', 1),
(107, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 18:00:10', '07-03-2024 11:33:58 PM', 1),
(108, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:04:10', '07-03-2024 11:34:50 PM', 1),
(109, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:04:59', '07-03-2024 11:47:15 PM', 1),
(110, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:17:24', '07-03-2024 11:47:43 PM', 1),
(111, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 18:17:54', '07-03-2024 11:49:54 PM', 1),
(112, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:20:52', '07-03-2024 11:51:12 PM', 1),
(113, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 18:21:21', NULL, 1),
(114, '22mcmc16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:27:08', '07-03-2024 11:57:30 PM', 1),
(115, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 18:27:37', '08-03-2024 12:06:40 AM', 1),
(116, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 18:37:05', '08-03-2024 12:07:22 AM', 1),
(117, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-07 18:37:30', '08-03-2024 12:19:42 AM', 1),
(118, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 18:50:41', NULL, 1),
(119, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-07 18:52:20', '08-03-2024 12:26:34 AM', 1),
(120, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 18:57:02', '08-03-2024 12:27:37 AM', 1),
(121, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 18:57:58', '08-03-2024 12:29:00 AM', 1),
(122, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-07 18:59:51', '08-03-2024 12:32:09 AM', 1),
(123, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:02:35', '08-03-2024 12:33:23 AM', 1),
(124, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:03:36', '08-03-2024 12:33:46 AM', 1),
(125, '23MCMI22', 0x3a3a3100000000000000000000000000, '2024-03-07 19:04:33', '08-03-2024 12:35:05 AM', 1),
(126, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:05:17', NULL, 1),
(127, '19MCME13', 0x3a3a3100000000000000000000000000, '2024-03-07 19:09:17', '08-03-2024 12:40:03 AM', 1),
(128, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 19:10:18', '08-03-2024 12:43:36 AM', 1),
(129, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:13:49', '08-03-2024 12:44:04 AM', 1),
(130, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:14:16', '08-03-2024 12:51:03 AM', 1),
(131, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:21:13', '08-03-2024 12:51:24 AM', 1),
(132, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 19:21:32', '08-03-2024 12:55:05 AM', 1),
(133, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 19:25:23', '08-03-2024 01:02:47 AM', 1),
(134, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:32:58', '08-03-2024 01:05:50 AM', 1),
(135, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:36:02', '08-03-2024 01:13:54 AM', 1),
(136, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-07 19:44:06', '08-03-2024 01:14:41 AM', 1),
(137, '21MCME09', 0x3a3a3100000000000000000000000000, '2024-03-07 19:44:54', NULL, 1),
(138, '19MCME13', 0x3a3a3100000000000000000000000000, '2024-03-08 06:07:14', '08-03-2024 11:37:39 AM', 1),
(139, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 06:23:33', NULL, 1),
(140, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 06:29:20', '08-03-2024 11:59:54 AM', 1),
(141, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-08 06:30:10', '08-03-2024 12:11:45 PM', 1),
(142, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 06:41:56', '08-03-2024 12:21:54 PM', 1),
(143, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-08 06:52:06', '08-03-2024 12:22:17 PM', 1),
(144, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 06:52:27', '08-03-2024 01:04:01 PM', 1),
(145, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-08 07:34:11', '08-03-2024 01:04:36 PM', 1),
(146, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 07:34:45', '08-03-2024 01:07:54 PM', 1),
(147, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-08 07:38:04', NULL, 1),
(148, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 07:39:18', '08-03-2024 01:15:36 PM', 1),
(149, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-08 07:45:47', '08-03-2024 01:20:02 PM', 1),
(150, '23MCMI12', 0x3a3a3100000000000000000000000000, '2024-03-08 07:50:10', NULL, 1),
(151, '21MCMB05', 0x3a3a3100000000000000000000000000, '2024-03-09 11:30:51', '09-03-2024 05:01:12 PM', 1),
(152, '21MCMB01', 0x3a3a3100000000000000000000000000, '2024-03-09 11:31:31', '09-03-2024 05:01:54 PM', 1),
(153, '21MCMB03', 0x3a3a3100000000000000000000000000, '2024-03-09 11:32:13', '09-03-2024 05:02:49 PM', 1),
(154, '21MCMB08', 0x3a3a3100000000000000000000000000, '2024-03-09 11:33:00', '09-03-2024 05:03:22 PM', 1),
(155, '21MCMB04', 0x3a3a3100000000000000000000000000, '2024-03-09 11:37:08', '09-03-2024 05:08:15 PM', 1),
(156, '21MCMB06', 0x3a3a3100000000000000000000000000, '2024-03-09 11:38:43', '09-03-2024 05:08:56 PM', 1),
(157, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-09 11:39:17', '09-03-2024 05:09:32 PM', 1),
(158, '21MCMI01', 0x3a3a3100000000000000000000000000, '2024-03-13 16:15:02', NULL, 1),
(159, '21MCMI02', 0x3a3a3100000000000000000000000000, '2024-03-13 16:21:59', '13-03-2024 09:55:18 PM', 1),
(160, '21MCMI03', 0x3a3a3100000000000000000000000000, '2024-03-13 16:25:48', NULL, 1),
(161, '21MCMI04', 0x3a3a3100000000000000000000000000, '2024-03-13 16:29:02', NULL, 1),
(162, '21MCMI05', 0x3a3a3100000000000000000000000000, '2024-03-13 16:34:50', NULL, 1),
(163, '21MCMI06', 0x3a3a3100000000000000000000000000, '2024-03-13 16:35:23', NULL, 1),
(164, '21MCMI07', 0x3a3a3100000000000000000000000000, '2024-03-13 16:35:55', NULL, 1),
(165, '21MCMI08', 0x3a3a3100000000000000000000000000, '2024-03-13 16:36:23', NULL, 1),
(166, '21MCMI09', 0x3a3a3100000000000000000000000000, '2024-03-13 16:36:41', NULL, 1),
(167, '21MCMI10', 0x3a3a3100000000000000000000000000, '2024-03-13 16:41:32', NULL, 1),
(168, '21MCMI11', 0x3a3a3100000000000000000000000000, '2024-03-13 16:41:52', NULL, 1),
(169, '21MCMI14', 0x3a3a3100000000000000000000000000, '2024-03-13 16:42:30', NULL, 1),
(170, '21MCMI15', 0x3a3a3100000000000000000000000000, '2024-03-13 16:43:01', NULL, 1),
(171, '21MCMI16', 0x3a3a3100000000000000000000000000, '2024-03-13 16:43:21', NULL, 1),
(172, '21MCMI18', 0x3a3a3100000000000000000000000000, '2024-03-13 16:43:44', NULL, 1),
(173, '21MCMI20', 0x3a3a3100000000000000000000000000, '2024-03-13 16:44:14', NULL, 1),
(174, '21MCMI21', 0x3a3a3100000000000000000000000000, '2024-03-13 16:44:45', NULL, 1),
(175, '21MCMI22', 0x3a3a3100000000000000000000000000, '2024-03-13 16:45:13', NULL, 1),
(176, '21MCMI23', 0x3a3a3100000000000000000000000000, '2024-03-13 16:45:33', NULL, 1),
(177, '21MCMI25', 0x3a3a3100000000000000000000000000, '2024-03-13 16:45:51', '13-03-2024 10:17:09 PM', 1),
(178, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-14 07:14:41', '14-03-2024 12:51:24 PM', 1),
(179, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-14 07:25:14', NULL, 1),
(180, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-14 16:41:32', '15-03-2024 12:32:13 AM', 1),
(181, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-14 19:08:47', '15-03-2024 12:39:27 AM', 1),
(182, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-14 19:13:54', NULL, 1),
(183, '21MCMB01', 0x3a3a3100000000000000000000000000, '2024-03-15 07:21:35', '15-03-2024 12:57:02 PM', 1),
(184, '21MCMB01', 0x3a3a3100000000000000000000000000, '2024-03-15 07:42:58', NULL, 1),
(185, '21MCMB03', 0x3a3a3100000000000000000000000000, '2024-03-15 07:48:47', NULL, 1),
(186, '21MCMB04', 0x3a3a3100000000000000000000000000, '2024-03-15 07:51:20', NULL, 1),
(187, '21MCMB05', 0x3a3a3100000000000000000000000000, '2024-03-15 07:53:05', NULL, 1),
(188, '21MCMB06', 0x3a3a3100000000000000000000000000, '2024-03-15 07:55:15', NULL, 1),
(189, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-15 07:56:58', NULL, 1),
(190, '21MCMB08', 0x3a3a3100000000000000000000000000, '2024-03-15 07:58:33', NULL, 1),
(191, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-03-16 12:01:26', '16-03-2024 05:32:42 PM', 1),
(192, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-20 09:36:15', NULL, 1),
(193, '21MCMB08', 0x3a3a3100000000000000000000000000, '2024-03-20 19:32:20', NULL, 1),
(194, '21MCMB07', 0x3a3a3100000000000000000000000000, '2024-03-21 05:18:41', NULL, 1),
(195, '21MCMB04', 0x3a3a3100000000000000000000000000, '2024-03-21 18:18:16', '22-03-2024 12:02:58 AM', 1),
(196, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-03-21 18:33:14', '22-03-2024 12:20:39 AM', 1),
(197, '21MCMB04', 0x3a3a3100000000000000000000000000, '2024-03-21 18:50:56', '22-03-2024 12:24:33 AM', 1),
(198, '22MCMC19', 0x3a3a3100000000000000000000000000, '2024-03-23 09:57:32', '23-03-2024 03:30:16 PM', 1),
(199, '22MCMC18', 0x3a3a3100000000000000000000000000, '2024-03-26 18:51:56', NULL, 1),
(200, '23MCMT09', 0x3a3a3100000000000000000000000000, '2024-04-01 17:22:59', NULL, 1),
(201, '22mcmc16', 0x3a3a3100000000000000000000000000, '2024-04-20 18:50:28', '21-04-2024 12:28:05 AM', 1),
(202, '21MCMI01', 0x3a3a3100000000000000000000000000, '2024-04-20 19:16:08', NULL, 1),
(203, '23MCMT09', 0x3a3a3100000000000000000000000000, '2024-04-21 12:17:53', '21-04-2024 05:54:45 PM', 1),
(204, '22MCMC04', 0x3a3a3100000000000000000000000000, '2024-04-21 12:24:56', NULL, 1),
(205, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-04-21 12:30:14', '21-04-2024 06:00:28 PM', 1),
(206, '23MCMT09', 0x3a3a3100000000000000000000000000, '2024-04-21 12:30:33', '21-04-2024 06:09:58 PM', 1),
(207, '23MCMT10', 0x3a3a3100000000000000000000000000, '2024-04-22 03:50:23', '22-04-2024 10:32:27 AM', 1),
(208, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-04-22 05:57:19', '22-04-2024 11:28:13 AM', 1),
(209, '21MCMI01', 0x3a3a3100000000000000000000000000, '2024-04-22 05:58:27', NULL, 1),
(210, '22MCMC16', 0x3a3a3100000000000000000000000000, '2024-05-09 07:21:40', '09-05-2024 03:36:28 PM', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_code`);

--
-- Indexes for table `courseenrolls`
--
ALTER TABLE `courseenrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_code`);

--
-- Indexes for table `courses_allocated`
--
ALTER TABLE `courses_allocated`
  ADD PRIMARY KEY (`courses_allocated_id`),
  ADD KEY `student_reg_no` (`student_reg_no`),
  ADD KEY `course_code` (`courseName`);

--
-- Indexes for table `courses_allocated1`
--
ALTER TABLE `courses_allocated1`
  ADD PRIMARY KEY (`courses_allocated_id`),
  ADD KEY `student_reg_no` (`student_reg_no`),
  ADD KEY `course_code` (`courseName`);

--
-- Indexes for table `courses_allocated2`
--
ALTER TABLE `courses_allocated2`
  ADD PRIMARY KEY (`courses_allocated_id`),
  ADD KEY `student_reg_no` (`student_reg_no`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elective_preference`
--
ALTER TABLE `elective_preference`
  ADD PRIMARY KEY (`elective_preference_id`);

--
-- Indexes for table `elective_preference1`
--
ALTER TABLE `elective_preference1`
  ADD PRIMARY KEY (`elective_preference_id`);

--
-- Indexes for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Indexes for table `eligible_optional_core1`
--
ALTER TABLE `eligible_optional_core1`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `set_oc_electives`
--
ALTER TABLE `set_oc_electives`
  ADD PRIMARY KEY (`stream_id`);

--
-- Indexes for table `stream`
--
ALTER TABLE `stream`
  ADD PRIMARY KEY (`stream_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentRegno`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Indexes for table `students1`
--
ALTER TABLE `students1`
  ADD PRIMARY KEY (`studentRegno`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Indexes for table `userlog`
--
ALTER TABLE `userlog`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courseenrolls`
--
ALTER TABLE `courseenrolls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `courses_allocated`
--
ALTER TABLE `courses_allocated`
  MODIFY `courses_allocated_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1115;

--
-- AUTO_INCREMENT for table `courses_allocated1`
--
ALTER TABLE `courses_allocated1`
  MODIFY `courses_allocated_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `courses_allocated2`
--
ALTER TABLE `courses_allocated2`
  MODIFY `courses_allocated_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `elective_preference`
--
ALTER TABLE `elective_preference`
  MODIFY `elective_preference_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `elective_preference1`
--
ALTER TABLE `elective_preference1`
  MODIFY `elective_preference_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `eligible_optional_core1`
--
ALTER TABLE `eligible_optional_core1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `semester`
--
ALTER TABLE `semester`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stream`
--
ALTER TABLE `stream`
  MODIFY `stream_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `userlog`
--
ALTER TABLE `userlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `eligible_optional_core`
--
ALTER TABLE `eligible_optional_core`
  ADD CONSTRAINT `eligible_optional_core_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`),
  ADD CONSTRAINT `eligible_optional_core_ibfk_2` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);

--
-- Constraints for table `eligible_optional_core1`
--
ALTER TABLE `eligible_optional_core1`
  ADD CONSTRAINT `eligible_optional_core1_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`),
  ADD CONSTRAINT `eligible_optional_core1_ibfk_2` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);

--
-- Constraints for table `students1`
--
ALTER TABLE `students1`
  ADD CONSTRAINT `students1_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
