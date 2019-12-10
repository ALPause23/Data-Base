CREATE DATABASE fabrica_3;
USE fabrica_3;

CREATE TABLE `workshop` (
	`id_workshop` int NOT NULL AUTO_INCREMENT,
	`title` char(45) NOT NULL,
	`number_worker` int NOT NULL,
	PRIMARY KEY (`id_workshop`)
);

CREATE TABLE `room` (
	`id_room` int NOT NULL AUTO_INCREMENT,
	`temperature` int NOT NULL,
	`type` int NOT NULL,
	PRIMARY KEY (`id_room`)
);

CREATE TABLE `worker` (
	`id_passport` int NOT NULL AUTO_INCREMENT,
	`name` char(45) NOT NULL,
	`education` char(45) NOT NULL,
	`id_room` int NOT NULL,
	PRIMARY KEY (`id_passport`)
);

CREATE TABLE `territory` (
	`id_workshop` int NOT NULL,
	`id_room` int NOT NULL,
	PRIMARY KEY (`id_workshop`,`id_room`)
);

CREATE TABLE `status` (
	`id_workshop` int NOT NULL,
	`id_worker` int NOT NULL,
	PRIMARY KEY (`id_workshop`,`id_worker`)
);

CREATE TABLE `store` (
	`id_store` int NOT NULL AUTO_INCREMENT,
	`responsible` char(45) NOT NULL,
	`title` char(45) NOT NULL,
	PRIMARY KEY (`id_store`)
);

CREATE TABLE `shift` (
	`id_shift` int NOT NULL AUTO_INCREMENT,
	`start_time` TIME(4) NOT NULL,
	`finish_time` TIME(4) NOT NULL,
	PRIMARY KEY (`id_shift`)
);

CREATE TABLE `store_material` (
	`id_store` int NOT NULL AUTO_INCREMENT,
	`id_workshop` int NOT NULL,
	PRIMARY KEY (`id_store`)
);

CREATE TABLE `product` (
	`id_product` int NOT NULL AUTO_INCREMENT,
	`type` char(50) NOT NULL,
	`build_time` TIME(4) NOT NULL,
	PRIMARY KEY (`id_product`)
);

CREATE TABLE `manufacture` (
	`id_workshop` int NOT NULL,
	`id_shift` int NOT NULL,
	`id_product` int NOT NULL,
	`id_otk` int NOT NULL,
	`result` char(10) NOT NULL,
	PRIMARY KEY (`id_workshop`,`id_shift`)
);

CREATE TABLE `task` (
	`id_shift` int NOT NULL,
	`id_passport` int NOT NULL,
	`date` TIME(4) NOT NULL,
	`type_work` char(45) NOT NULL,
	PRIMARY KEY (`id_shift`,`id_passport`)
);

ALTER TABLE `worker` ADD CONSTRAINT `worker_fk0` FOREIGN KEY (`id_room`) REFERENCES `room`(`id_room`);

ALTER TABLE `territory` ADD CONSTRAINT `territory_fk0` FOREIGN KEY (`id_workshop`) REFERENCES `workshop`(`id_workshop`);

ALTER TABLE `territory` ADD CONSTRAINT `territory_fk1` FOREIGN KEY (`id_room`) REFERENCES `room`(`id_room`);

ALTER TABLE `status` ADD CONSTRAINT `status_fk0` FOREIGN KEY (`id_workshop`) REFERENCES `workshop`(`id_workshop`);

ALTER TABLE `status` ADD CONSTRAINT `status_fk1` FOREIGN KEY (`id_worker`) REFERENCES `worker`(`id_passport`);

ALTER TABLE `store_material` ADD CONSTRAINT `store_material_fk0` FOREIGN KEY (`id_store`) REFERENCES `store`(`id_store`);

ALTER TABLE `store_material` ADD CONSTRAINT `store_material_fk1` FOREIGN KEY (`id_workshop`) REFERENCES `workshop`(`id_workshop`);

ALTER TABLE `manufacture` ADD CONSTRAINT `manufacture_fk0` FOREIGN KEY (`id_workshop`) REFERENCES `workshop`(`id_workshop`);

ALTER TABLE `manufacture` ADD CONSTRAINT `manufacture_fk1` FOREIGN KEY (`id_shift`) REFERENCES `shift`(`id_shift`);

ALTER TABLE `manufacture` ADD CONSTRAINT `manufacture_fk2` FOREIGN KEY (`id_product`) REFERENCES `product`(`id_product`);

ALTER TABLE `task` ADD CONSTRAINT `task_fk0` FOREIGN KEY (`id_shift`) REFERENCES `shift`(`id_shift`);

ALTER TABLE `task` ADD CONSTRAINT `task_fk1` FOREIGN KEY (`id_passport`) REFERENCES `worker`(`id_passport`);

