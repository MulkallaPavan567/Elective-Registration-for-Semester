-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Jan 19, 2022 at 03:38 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `onlinecourse`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses_allocated`
--

CREATE TABLE `courses_allocated` (
  `courses_allocated_id` int(11) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  `student_reg_no` varchar(50) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `allocation_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses_allocated`
--
ALTER TABLE `courses_allocated`
  ADD PRIMARY KEY (`courses_allocated_id`),
  ADD KEY `student_reg_no` (`student_reg_no`),
  ADD KEY `course_code` (`course_code`);
  ADD KEY `course_name` (`course_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses_allocated`
--
ALTER TABLE `courses_allocated`
  MODIFY `courses_allocated_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
