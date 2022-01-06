CREATE DATABASE IF NOT EXISTS `pe-core`;

USE `pe-core`;

CREATE TABLE `pe_characters` (
    `character_id` int NOT NULL AUTO_INCREMENT,
    `user_identifier` VARCHAR(60) NOT NULL,
    `phone_number` VARCHAR(20) DEFAULT NULL;
    PRIMARY KEY (`character_id`)
);