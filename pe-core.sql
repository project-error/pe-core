CREATE TABLE `users` (
    `character_id` int NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `phone_number` VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (`character_id`)
);
