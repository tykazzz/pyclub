-- MySQL Script generated by MySQL Workbench
-- wto, 2 paź 2018, 12:07:38
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pyclub
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pyclub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pyclub` ;
USE `pyclub` ;

-- -----------------------------------------------------
-- Table `pyclub`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pyclub`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`organization` (
  `idorganization` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `contact` LONGTEXT NOT NULL,
  PRIMARY KEY (`idorganization`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pyclub`.`club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`club` (
  `idclub` INT NOT NULL AUTO_INCREMENT,
  `info` LONGTEXT NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`idclub`, `organization_id`),
  INDEX `fk_club_organization1_idx` (`organization_id` ASC),
  CONSTRAINT `fk_club_organization1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `pyclub`.`organization` (`idorganization`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pyclub`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`event` (
  `idevent` INT NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NOT NULL,
  `info` LONGTEXT NOT NULL,
  `club_id` INT NOT NULL,
  PRIMARY KEY (`idevent`, `club_id`),
  INDEX `fk_event_club1_idx` (`club_id` ASC),
  CONSTRAINT `fk_event_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `pyclub`.`club` (`idclub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pyclub`.`club_membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`club_membership` (
  `user_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `club_id`),
  INDEX `fk_user_has_club_club1_idx` (`club_id` ASC),
  INDEX `fk_user_has_club_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_club_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `pyclub`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_club_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `pyclub`.`club` (`idclub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pyclub`.`event_membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pyclub`.`event_membership` (
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `event_club_idclub` INT NOT NULL,
  PRIMARY KEY (`user_id`, `event_id`, `event_club_idclub`),
  INDEX `fk_user_has_event_event1_idx` (`event_id` ASC, `event_club_idclub` ASC),
  INDEX `fk_user_has_event_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_event_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pyclub`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_event_event1`
    FOREIGN KEY (`event_id` , `event_club_idclub`)
    REFERENCES `pyclub`.`event` (`idevent` , `club_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
