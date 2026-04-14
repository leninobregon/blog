-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-04-2026 a las 00:56:58
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `blog_tutoriales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `about`
--

CREATE TABLE `about` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT 'Acerca de Mí',
  `subtitle` varchar(255) DEFAULT 'Ingeniero en Computación',
  `description` text DEFAULT NULL,
  `experience` text DEFAULT NULL,
  `goals` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `telegram_url` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `about`
--

INSERT INTO `about` (`id`, `title`, `subtitle`, `description`, `experience`, `goals`, `photo`, `youtube_url`, `facebook_url`, `twitter_url`, `telegram_url`, `email`, `updated_at`) VALUES
(1, 'Acerca de Mí', 'Ingeniero en Computación', 'Lenin Obregón Espinoza es Ingeniero en Computación de nacionalidad Nicaragüense de la tierra de lagos y volcanes montañas con pinares. Este canal es para mi memoria de aprendizaje y está orientado para aquellas personas que están iniciando el aprendizaje de infraestructuras, tengo mucha experiencia en el campo de Networking, Administración de Servidores en Entornos Linux y Windows, Monitoreo de Equipos de Comunicación entre otros.', 'Networking|Administración de Servidores en Entornos Linux y Windows|Monitoreo de Equipos de Comunicación', 'Promover el uso de tecnologías de información|Software libre|Área de Campus Networking|Ayudar a iniciados en el mundo IT', 'uploads/69cd89a19b22d.jpg', 'https://www.youtube.com/@leninobregonespinoza2160', '', '', '', 'lenin@ejemplo.com', '2026-04-01 15:09:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `page` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `action`, `user_id`, `username`, `ip_address`, `user_agent`, `page`, `details`, `created_at`) VALUES
(1, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 14:23:14'),
(2, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 14:53:38'),
(3, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:04:28'),
(4, 'login_failed', NULL, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Failed login attempt', '2026-04-07 15:07:03'),
(5, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:07:09'),
(6, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:10:05'),
(7, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-07 15:10:27'),
(9, 'user_login', 2, 'juanperez', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-07 15:11:15'),
(10, 'login_failed', NULL, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Failed login attempt', '2026-04-07 15:22:54'),
(11, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:23:00'),
(12, 'user_logout', NULL, 'unknown', '::1', 'curl/8.18.0', 'auth.php', 'User logged out', '2026-04-07 15:31:53'),
(13, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-07 15:33:05'),
(14, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-07 15:33:14'),
(15, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'auth.php', 'User logged in successfully', '2026-04-07 15:33:50'),
(16, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'auth.php', 'User logged out', '2026-04-07 15:36:55'),
(17, 'user_login', 2, 'juanperez', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'auth.php', 'User logged in successfully', '2026-04-07 15:37:11'),
(18, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'auth.php', 'User logged in successfully', '2026-04-07 15:38:32'),
(19, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'auth.php', 'User logged out', '2026-04-07 15:38:57'),
(20, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:39:06'),
(21, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'admin/login.php', 'Admin logged in successfully', '2026-04-07 15:44:10'),
(22, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-08 09:05:16'),
(23, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 09:12:03'),
(24, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-08 09:12:34'),
(25, 'user_login', 2, 'juanperez', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 09:12:47'),
(26, 'admin_login', 1, 'admin', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-08 14:14:08'),
(27, 'admin_login', 1, 'admin', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-08 14:28:52'),
(28, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 14:32:56'),
(29, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'auth.php', 'User logged out', '2026-04-08 14:33:09'),
(30, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-08 16:36:04'),
(31, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 16:36:12'),
(32, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-08 16:36:42'),
(33, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-08 16:47:48'),
(34, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 16:47:54'),
(35, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-08 16:48:01'),
(36, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-08 16:56:19'),
(37, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'auth.php', 'User logged out', '2026-04-08 17:02:41'),
(38, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 07:33:32'),
(39, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 07:33:39'),
(40, 'login_failed', NULL, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 16:27:17'),
(41, 'login_failed', NULL, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 16:27:24'),
(42, 'login_failed', NULL, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 16:27:31'),
(43, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-09 16:27:41'),
(44, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-09 16:27:51'),
(45, 'admin_login', 1, 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-09 16:28:02'),
(46, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-09 16:29:36'),
(47, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-09 16:30:25'),
(48, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 16:32:32'),
(49, 'login_failed', NULL, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'Failed login attempt', '2026-04-09 16:32:38'),
(50, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-09 16:32:45'),
(51, 'user_login', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-09 16:50:14'),
(52, 'user_logout', 6, 'aobregon', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-09 16:50:18'),
(53, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-09 16:50:29'),
(54, 'user_login', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged in successfully', '2026-04-09 16:50:40'),
(55, 'user_logout', 6, 'aobregon', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'auth.php', 'User logged out', '2026-04-09 16:52:48'),
(56, 'admin_login', 1, 'admin', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/login.php', 'Admin logged in successfully', '2026-04-09 16:53:54'),
(57, 'user_delete', 3, 'maria-dev', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/users.php', 'Deleted user: maria-dev', '2026-04-09 16:54:06'),
(58, 'user_delete', 5, 'pepe123', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/users.php', 'Deleted user: pepe123', '2026-04-09 16:54:10'),
(59, 'user_update', 1, 'admin', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'admin/users.php', 'Updated user: admin (ID: 1)', '2026-04-09 16:54:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `content`, `created_at`) VALUES
(1, 11, 6, 'gracias', '2026-04-07 15:36:47'),
(2, 12, 6, 'muchas, gracias por el post, esta interesante', '2026-04-07 15:38:54'),
(3, 12, 6, 'bien', '2026-04-08 09:12:16'),
(4, 3, 6, 'ok', '2026-04-09 16:27:49'),
(5, 12, 6, 'ok', '2026-04-09 16:29:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `newsletter`
--

CREATE TABLE `newsletter` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `token` varchar(100) DEFAULT NULL,
  `last_sent` datetime DEFAULT NULL,
  `total_sent` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `newsletter`
--

INSERT INTO `newsletter` (`id`, `email`, `name`, `active`, `token`, `last_sent`, `total_sent`, `created_at`) VALUES
(7, 'lenin.obregon832025@gmail.com', 'Lenin', 1, NULL, NULL, 0, '2026-04-08 09:12:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`id`, `title`, `category`, `content`, `image`, `video`, `author_id`, `views`, `created_at`) VALUES
(1, 'Bienvenido al Blog', 'General', '# Bienvenido\n\nEste es un blog de tutoriales sobre programación, Linux y seguridad.', NULL, NULL, 1, 6, '2026-04-01 15:07:39'),
(2, 'Introducción a Linux', 'Linux', '# Introducción a Linux\n\nLinux es un sistema operativo de código abierto.\n\n## Distribuciones\n- Ubuntu\n- Debian\n\n```bash\nls -la\ncd /home\n```', NULL, NULL, 1, 3, '2026-04-01 15:07:39'),
(3, 'Tutorial de Python', 'Programación', '# Tutorial de Python\n\n```python\nnombre = \"Juan\"\nedad = 25\n```', NULL, NULL, 2, 2, '2026-04-01 15:07:39'),
(4, 'Configurar SSH', 'Linux', '# Configurar SSH\r\n\r\n```bash\r\nsudo apt update\r\nsudo apt install openssh-server\r\nsudo systemctl start ssh\r\nsudo systemctl enable ssh\r\n```\r\n\r\n## Conectar\r\n```bash\r\nssh usuario@servidor\r\n```', NULL, 'https://www.youtube.com/watch?v=c0HtiBbVsFQ', 1, 12, '2026-04-01 15:07:39'),
(5, 'Comandos Servidor', 'Linux', '# Comandos básicos servidor\n\n## Archivos\n```bash\nls -la\ncd /home\nmkdir carpeta\nrm archivo\ncp origen destino\nmv origen destino\n```\n\n## Paquetes\n```bash\nsudo apt update\nsudo apt upgrade\nsudo apt install nombre\n```\n\n## Servicios\n```bash\nsudo systemctl status nginx\nsudo systemctl start nginx\nsudo systemctl stop nginx\nsudo systemctl restart nginx\n```\n\n## Usuarios\n```bash\nsudo adduser nombre\nsudo usermod -aG sudo nombre\n```', NULL, NULL, 1, 2, '2026-04-01 15:07:39'),
(6, 'LAMP Debian/Ubuntu', 'Linux', '# LAMP Server\n\nLAMP = Linux + Apache + MySQL + PHP\n\n```bash\n# Apache\nsudo apt install apache2 -y\n\n# MySQL\nsudo apt install mariadb-server -y\nsudo mysql_secure_installation\n\n# PHP\nsudo apt install php libapache2-mod-php php-mysql -y\n\n# Verificar\necho \"<?php phpinfo(); ?>\" | sudo tee /var/www/html/info.php\n```', NULL, NULL, 1, 1, '2026-04-01 15:07:39'),
(7, 'Firewall UFW', 'Linux', '# Firewall UFW\n\n```bash\n# Instalar\nsudo apt install ufw\n\n# Reglas\nsudo ufw allow ssh\nsudo ufw allow 80/tcp\nsudo ufw allow 443/tcp\n\n# Habilitar\nsudo ufw enable\n\n# Ver estado\nsudo ufw status\n```\n\n## Otras reglas\n```bash\nsudo ufw allow 22/tcp\nsudo ufw allow 3306/tcp  # MySQL\nsudo ufw allow 8080/tcp\n```', NULL, NULL, 1, 0, '2026-04-01 15:07:39'),
(8, 'Servidor NFS', 'Linux', '# Servidor NFS\n\nNFS permite compartir archivos entre servidores.\n\n## Servidor\n```bash\nsudo apt install nfs-kernel-server\nsudo mkdir -p /var/nfs/compartido\nsudo chmod 777 /var/nfs/compartido\n\n# Editar /etc/exports\n/var/nfs/compartido 192.168.1.0/24(rw,sync,no_subtree_check)\n\nsudo exportfs -a\nsudo systemctl restart nfs-kernel-server\n```\n\n## Cliente\n```bash\nsudo apt install nfs-common\nsudo mkdir -p /mnt/nfs\nsudo mount 192.168.1.100:/var/nfs/compartido /mnt/nfs\n```', NULL, NULL, 1, 1, '2026-04-01 15:07:39'),
(9, 'Nginx Reverse Proxy', 'Linux', '# Nginx como Proxy Inverso\n\n```bash\nsudo apt install nginx\n```\n\n## Configurar\n```nginx\nserver {\n    listen 80;\n    server_name mi-dominio.com;\n    \n    location / {\n        proxy_pass http://127.0.0.1:3000;\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n    }\n}\n```\n\n## Activar\n```bash\nsudo ln -s /etc/nginx/sites-available/mi-dominio /etc/nginx/sites-enabled/\nsudo nginx -t\nsudo systemctl reload nginx\n```', NULL, NULL, 1, 0, '2026-04-01 15:07:39'),
(10, 'Usuario Sudo', 'Linux', '# Crear Usuario Sudo\n\n```bash\n# Crear usuario\nsudo adduser nombre_usuario\n\n# Agregar a grupo sudo\nsudo usermod -aG sudo nombre_usuario\n\n# Verificar\nsu - nombre_usuario\nsudo whoami\n# Debe mostrar: root\n```\n\n## Editar sudoers\n```bash\nsudo visudo\n# Agregar:\nnombre_usuario ALL=(ALL:ALL) ALL\n```', NULL, NULL, 1, 1, '2026-04-01 15:07:39'),
(11, 'Redes Sociales', 'General', '*Las redes sociales son plataformas digitales que facilitan la comunicación, interacción y creación de comunidades en tiempo real. Permiten compartir información, fotos y videos, actuando como canales estratégicos para usuarios y empresas. Las más populares incluyen Facebook, YouTube, WhatsApp, Instagram y TikTok, evolucionando la comunicación hacia un entorno altamente dinámico e interconectado. \r\nCyberclick\r\nCyberclick\r\n +4\r\nTipos de Redes Sociales\r\nHorizontales: Generales, sin temática específica (ej. Facebook, Instagram).\r\nVerticales: Enfocadas a un público o tema concreto, ya sea profesional (LinkedIn), ocio, o contenido audiovisual (YouTube). \r\nRD Station\r\nRD Station\r\n \r\n\r\nPrincipales Ventajas y Desventajas\r\nVentajas: Inmediatez, democratización de la información, potencial alcance de exposición y oportunidades laborales.\r\nDesventajas: Riesgo de adicción, exposición a contenidos inapropiados, impacto negativo en la salud mental y ciberacoso. \r\nFacultad de Comunicación - Universidad ORT Uruguay\r\nFacultad de Comunicación - Universidad ORT Uruguay\r\n\r\n \r\nEvolución e Historia\r\nSurgieron a principios de los 2000 (ej. SixDegrees, Friendster) y vivieron un auge con la llegada de plataformas como YouTube (2005) y la consolidación de Facebook en 2008. Actualmente, muchas aplicaciones de mensajería (WhatsApp, Telegram) se consideran redes sociales por sus funcionalidades de comunidad y contenido compartido. \r\nCEI: Centro de Estudios de Innovación\r\nCEI: Centro de Estudios de Innovación\r\n\r\n *', NULL, '', 2, 70, '2026-04-01 15:18:38'),
(12, 'Inteligencía Artificial', 'General', 'a Inteligencia Artificial (IA) es un conjunto de tecnologías que permiten a las computadoras simular la inteligencia humana para aprender, razonar, resolver problemas y generar contenido. Abarca disciplinas como el aprendizaje automático (machine learning) y el procesamiento del lenguaje, automatizando tareas avanzadas para mejorar la eficiencia y la toma de decisiones. \r\nGoogle Cloud\r\nGoogle Cloud\r\n +2\r\nAquí hay información clave sobre la IA:\r\n¿Qué hace?: Los sistemas de IA pueden entender el lenguaje humano, reconocer imágenes, tomar decisiones, aprender de nuevas experiencias y crear contenidos originales (IA generativa).\r\nComponentes Fundamentales: Se basa en tres pilares: sistemas computacionales, grandes volúmenes de datos y algoritmos avanzados (código).\r\nAplicaciones Comunes: Incluye asistentes virtuales (como Alexa), motores de búsqueda, vehículos autónomos, reconocimiento facial y recomendaciones personalizadas en compras y entretenimiento.\r\nHistoria: El término fue acuñado en 1956 durante el Dartmouth Summer Research Project on Artificial Intelligence.\r\nRiesgos: La IA enfrenta desafíos como el sesgo en los datos, problemas de seguridad y la necesidad de proteger la privacidad de la información. \r\nIBM\r\nIBM\r\n +7\r\nLos principales beneficios de la IA incluyen la automatización de tareas repetitivas, el análisis predictivo para mejorar pronósticos y la capacidad de fomentar la innovación en áreas como la medicina, las finanzas y la manufactura.\r\n\r\nGracias', NULL, '', 2, 22, '2026-04-07 15:37:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `site_stats`
--

CREATE TABLE `site_stats` (
  `id` int(11) NOT NULL,
  `total_hits` int(11) DEFAULT 0,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `site_stats`
--

INSERT INTO `site_stats` (`id`, `total_hits`, `updated_at`) VALUES
(1, 570, '2026-04-09 16:53:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','author','user') DEFAULT 'user',
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `youtube` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `recovery_question` varchar(255) DEFAULT NULL,
  `recovery_answer` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `first_name`, `last_name`, `phone`, `avatar`, `bio`, `facebook`, `twitter`, `telegram`, `instagram`, `youtube`, `linkedin`, `website`, `recovery_question`, `recovery_answer`, `created_at`) VALUES
(1, 'admin', 'admin@blog.com', '$2y$10$t6XKqllOPjYFhibqpxVAq.7bDxUe.3Tf7neiQM0EQU9pbalTbnspy', 'admin', 'Admin', 'Principal', '+505 81996802', 'uploads/69cd97feb0466.jpg', 'Administrador del blog', '', '', '', '', 'www.youtube.com/@leninobregonespinoza2160', '', '', '¿Cuál es el nombre de tu primera mascota?', 'admin123', '2026-04-01 15:07:39'),
(2, 'juanperez', 'juan@email.com', '$2y$10$YYr6n0XSWU.DhUPZIzL2m.1yuyFVK1SYilaO7KaesX3bm4E5FbxFS', 'author', 'Juan', 'Perez', '+5912234567', NULL, 'Desarrollador web', '', '', '', '', '', '', '', '¿Cuál es tu ciudad natal?', 'lapaz', '2026-04-01 15:07:39'),
(4, 'carloslopez', 'carlos@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', 'Carlos', 'Lopez', '+5914234567', NULL, 'Sysadmin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '¿Cuál es el nombre de tu mejor amigo?', 'luis', '2026-04-01 15:07:39'),
(6, 'aobregon', 'aobregon@gmail.com', '$2y$10$QCUtMparyWPOGZ0.3CtU3eA3Pw9kvb7p7dKn1/AHRDLj0DhmcoYPK', 'user', 'Arian', 'Obregon', '+50598999999', 'uploads/69cd97d2df438.avif', '', '', '', '', '', '', '', '', '¿Cuál es el nombre de tu primera mascota?', 'chigui', '2026-04-01 16:05:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visit_logs`
--

CREATE TABLE `visit_logs` (
  `id` int(11) NOT NULL,
  `page` varchar(255) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `referer` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `visit_logs`
--

INSERT INTO `visit_logs` (`id`, `page`, `ip`, `user_agent`, `referer`, `created_at`) VALUES
(1, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/about.php', '2026-04-01 15:47:25'),
(2, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:47:29'),
(3, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:47:30'),
(4, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:47:34'),
(5, '/proyecto/blog_responsivo/about.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:47:39'),
(6, '/proyecto/blog_responsivo/about.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/about.php', '2026-04-01 15:47:42'),
(7, '/proyecto/blog_responsivo/about.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/about.php', '2026-04-01 15:47:47'),
(8, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/about.php', '2026-04-01 15:47:51'),
(9, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:47:52'),
(10, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-01 15:48:18'),
(11, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:42'),
(12, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:48'),
(13, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:49'),
(14, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:49'),
(15, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:49'),
(16, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:48:50'),
(17, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:49:18'),
(18, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-01 15:49:25'),
(19, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-01 15:49:58'),
(20, '/proyecto/blog_responsivo/index.php?mes=2026-04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:00'),
(21, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-01 15:50:03'),
(22, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-01 15:50:38'),
(23, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:41'),
(24, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:45'),
(25, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:46'),
(26, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:51'),
(27, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:50:53'),
(28, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:00'),
(29, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:02'),
(30, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:04'),
(31, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:06'),
(32, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:25'),
(33, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:29'),
(34, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:31'),
(35, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:51:33'),
(36, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:52:59'),
(37, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:53:55'),
(38, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:55:08'),
(39, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-01 15:55:23'),
(40, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:55:26'),
(41, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:55:33'),
(42, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:25'),
(43, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:29'),
(44, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:35'),
(45, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:44'),
(46, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:53'),
(47, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:55'),
(48, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:57'),
(49, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:56:59'),
(50, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:57:22'),
(51, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:57:31'),
(52, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:57:33'),
(53, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:48'),
(54, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:49'),
(55, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:49'),
(56, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:51'),
(57, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:54'),
(58, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:56'),
(59, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:57'),
(60, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:58'),
(61, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:58:59'),
(62, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:59:01'),
(63, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 15:59:02'),
(64, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:00:18'),
(65, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:20'),
(66, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:46'),
(67, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:47'),
(68, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:47'),
(69, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:48'),
(70, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:56'),
(71, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:57'),
(72, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:57'),
(73, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:57'),
(74, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:57'),
(75, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:57'),
(76, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:00:58'),
(77, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:09'),
(78, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:10'),
(79, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:11'),
(80, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:12'),
(81, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:12'),
(82, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:12'),
(83, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:12'),
(84, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:12'),
(85, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:13'),
(86, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:01:14'),
(87, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:30'),
(88, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:51'),
(89, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:52'),
(90, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:53'),
(91, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:53'),
(92, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(93, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(94, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(95, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(96, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(97, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:54'),
(98, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(99, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(100, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(101, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(102, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(103, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:55'),
(104, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:56'),
(105, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:56'),
(106, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:56'),
(107, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:56'),
(108, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:56'),
(109, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(110, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(111, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(112, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(113, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(114, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:57'),
(115, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(116, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(117, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(118, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(119, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(120, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:58'),
(121, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:59'),
(122, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:59'),
(123, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:59'),
(124, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:59'),
(125, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:01:59'),
(126, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:00'),
(127, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:00'),
(128, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:00'),
(129, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:00'),
(130, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:00'),
(131, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(132, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(133, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(134, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(135, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(136, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:01'),
(137, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:02'),
(138, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:02'),
(139, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:11'),
(140, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:11'),
(141, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:11'),
(142, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:02:12'),
(143, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:02:14'),
(144, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:18'),
(145, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:21'),
(146, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:21'),
(147, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:21'),
(148, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:49'),
(149, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:49'),
(150, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:50'),
(151, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:50'),
(152, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:50'),
(153, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:50'),
(154, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:50'),
(155, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:51'),
(156, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:51'),
(157, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:52'),
(158, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:52'),
(159, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:53'),
(160, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:53'),
(161, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:53'),
(162, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:02:54'),
(163, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:01'),
(164, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:26'),
(165, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:27'),
(166, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:29'),
(167, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:29'),
(168, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:29'),
(169, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:29'),
(170, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:30'),
(171, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:31'),
(172, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:31'),
(173, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:31'),
(174, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:31'),
(175, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:31'),
(176, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:32'),
(177, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:32'),
(178, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:32'),
(179, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:32'),
(180, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:32'),
(181, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:33'),
(182, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:33'),
(183, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:33'),
(184, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:03:33'),
(185, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:04:13'),
(186, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:04:40'),
(187, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/users.php', '2026-04-01 16:05:04'),
(188, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:05:57'),
(189, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:06:28'),
(190, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?', '2026-04-01 16:07:52'),
(191, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/users.php', '2026-04-01 16:08:48');
INSERT INTO `visit_logs` (`id`, `page`, `ip`, `user_agent`, `referer`, `created_at`) VALUES
(192, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:08:54'),
(193, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:09:04'),
(194, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/profile.php', '2026-04-01 16:10:28'),
(195, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/profile.php', '2026-04-01 16:10:31'),
(196, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:10:35'),
(197, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:11:21'),
(198, '/proyecto/blog_responsivo/about.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:11:25'),
(199, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/about.php', '2026-04-01 16:11:27'),
(200, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/users.php', '2026-04-01 16:15:00'),
(201, '/proyecto/blog_responsivo/post.php?id=11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:15:02'),
(202, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:15:16'),
(203, '/proyecto/blog_responsivo/index.php?cat=Programaci%C3%B3n', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:15:26'),
(204, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php?cat=Programaci%C3%B3n', '2026-04-01 16:15:28'),
(205, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:15:54'),
(206, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:16:26'),
(207, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?error=notfound', '2026-04-01 16:16:49'),
(208, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?error=notfound', '2026-04-01 16:17:00'),
(209, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?error=notfound', '2026-04-01 16:17:12'),
(210, '/proyecto/blog_responsivo/admin/db/auth.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/db/', '2026-04-01 16:24:17'),
(211, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-01 16:25:49'),
(212, '/proyecto/blog_responsivo/index.php?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:25:53'),
(213, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:33:22'),
(214, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:33:23'),
(215, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:33:23'),
(216, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:33:23'),
(217, '/proyecto/blog_responsivo/admin/db/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php?backup=1', '2026-04-01 16:33:23'),
(218, '/proyecto/blog_responsivo/admin/db/auth.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/db/', '2026-04-01 16:33:25'),
(219, '/proyecto/blog_responsivo/admin/db/admin/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/db/auth.php', '2026-04-01 16:33:28'),
(220, '/proyecto/blog_responsivo/admin/db/admin/admin/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/db/admin/', '2026-04-01 16:33:48'),
(221, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-01 16:33:59'),
(222, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-01 16:34:08'),
(223, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:34:15'),
(224, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:20'),
(225, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:22'),
(226, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:23'),
(227, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:24'),
(228, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:26'),
(229, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:28'),
(230, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:29'),
(231, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:34:35'),
(232, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:37'),
(233, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:39'),
(234, '/proyecto/blog_responsivo/index.php?cat=Programaci%C3%B3n', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:42'),
(235, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php?cat=Programaci%C3%B3n', '2026-04-01 16:34:45'),
(236, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:48'),
(237, '/proyecto/blog_responsivo/about.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:34:59'),
(238, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:38:50'),
(239, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:01'),
(240, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:01'),
(241, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:02'),
(242, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:02'),
(243, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:03'),
(244, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:03'),
(245, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:03'),
(246, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:03'),
(247, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:03'),
(248, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(249, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(250, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(251, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(252, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(253, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(254, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:04'),
(255, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:10'),
(256, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:10'),
(257, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:10'),
(258, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:11'),
(259, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:18'),
(260, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:19'),
(261, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:19'),
(262, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:19'),
(263, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(264, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(265, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(266, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(267, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(268, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:20'),
(269, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:21'),
(270, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:21'),
(271, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:21'),
(272, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:27'),
(273, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:27'),
(274, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:28'),
(275, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:28'),
(276, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:28'),
(277, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:28'),
(278, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:28'),
(279, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:29'),
(280, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:34'),
(281, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:34'),
(282, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:35'),
(283, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:39:42'),
(284, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:41:27'),
(285, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-01 16:41:28'),
(286, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-01 16:42:14'),
(287, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-01 16:42:32'),
(288, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/users.php', '2026-04-01 16:43:24'),
(289, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:43:26'),
(290, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:43:38'),
(291, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-01 16:43:42'),
(292, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:43:58'),
(293, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:44:10'),
(294, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-01 16:44:16'),
(295, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:45:52'),
(296, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-01 16:46:19'),
(297, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:48:07'),
(298, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:48:37'),
(299, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:48:38'),
(300, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:48:38'),
(301, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:48:38'),
(302, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-01 16:49:51'),
(303, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-01 16:50:05'),
(304, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-01 16:51:34'),
(305, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:51:41'),
(306, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:52:24'),
(307, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-01 16:52:28'),
(308, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-01 16:52:32'),
(309, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-01 16:52:33'),
(310, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-07 07:56:31'),
(311, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:21:22'),
(312, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:21:35'),
(313, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:21:37'),
(314, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 08:21:53'),
(315, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:22:34'),
(316, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:26:18'),
(317, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:28:05'),
(318, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:28:07'),
(319, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:28:07'),
(320, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 08:28:07'),
(321, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:04'),
(322, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:06'),
(323, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:06'),
(324, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:07'),
(325, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:08'),
(326, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:08'),
(327, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:22'),
(328, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:41'),
(329, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:41'),
(330, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:42'),
(331, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:42'),
(332, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/', '2026-04-07 08:29:42'),
(333, '/proyecto/blog_responsivo/?mes=2026-04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:46'),
(334, '/proyecto/blog_responsivo/?mes=2026-04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/?mes=2026-04', '2026-04-07 08:29:50'),
(335, '/proyecto/blog_responsivo/?mes=2026-04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/?mes=2026-04', '2026-04-07 08:29:52'),
(336, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/?mes=2026-04', '2026-04-07 08:29:56'),
(337, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:29:57'),
(338, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:14'),
(339, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:15'),
(340, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:15'),
(341, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:16'),
(342, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:16'),
(343, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:30:16'),
(344, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:17'),
(345, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:22'),
(346, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:31'),
(347, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:31'),
(348, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:32'),
(349, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:32'),
(350, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:32'),
(351, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:32'),
(352, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:30:33'),
(353, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 08:31:32'),
(354, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:35'),
(355, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:36'),
(356, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:37'),
(357, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:38'),
(358, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:39'),
(359, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:40'),
(360, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:41'),
(361, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:42'),
(362, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:44'),
(363, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:46'),
(364, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:51'),
(365, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:53'),
(366, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:54'),
(367, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:56'),
(368, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:31:57'),
(369, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 08:35:47'),
(370, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/profile.php', '2026-04-07 08:35:55'),
(371, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/profile.php', '2026-04-07 08:36:40'),
(372, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:36:41'),
(373, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:36:42'),
(374, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 08:36:44'),
(375, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-07 09:00:06'),
(376, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-07 10:13:23'),
(377, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 11:22:55'),
(378, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 11:28:34'),
(379, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 11:54:33'),
(380, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-07 11:54:33'),
(381, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 13:29:35'),
(382, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:41'),
(383, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:43'),
(384, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:44'),
(385, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:47'),
(386, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:48'),
(387, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:29:50'),
(388, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-07 13:32:19'),
(389, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:32:21'),
(390, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:32:23'),
(391, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:32:24'),
(392, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 13:38:07'),
(393, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:11'),
(394, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:12'),
(395, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:14'),
(396, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:15'),
(397, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:17'),
(398, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:19'),
(399, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:21'),
(400, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:23'),
(401, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:24'),
(402, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:26'),
(403, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:30'),
(404, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:31'),
(405, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:33');
INSERT INTO `visit_logs` (`id`, `page`, `ip`, `user_agent`, `referer`, `created_at`) VALUES
(406, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:38:34'),
(407, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-07 13:39:27'),
(408, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 13:39:37'),
(409, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:39'),
(410, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:40'),
(411, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:41'),
(412, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:41'),
(413, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:42'),
(414, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:39:43'),
(415, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:41:58'),
(416, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:42:10'),
(417, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:45:16'),
(418, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:45:21'),
(419, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:45:29'),
(420, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 13:46:06'),
(421, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php?action=login', '2026-04-07 13:46:13'),
(422, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/upgrade.php', '2026-04-07 13:53:02'),
(423, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 13:59:25'),
(424, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:29'),
(425, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:30'),
(426, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:31'),
(427, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:32'),
(428, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:33'),
(429, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:35'),
(430, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:36'),
(431, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:36'),
(432, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:38'),
(433, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:39'),
(434, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:40'),
(435, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:41'),
(436, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:42'),
(437, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:42'),
(438, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:44'),
(439, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:46'),
(440, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:46'),
(441, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:47'),
(442, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:49'),
(443, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:51'),
(444, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:52'),
(445, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:53'),
(446, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:54'),
(447, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:55'),
(448, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:56'),
(449, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:57'),
(450, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 13:59:58'),
(451, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 14:00:05'),
(452, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 14:00:11'),
(453, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 14:06:09'),
(454, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:12:05'),
(455, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-07 14:12:42'),
(456, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:13:27'),
(457, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-07 14:18:43'),
(458, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:19:03'),
(459, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/users.php', '2026-04-07 14:22:14'),
(460, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 14:22:26'),
(461, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 14:22:33'),
(462, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/profile.php', '2026-04-07 14:22:57'),
(463, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:45:09'),
(464, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 14:45:49'),
(465, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 14:46:03'),
(466, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 14:46:04'),
(467, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 14:46:05'),
(468, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 14:46:07'),
(469, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:47:25'),
(470, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 14:48:15'),
(471, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 14:49:46'),
(472, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-07 14:53:28'),
(473, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-07 15:02:06'),
(474, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:02:09'),
(475, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:18'),
(476, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:19'),
(477, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:19'),
(478, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:19'),
(479, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:20'),
(480, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:21'),
(481, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:21'),
(482, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:21'),
(483, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:21'),
(484, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:21'),
(485, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:22'),
(486, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:22'),
(487, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:23'),
(488, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:23'),
(489, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:23'),
(490, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:23'),
(491, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:23'),
(492, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:24'),
(493, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:24'),
(494, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:24'),
(495, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:24'),
(496, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:24'),
(497, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:25'),
(498, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:25'),
(499, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:25'),
(500, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:25'),
(501, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:25'),
(502, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:26'),
(503, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:03:26'),
(504, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:03:39'),
(505, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:03:49'),
(506, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:04:06'),
(507, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:04:08'),
(508, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:04:09'),
(509, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/about.php', '2026-04-07 15:04:36'),
(510, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:06:34'),
(511, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:06:36'),
(512, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:06:44'),
(513, '/proyecto/blog_responsivo/?search=ssh', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:06:49'),
(514, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?search=ssh', '2026-04-07 15:06:56'),
(515, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:07:50'),
(516, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:08:22'),
(517, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-07 15:08:43'),
(518, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:09:13'),
(519, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/user/index.php', '2026-04-07 15:09:56'),
(520, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:10:19'),
(521, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:10:27'),
(522, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:10:31'),
(523, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:11:06'),
(524, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:11:15'),
(525, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:17:54'),
(526, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:17:57'),
(527, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:17:59'),
(528, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:01'),
(529, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:02'),
(530, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:03'),
(531, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:04'),
(532, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:04'),
(533, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:05'),
(534, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:06'),
(535, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:06'),
(536, '/proyecto/blog_responsivo/?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:07'),
(537, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?cat=General', '2026-04-07 15:18:09'),
(538, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?cat=General', '2026-04-07 15:18:25'),
(539, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:26'),
(540, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:28'),
(541, '/proyecto/blog_responsivo/?cat=Linux', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:31'),
(542, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?cat=Linux', '2026-04-07 15:18:32'),
(543, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:42'),
(544, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:48'),
(545, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:50'),
(546, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:51'),
(547, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:52'),
(548, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:18:54'),
(549, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:22'),
(550, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:23'),
(551, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:24'),
(552, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:24'),
(553, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:25'),
(554, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:26'),
(555, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:26'),
(556, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:19:27'),
(557, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:19:35'),
(558, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-07 15:20:17'),
(559, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:20:34'),
(560, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:20:38'),
(561, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:20:39'),
(562, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:20:40'),
(563, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:20:40'),
(564, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:20:41'),
(565, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:05'),
(566, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:06'),
(567, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:07'),
(568, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:08'),
(569, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:09'),
(570, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:21:14'),
(571, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:15'),
(572, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:16'),
(573, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:21:57'),
(574, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:00'),
(575, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:01'),
(576, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:02'),
(577, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:03'),
(578, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:03'),
(579, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:33'),
(580, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:34'),
(581, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:22:35'),
(582, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:23:21'),
(583, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:23:22'),
(584, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:23:31'),
(585, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:31:55'),
(586, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:31:56'),
(587, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:31:57'),
(588, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:31:58'),
(589, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:00'),
(590, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:01'),
(591, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:03'),
(592, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:06'),
(593, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:08'),
(594, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:10'),
(595, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:12'),
(596, '/proyecto/blog_responsivo/?cat=Linux', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:44'),
(597, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?cat=Linux', '2026-04-07 15:32:45'),
(598, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:46'),
(599, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:48'),
(600, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:32:51'),
(601, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:33:05'),
(602, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:33:07'),
(603, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-07 15:33:14');
INSERT INTO `visit_logs` (`id`, `page`, `ip`, `user_agent`, `referer`, `created_at`) VALUES
(604, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '', '2026-04-07 15:33:30'),
(605, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:33:50'),
(606, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/post.php?id=11', '2026-04-07 15:36:55'),
(607, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:37:11'),
(608, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/user/index.php', '2026-04-07 15:38:00'),
(609, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-07 15:38:32'),
(610, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/post.php?id=12', '2026-04-07 15:38:57'),
(611, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/admin/login.php', '2026-04-07 15:43:18'),
(612, '/proyecto/blog_responsivo/?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/post.php?id=12', '2026-04-07 15:43:23'),
(613, '/proyecto/blog_responsivo/?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/?cat=General', '2026-04-07 15:43:25'),
(614, '/proyecto/blog_responsivo/?search=ssh', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/post.php?id=12', '2026-04-07 15:43:35'),
(615, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/post.php?id=4', '2026-04-07 15:43:45'),
(616, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:48'),
(617, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:48'),
(618, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:49'),
(619, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:50'),
(620, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:52'),
(621, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'http://localhost/proyecto/blog_responsivo/', '2026-04-07 15:43:53'),
(622, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-08 08:27:36'),
(623, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-08 08:39:19'),
(624, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-08 09:04:29'),
(625, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/admin/dashboard.php', '2026-04-08 09:05:23'),
(626, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:05:34'),
(627, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:05:35'),
(628, '/proyecto/blog_responsivo/?cat=Programaci%C3%B3n', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:05:38'),
(629, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/?cat=Programaci%C3%B3n', '2026-04-08 09:05:39'),
(630, '/proyecto/blog_responsivo/?cat=Linux', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:06:13'),
(631, '/proyecto/blog_responsivo/?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:06:14'),
(632, '/proyecto/blog_responsivo/?cat=General', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/index.php', '2026-04-08 09:11:44'),
(633, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-08 09:12:03'),
(634, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=12', '2026-04-08 09:12:31'),
(635, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-08 09:12:34'),
(636, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/auth.php', '2026-04-08 09:12:47'),
(637, '/proyecto/blog_responsivo/index.php', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/user/index.php', '2026-04-08 09:13:48'),
(638, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-08 14:13:24'),
(639, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-08 14:13:51'),
(640, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://192.168.5.54:81/auth.php', '2026-04-08 14:13:58'),
(641, '//index.php', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://192.168.5.54:81//admin/login.php', '2026-04-08 14:14:17'),
(642, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-08 14:27:02'),
(643, '//?cat=Linux', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://192.168.5.54:81//post.php?id=11', '2026-04-08 14:28:14'),
(644, '//?mes=2026-04', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://192.168.5.54:81//?cat=Linux', '2026-04-08 14:28:21'),
(645, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'http://192.168.5.54:81//lenin@ejemplo.com', '2026-04-08 14:28:41'),
(646, '//index.php', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//admin/login.php', '2026-04-08 14:31:33'),
(647, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 14:31:36'),
(648, '//?cat=Linux', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//', '2026-04-08 14:32:32'),
(649, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 14:32:56'),
(650, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//profile.php', '2026-04-08 14:33:09'),
(651, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-08 16:34:27'),
(652, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443/auth.php?action=register', '2026-04-08 16:35:08'),
(653, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php?action=register', '2026-04-08 16:35:21'),
(654, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:36:12'),
(655, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//profile.php', '2026-04-08 16:36:42'),
(656, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443/auth.php?action=register', '2026-04-08 16:40:10'),
(657, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443/auth.php', '2026-04-08 16:41:37'),
(658, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php?action=register', '2026-04-08 16:41:56'),
(659, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php?action=login', '2026-04-08 16:45:53'),
(660, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:46:52'),
(661, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//', '2026-04-08 16:46:54'),
(662, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:47:54'),
(663, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//profile.php', '2026-04-08 16:48:01'),
(664, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:49:24'),
(665, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:54:11'),
(666, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//', '2026-04-08 16:54:13'),
(667, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '', '2026-04-08 16:55:48'),
(668, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-08 16:56:19'),
(669, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', 'https://192.168.5.54:4443//', '2026-04-08 17:02:41'),
(670, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-08 20:28:02'),
(671, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//auth.php', '2026-04-09 07:34:13'),
(672, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//about.php', '2026-04-09 09:34:36'),
(673, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//about.php', '2026-04-09 11:38:46'),
(674, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-09 15:43:51'),
(675, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/post.php?id=3', '2026-04-09 16:27:51'),
(676, '/', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '', '2026-04-09 16:29:28'),
(677, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//profile.php', '2026-04-09 16:30:25'),
(678, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/', '2026-04-09 16:50:05'),
(679, '/proyecto/blog_responsivo/', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'http://localhost/proyecto/blog_responsivo/', '2026-04-09 16:50:18'),
(680, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//profile.php', '2026-04-09 16:50:29'),
(681, '//', '192.168.5.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'https://192.168.5.54:4443//', '2026-04-09 16:52:48');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `about`
--
ALTER TABLE `about`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indices de la tabla `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `site_stats`
--
ALTER TABLE `site_stats`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `visit_logs`
--
ALTER TABLE `visit_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `about`
--
ALTER TABLE `about`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `site_stats`
--
ALTER TABLE `site_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `visit_logs`
--
ALTER TABLE `visit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=682;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
