-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 21 juil. 2021 à 23:29
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `koth_fr`
--

-- --------------------------------------------------------

--
-- Structure de la table `banlist`
--

CREATE TABLE `banlist` (
  `licenseid` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `token` longtext COLLATE utf8mb4_bin NOT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetName` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceName` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `banlisthistory`
--

CREATE TABLE `banlisthistory` (
  `id` int(11) NOT NULL,
  `licenseid` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `token` longtext COLLATE utf8mb4_bin NOT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetName` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceName` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `owned_weapons`
--

CREATE TABLE `owned_weapons` (
  `id1` int(11) NOT NULL,
  `license` varchar(50) NOT NULL,
  `id` longtext NOT NULL,
  `price` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `player`
--

CREATE TABLE `player` (
  `id` int(11) NOT NULL,
  `license` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `level` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `license1` longtext DEFAULT NULL,
  `exp` int(11) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'player'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `skin`
--

CREATE TABLE `skin` (
  `id` int(11) NOT NULL,
  `class` longtext NOT NULL,
  `clothes` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `skin`
--

INSERT INTO `skin` (`id`, `class`, `clothes`) VALUES
(1, 'blufor_infantry', '{\"arms_2\":0,\"shoes_2\":0,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":15,\"makeup_3\":0,\"skin\":0,\"torso_2\":3,\"face\":0,\"watches_2\":0,\"torso_1\":221,\"mask_2\":5,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":0,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":5,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":17,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":35,\"ears_2\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":0,\"bags_1\":37,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":1,\"sun_2\":0,\"decals_2\":0,\"beard_1\":0,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":15,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":87,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":28,\"ears_1\":-1}\r\n'),
(2, 'blufor_medic', '{\"arms_2\":0,\"shoes_2\":0,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":0,\"glasses_1\":15,\"makeup_3\":0,\"skin\":2,\"torso_2\":3,\"face\":0,\"watches_2\":0,\"torso_1\":208,\"mask_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":3,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":103,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":19,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":35,\"ears_2\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":17,\"bags_1\":52,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":4,\"sun_2\":0,\"decals_2\":0,\"beard_1\":3,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":4,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":87,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":28,\"ears_1\":-1}\r\n'),
(3, 'indenpendant_infantry', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":0,\"hair_2\":0,\"hair_color_2\":0,\"lipstick_1\":0,\"moles_1\":0,\"glasses_1\":15,\"makeup_3\":0,\"skin\":8,\"torso_2\":0,\"face\":0,\"watches_2\":0,\"torso_1\":241,\"mask_2\":25,\"eyebrows_4\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":2,\"helmet_2\":20,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":5,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":104,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":20,\"tshirt_2\":1,\"hair_color_1\":17,\"shoes_1\":25,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":0,\"beard_2\":10,\"bags_1\":37,\"hair_1\":1,\"tshirt_1\":28,\"bags_2\":4,\"blush_1\":0,\"decals_2\":0,\"beard_1\":0,\"arms\":19,\"complexion_1\":0,\"shoes_2\":0,\"makeup_4\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"chest_1\":0,\"mask_1\":104,\"pants_1\":76,\"lipstick_3\":0,\"sex\":0,\"bproof_1\":1,\"sun_2\":0,\"age_2\":0,\"eye_color\":0,\"glasses_2\":0,\"ears_2\":0,\"ears_1\":-1}\r\n'),
(4, 'opfor_infantry', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":0,\"hair_2\":0,\"hair_color_2\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":25,\"makeup_3\":0,\"skin\":0,\"torso_2\":1,\"sun_2\":0,\"watches_2\":0,\"torso_1\":3,\"mask_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"tshirt_1\":16,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":1,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":18,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":-1,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"bproof_1\":1,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"blush_3\":0,\"glasses_2\":4,\"decals_1\":0,\"beard_2\":0,\"bags_1\":37,\"chest_1\":0,\"chain_1\":112,\"bags_2\":3,\"makeup_2\":0,\"decals_2\":0,\"beard_1\":0,\"complexion_1\":0,\"shoes_2\":0,\"blush_1\":0,\"hair_1\":0,\"bproof_2\":1,\"eyebrows_4\":0,\"beard_3\":0,\"pants_1\":97,\"makeup_4\":0,\"arms\":17,\"face\":0,\"sex\":0,\"ears_2\":0,\"age_2\":0,\"moles_1\":0,\"eye_color\":0,\"beard_4\":0,\"ears_1\":-1,\"lipstick_4\":0}\r\n'),
(5, 'opfor_medic', '{\"arms_2\":315,\"chest_3\":0,\"complexion_1\":0,\"hair_2\":0,\"lipstick_4\":0,\"lipstick_1\":0,\"mask_1\":0,\"glasses_1\":15,\"makeup_3\":0,\"skin\":0,\"torso_2\":7,\"sun_2\":0,\"watches_2\":0,\"torso_1\":139,\"mask_2\":0,\"eyebrows_4\":0,\"bracelets_1\":305,\"chain_1\":112,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":1,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":18,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"hair_1\":1,\"helmet_1\":83,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":18,\"age_1\":0,\"watches_1\":2,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":47,\"beard_2\":10,\"bags_1\":52,\"blush_1\":0,\"bproof_1\":4,\"bags_2\":4,\"shoes_2\":0,\"decals_2\":0,\"beard_1\":10,\"eyebrows_1\":0,\"makeup_1\":0,\"moles_1\":0,\"pants_1\":97,\"bproof_2\":3,\"age_2\":0,\"beard_3\":0,\"lipstick_2\":0,\"face\":0,\"makeup_4\":0,\"ears_2\":0,\"sex\":0,\"glasses_2\":1,\"tshirt_1\":28,\"hair_color_2\":0,\"eye_color\":0,\"ears_1\":-1,\"lipstick_3\":0,\"chest_1\":0}\r\n'),
(6, 'opfor_explosives', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":0,\"hair_2\":0,\"hair_color_2\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":15,\"makeup_3\":0,\"skin\":0,\"torso_2\":1,\"sun_2\":0,\"watches_2\":0,\"torso_1\":98,\"mask_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"tshirt_1\":16,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":1,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":0,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":19,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"bproof_1\":28,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"blush_3\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":0,\"bags_1\":39,\"chest_1\":0,\"chain_1\":112,\"bags_2\":2,\"makeup_2\":0,\"decals_2\":0,\"beard_1\":0,\"complexion_1\":0,\"shoes_2\":0,\"blush_1\":0,\"hair_1\":0,\"bproof_2\":0,\"eyebrows_4\":0,\"beard_3\":0,\"pants_1\":9,\"makeup_4\":0,\"arms\":17,\"face\":0,\"sex\":0,\"ears_2\":0,\"age_2\":0,\"moles_1\":0,\"eye_color\":0,\"beard_4\":0,\"ears_1\":-1,\"lipstick_4\":0}\r\n'),
(7, 'opfor_marksmamb', '{\"arms_2\":0,\"chest_3\":0,\"complexion_1\":0,\"hair_2\":0,\"lipstick_4\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":0,\"makeup_3\":0,\"skin\":0,\"torso_2\":3,\"sun_2\":0,\"watches_2\":0,\"torso_1\":139,\"mask_2\":0,\"eyebrows_4\":0,\"bracelets_1\":305,\"chain_1\":112,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":1,\"helmet_2\":7,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":18,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"hair_1\":1,\"helmet_1\":1,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":18,\"age_1\":0,\"watches_1\":2,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":47,\"beard_2\":10,\"bags_1\":52,\"blush_1\":0,\"bproof_1\":1,\"bags_2\":3,\"shoes_2\":0,\"decals_2\":0,\"beard_1\":10,\"eyebrows_1\":0,\"makeup_1\":0,\"moles_1\":0,\"pants_1\":97,\"bproof_2\":1,\"age_2\":0,\"beard_3\":0,\"lipstick_2\":0,\"face\":0,\"makeup_4\":0,\"ears_2\":0,\"sex\":0,\"glasses_2\":1,\"tshirt_1\":28,\"hair_color_2\":0,\"eye_color\":0,\"ears_1\":-1,\"lipstick_3\":0,\"chest_1\":0}\r\n'),
(8, 'opfor_support', '{\"arms_2\":0,\"chest_3\":0,\"complexion_1\":0,\"hair_2\":0,\"lipstick_4\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":0,\"makeup_3\":0,\"skin\":0,\"torso_2\":1,\"sun_2\":0,\"watches_2\":0,\"torso_1\":3,\"mask_2\":0,\"eyebrows_4\":0,\"bracelets_1\":305,\"chain_1\":112,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":1,\"helmet_2\":3,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":18,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"hair_1\":1,\"helmet_1\":124,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":18,\"age_1\":0,\"watches_1\":2,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":47,\"beard_2\":10,\"bags_1\":39,\"blush_1\":0,\"bproof_1\":9,\"bags_2\":4,\"shoes_2\":0,\"decals_2\":0,\"beard_1\":10,\"eyebrows_1\":0,\"makeup_1\":0,\"moles_1\":0,\"pants_1\":97,\"bproof_2\":4,\"age_2\":0,\"beard_3\":0,\"lipstick_2\":0,\"face\":0,\"makeup_4\":0,\"ears_2\":0,\"sex\":0,\"glasses_2\":1,\"tshirt_1\":16,\"hair_color_2\":0,\"eye_color\":0,\"ears_1\":-1,\"lipstick_3\":0,\"chest_1\":0}\r\n'),
(9, 'indenpendant_medic', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":1,\"hair_2\":0,\"hair_color_2\":17,\"lipstick_1\":0,\"moles_1\":0,\"glasses_1\":15,\"makeup_3\":0,\"skin\":8,\"torso_2\":1,\"face\":0,\"watches_2\":0,\"torso_1\":97,\"mask_2\":0,\"eyebrows_4\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":2,\"helmet_2\":1,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":0,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":58,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":20,\"tshirt_2\":2,\"hair_color_1\":1,\"shoes_1\":62,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":0,\"beard_2\":10,\"bags_1\":52,\"hair_1\":1,\"tshirt_1\":28,\"bags_2\":4,\"blush_1\":0,\"decals_2\":0,\"beard_1\":2,\"arms\":19,\"complexion_1\":0,\"shoes_2\":3,\"makeup_4\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"chest_1\":0,\"mask_1\":121,\"pants_1\":8,\"lipstick_3\":0,\"sex\":0,\"bproof_1\":4,\"sun_2\":0,\"age_2\":0,\"eye_color\":0,\"glasses_2\":0,\"ears_2\":0,\"ears_1\":-1}\r\n'),
(10, 'indenpendant_support', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":1,\"hair_2\":0,\"hair_color_2\":17,\"lipstick_1\":0,\"moles_1\":0,\"glasses_1\":25,\"makeup_3\":0,\"skin\":8,\"torso_2\":17,\"face\":0,\"watches_2\":0,\"torso_1\":260,\"mask_2\":14,\"eyebrows_4\":0,\"bracelets_1\":-1,\"chain_1\":10,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":2,\"helmet_2\":2,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":39,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":20,\"tshirt_2\":2,\"hair_color_1\":1,\"shoes_1\":59,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":0,\"beard_2\":10,\"bags_1\":37,\"hair_1\":1,\"tshirt_1\":28,\"bags_2\":315,\"blush_1\":0,\"decals_2\":0,\"beard_1\":10,\"arms\":19,\"complexion_1\":0,\"shoes_2\":20,\"makeup_4\":0,\"bproof_2\":3,\"lipstick_4\":0,\"beard_3\":0,\"chest_1\":0,\"mask_1\":115,\"pants_1\":15,\"lipstick_3\":0,\"sex\":0,\"bproof_1\":9,\"sun_2\":0,\"age_2\":0,\"eye_color\":0,\"glasses_2\":4,\"ears_2\":0,\"ears_1\":-1}\r\n'),
(11, 'indenpendant_explosives', '{\"arms_2\":0,\"chest_3\":0,\"eyebrows_1\":1,\"hair_2\":0,\"hair_color_2\":17,\"lipstick_1\":0,\"moles_1\":0,\"glasses_1\":5,\"makeup_3\":0,\"skin\":8,\"torso_2\":5,\"face\":0,\"watches_2\":0,\"torso_1\":242,\"mask_2\":7,\"eyebrows_4\":0,\"bracelets_1\":-1,\"chain_1\":0,\"eyebrows_2\":10,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":0,\"bodyb_1\":0,\"blemishes_1\":0,\"chest_2\":0,\"makeup_1\":0,\"helmet_1\":19,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"lipstick_2\":0,\"age_1\":0,\"watches_1\":20,\"tshirt_2\":1,\"hair_color_1\":1,\"shoes_1\":62,\"blush_3\":0,\"makeup_2\":0,\"decals_1\":0,\"beard_2\":10,\"bags_1\":39,\"hair_1\":1,\"tshirt_1\":16,\"bags_2\":4,\"blush_1\":0,\"decals_2\":0,\"beard_1\":10,\"arms\":19,\"complexion_1\":0,\"shoes_2\":3,\"makeup_4\":0,\"bproof_2\":4,\"lipstick_4\":0,\"beard_3\":0,\"chest_1\":0,\"mask_1\":114,\"pants_1\":8,\"lipstick_3\":0,\"sex\":0,\"bproof_1\":9,\"sun_2\":0,\"age_2\":0,\"eye_color\":0,\"glasses_2\":5,\"ears_2\":0,\"ears_1\":-1}\r\n'),
(12, 'indenpendant_marksmamb', '{\"arms_2\":0,\"shoes_2\":20,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":0,\"glasses_1\":5,\"makeup_3\":0,\"skin\":3,\"torso_2\":2,\"face\":0,\"watches_2\":0,\"torso_1\":41,\"mask_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":10,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":7,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":13,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":27,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":59,\"ears_2\":0,\"glasses_2\":6,\"decals_1\":0,\"beard_2\":21,\"bags_1\":37,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":0,\"sun_2\":0,\"decals_2\":0,\"beard_1\":2,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":1,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":6,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":15,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":28,\"ears_1\":-1}\r\n'),
(13, 'blufor_marksmamb', '{\"arms_2\":0,\"shoes_2\":0,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":0,\"glasses_1\":15,\"makeup_3\":0,\"skin\":10,\"torso_2\":2,\"face\":0,\"watches_2\":0,\"torso_1\":0,\"mask_2\":0,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":20,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":104,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":19,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":27,\"ears_2\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":21,\"bags_1\":37,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":1,\"sun_2\":0,\"decals_2\":0,\"beard_1\":11,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":0,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":87,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":28,\"ears_1\":-1}\r\n'),
(14, 'blufor_explosives', '{\"arms_2\":0,\"shoes_2\":0,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":15,\"makeup_3\":0,\"skin\":2,\"torso_2\":3,\"face\":0,\"watches_2\":0,\"torso_1\":220,\"mask_2\":1,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":25,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":19,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":35,\"ears_2\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":17,\"bags_1\":0,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":4,\"sun_2\":0,\"decals_2\":0,\"beard_1\":3,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":3,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":87,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":16,\"ears_1\":-1}\r\n'),
(15, 'blufor_support', '{\"arms_2\":0,\"shoes_2\":0,\"complexion_1\":0,\"hair_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"mask_1\":52,\"glasses_1\":15,\"makeup_3\":0,\"skin\":2,\"torso_2\":3,\"face\":0,\"watches_2\":0,\"torso_1\":220,\"mask_2\":1,\"lipstick_3\":0,\"bracelets_1\":-1,\"chain_1\":112,\"eyebrows_2\":0,\"sun_1\":0,\"moles_2\":0,\"chain_2\":0,\"helmet_2\":0,\"bracelets_2\":0,\"blemishes_2\":0,\"pants_2\":3,\"bodyb_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"hair_1\":1,\"helmet_1\":25,\"bodyb_2\":0,\"complexion_2\":0,\"eyebrows_3\":0,\"blush_2\":0,\"beard_4\":0,\"arms\":19,\"age_1\":0,\"watches_1\":-1,\"tshirt_2\":0,\"hair_color_1\":0,\"shoes_1\":35,\"ears_2\":0,\"glasses_2\":0,\"decals_1\":0,\"beard_2\":17,\"bags_1\":39,\"blush_3\":0,\"hair_color_2\":0,\"bags_2\":0,\"sun_2\":0,\"decals_2\":0,\"beard_1\":3,\"makeup_1\":0,\"chest_3\":0,\"chest_2\":0,\"moles_1\":0,\"bproof_2\":0,\"lipstick_4\":0,\"beard_3\":0,\"makeup_2\":0,\"bproof_1\":16,\"lipstick_2\":0,\"age_2\":0,\"sex\":0,\"makeup_4\":0,\"pants_1\":87,\"eyebrows_1\":0,\"eye_color\":0,\"eyebrows_4\":0,\"tshirt_1\":16,\"ears_1\":-1}\r\n');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`licenseid`);

--
-- Index pour la table `banlisthistory`
--
ALTER TABLE `banlisthistory`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `owned_weapons`
--
ALTER TABLE `owned_weapons`
  ADD PRIMARY KEY (`id1`);

--
-- Index pour la table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `skin`
--
ALTER TABLE `skin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `banlisthistory`
--
ALTER TABLE `banlisthistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `owned_weapons`
--
ALTER TABLE `owned_weapons`
  MODIFY `id1` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `player`
--
ALTER TABLE `player`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `skin`
--
ALTER TABLE `skin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
