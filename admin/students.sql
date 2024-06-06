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
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentRegno`, `stream_id`, `studentPhoto`, `password`, `studentName`, `course_name`, `pincode`, `session`, `department`, `semester`, `cgpa`, `courses_allocated_id`, `enrolment_status`, `optional_core_choice_1`, `optional_core_choice_2`, `optional_core_choice_3`, `optional_core_choice_4`, `optional_core_choice_5`, `password_status`, `creationdate`, `updationDate`) VALUES
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
('21MCMI01', 3, '', 'Team@123', 'Ravi Teja Gundimeda', 'MTECH_AI', NULL, NULL, NULL, NULL, 392.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI02', 3, '', 'Team@123', 'Gorla Vivek Yadav', 'MTECH_AI', NULL, NULL, NULL, NULL, 464.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI03', 3, '', 'Team@123', 'Mahitha Kodali', 'MTECH_AI', NULL, NULL, NULL, NULL, 308.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI04', 3, '', 'Team@123', 'Yashwanth Marrapu', 'MTECH_AI', NULL, NULL, NULL, NULL, 363.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI05', 3, '', 'Team@123', 'Ch Saiman Naidu', 'MTECH_AI', NULL, NULL, NULL, NULL, 548.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI06', 3, '', 'Team@123', 'Pramod Kumar Dwivedi', 'MTECH_AI', NULL, NULL, NULL, NULL, 415.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI07', 3, '', 'Team@123', 'Jagjeet Suryawanshi', 'MTECH_AI', NULL, NULL, NULL, NULL, 321.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI08', 3, '', 'Team@123', 'SAYAN DAS', 'MTECH_AI', NULL, NULL, NULL, NULL, 469.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI09', 3, '', 'Team@123', 'Sai Sanjana Madaram', 'MTECH_AI', NULL, NULL, NULL, NULL, 481.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI10', 3, '', 'Team@123', 'Manzoor Murtaza', 'MTECH_AI', NULL, NULL, NULL, NULL, 285.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI11', 3, '', 'Team@123', 'AMARJEET KUMAR', 'MTECH_AI', NULL, NULL, NULL, NULL, 370.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI14', 3, '', 'Team@123', 'Rajesh Thalla', 'MTECH_AI', NULL, NULL, NULL, NULL, 562.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI15', 3, '', 'Team@123', 'Kayala Jeevan Prakash', 'MTECH_AI', NULL, NULL, NULL, NULL, 397.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI16', 3, '', 'Team@123', 'R P Yashasvi', 'MTECH_AI', NULL, NULL, NULL, NULL, 608.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI18', 3, '', 'Team@123', 'Dipyaman Mukhopadhyay', 'MTECH_AI', NULL, NULL, NULL, NULL, 606.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI20', 3, '', 'Team@123', 'Drishty gupta', 'MTECH_AI', NULL, NULL, NULL, NULL, 548.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI21', 3, '', 'Team@123', 'KRISHNA CHANDRA YADAV', 'MTECH_AI', NULL, NULL, NULL, NULL, 459.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI22', 3, '', 'Team@123', 'Vikas Koleti', 'MTECH_AI', NULL, NULL, NULL, NULL, 408.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI23', 3, '', 'Team@123', 'M Pranayraj', 'MTECH_AI', NULL, NULL, NULL, NULL, 437.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('21MCMI25', 3, '', 'Team@123', 'Pralhad Kolambkar', 'MTECH_AI', NULL, NULL, NULL, NULL, 565.00, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-13 06:54:10', NULL),
('22MCMC16', 1, NULL, '12345', 'Pavan', 'MCA', '930514', NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 18:20:24', NULL),
('22MCME18', 5, NULL, 'Team@123', 'Suman', 'IMTECH_3-4', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 17:00:48', NULL),
('23MCMI12', 2, '', '12345', 'Ayushi', 'MTECH_AI', NULL, NULL, NULL, NULL, 393.00, 0, 0, 'ACN', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MCMI22', 2, '', 'Team@123', 'Vernika', 'MTECH_AI', NULL, NULL, NULL, NULL, 600.00, 0, 0, 'Network Security', 'System Security', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MCMT10', 3, NULL, 'Team@123', 'Putin', 'MTECH_CS', NULL, NULL, NULL, NULL, NULL, 0, 0, 'Advance Algo', 'Machine Learning', 'NULL', 'NULL', 'NULL', 0, '2024-03-07 17:00:48', NULL),
('23MTIT13', 4, NULL, 'Team@123', 'Thiru', 'MTECH_IT', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-03-07 17:00:48', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentRegno`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `stream` (`stream_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
