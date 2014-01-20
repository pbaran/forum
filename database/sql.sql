SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `forum` DEFAULT CHARACTER SET utf8 ;
USE `forum` ;

-- -----------------------------------------------------
-- Table `forum`.`category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(128) NOT NULL ,
  `name_seo` VARCHAR(255) NOT NULL ,
  `description` VARCHAR(1000) NOT NULL ,
  `topics` INT(11) NOT NULL ,
  `posts` INT(11) NOT NULL ,
  `last_active_topic_id` INT(11) NOT NULL DEFAULT '-1' ,
  `priority` INT(11) NOT NULL DEFAULT '100' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `forum`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `login` VARCHAR(100) NOT NULL ,
  `password` VARCHAR(100) NOT NULL ,
  `email` VARCHAR(512) NOT NULL ,
  `active` TINYINT(4) NOT NULL DEFAULT '0' ,
  `type` INT(11) NOT NULL DEFAULT '0' ,
  `joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `forum`.`message_thread`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`message_thread` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `author_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) ,
  INDEX `fk_message_thread_user1_idx` (`author_id` ASC) ,
  CONSTRAINT `fk_message_thread_user1`
    FOREIGN KEY (`author_id` )
    REFERENCES `forum`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `forum`.`message`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`message` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `thread_id` INT(11) NOT NULL ,
  `content` VARCHAR(1000) NOT NULL ,
  `user_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) ,
  INDEX `fk_message_user1_idx` (`user_id` ASC) ,
  INDEX `fk_message_message_thread1_idx` (`thread_id` ASC) ,
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `forum`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_message_thread1`
    FOREIGN KEY (`thread_id` )
    REFERENCES `forum`.`message_thread` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `forum`.`topic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`topic` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `category_id` INT(11) NOT NULL ,
  `title` VARCHAR(250) NOT NULL ,
  `description` VARCHAR(250) NULL DEFAULT NULL ,
  `author_id` INT(11) NOT NULL ,
  `posts` INT(11) NOT NULL DEFAULT '0' ,
  `last_poster_id` INT(11) NULL ,
  `state` ENUM('open','closed') NOT NULL DEFAULT 'open' ,
  `start_date` TIMESTAMP NULL DEFAULT NULL ,
  `last_post` TIMESTAMP NULL DEFAULT NULL ,
  `title_seo` VARCHAR(250) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_topic_category_idx` (`category_id` ASC) ,
  INDEX `fk_topic_user1_idx` (`author_id` ASC) ,
  INDEX `fk_topic_user2_idx` (`last_poster_id` ASC) ,
  CONSTRAINT `fk_topic_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `forum`.`category` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topic_user1`
    FOREIGN KEY (`author_id` )
    REFERENCES `forum`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topic_user2`
    FOREIGN KEY (`last_poster_id` )
    REFERENCES `forum`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `forum`.`post`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `forum`.`post` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `author_name` VARCHAR(200) NOT NULL ,
  `post_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `content` MEDIUMTEXT NOT NULL ,
  `author_id` INT(11) NOT NULL ,
  `topic_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_post_user1_idx` (`author_id` ASC) ,
  INDEX `fk_post_topic1_idx` (`topic_id` ASC) ,
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`author_id` )
    REFERENCES `forum`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_topic1`
    FOREIGN KEY (`topic_id` )
    REFERENCES `forum`.`topic` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
