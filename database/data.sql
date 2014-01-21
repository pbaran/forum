-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 21 Sty 2014, 18:05
-- Wersja serwera: 5.5.25a
-- Wersja PHP: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `forum`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `name_seo` varchar(255) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `topics` int(11) NOT NULL,
  `posts` int(11) NOT NULL,
  `last_active_topic_id` int(11) NOT NULL DEFAULT '-1',
  `priority` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Zrzut danych tabeli `category`
--

INSERT INTO `category` (`id`, `name`, `name_seo`, `description`, `topics`, `posts`, `last_active_topic_id`, `priority`) VALUES
(3, 'Sport', 'sport', 'Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna.', 2, 1, 2, 100),
(4, 'Humor', 'humor', 'Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna.', 0, 0, -1, 90);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_message_user1_idx` (`user_id`),
  KEY `fk_message_message_thread1_idx` (`thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `message_thread`
--

CREATE TABLE IF NOT EXISTS `message_thread` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_message_thread_user1_idx` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_name` varchar(200) NOT NULL,
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` mediumtext NOT NULL,
  `author_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_user1_idx` (`author_id`),
  KEY `fk_post_topic1_idx` (`topic_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Zrzut danych tabeli `post`
--

INSERT INTO `post` (`id`, `author_name`, `post_date`, `content`, `author_id`, `topic_id`) VALUES
(2, 'piotrek', '2014-01-21 16:05:16', 'No pewnie! A co Ty myślałeś, że zimą to nie można! Nakładasz dres i jedziesz :)', 2, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `topic`
--

CREATE TABLE IF NOT EXISTS `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `posts` int(11) NOT NULL DEFAULT '0',
  `last_poster_id` int(11) DEFAULT NULL,
  `state` enum('open','closed') NOT NULL DEFAULT 'open',
  `start_date` timestamp NULL DEFAULT NULL,
  `last_post` timestamp NULL DEFAULT NULL,
  `title_seo` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topic_category_idx` (`category_id`),
  KEY `fk_topic_user1_idx` (`author_id`),
  KEY `fk_topic_user2_idx` (`last_poster_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Zrzut danych tabeli `topic`
--

INSERT INTO `topic` (`id`, `category_id`, `title`, `description`, `author_id`, `posts`, `last_poster_id`, `state`, `start_date`, `last_post`, `title_seo`) VALUES
(2, 3, 'Bieganie zimą', 'Czy bieganie zimą to dobry pomysł?', 1, 1, 2, 'open', '2013-10-14 22:00:00', '2013-10-15 14:00:00', 'bieganie_zima'),
(4, 3, 'Biegówki czy zjazdówki', 'Co wolicie biegówki czy zjazdówki?', 1, 0, NULL, 'open', '2014-01-15 11:00:00', NULL, 'biegowki_czy_zjazdowki');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(512) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_user_user_roles1_idx` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Zrzut danych tabeli `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `email`, `active`, `joined`, `type`) VALUES
(1, 'piotrek', '1234', 'admin@piotrus.net.pl', 0, '2014-01-20 04:00:00', 1),
(2, 'test', '1234', 'test@wp.pl', 1, '2014-01-07 23:00:00', 1),
(8, 'pierwszy', '4db32cd88e598b0884d5fbe1ad242d2270bc12a2bc5deb009414de0d28952504', 'asd@wpp.pl', 0, '2014-01-19 15:50:24', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_roles`
--

CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authority` varchar(50) NOT NULL,
  `description` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Zrzut danych tabeli `user_roles`
--

INSERT INTO `user_roles` (`id`, `authority`, `description`) VALUES
(1, 'USER', 'user'),
(2, 'ADMIN', 'administrator');

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_message_message_thread1` FOREIGN KEY (`thread_id`) REFERENCES `message_thread` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_message_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `message_thread`
--
ALTER TABLE `message_thread`
  ADD CONSTRAINT `fk_message_thread_user1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `fk_post_topic1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_post_user1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `topic`
--
ALTER TABLE `topic`
  ADD CONSTRAINT `fk_topic_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_topic_user1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_topic_user2` FOREIGN KEY (`last_poster_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_user_roles1` FOREIGN KEY (`type`) REFERENCES `user_roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
