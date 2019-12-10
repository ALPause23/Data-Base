CREATE DATABASE fabrica_1;
USE fabrica_1;

CREATE TABLE workshop
(
    id_workshop int NOT NULL AUTO_INCREMENT,
	title char(45),
	number_worker int,
	CONSTRAINT workshop_pk0 PRIMARY KEY (id_workshop)
);

CREATE TABLE room
(
	id_room int NOT NULL AUTO_INCREMENT,
	temperature int,
	type char(45),
	CONSTRAINT room_pk0 PRIMARY KEY (id_room)
);

CREATE TABLE worker
(
    id_passport int NOT NULL,
	name char(45),
	education char(45),
	id_room int,
    id_store int,
	CONSTRAINT worker_pk0 PRIMARY KEY (id_passport)
);

CREATE TABLE territory 
(
	id_workshop int,
	id_room int,
	CONSTRAINT territory_pk0  PRIMARY KEY (id_workshop, id_room)
);

CREATE TABLE status
(
	id_workshop int,
	id_passport int,
    position char(45),
	CONSTRAINT status_pk0 PRIMARY KEY (id_workshop, id_passport)
);

CREATE TABLE store 
(
	id_store int NOT NULL AUTO_INCREMENT,
	responsible char(45),
    numbers int,
	title char(45),
	CONSTRAINT store_pk0 PRIMARY KEY (id_store)
);

CREATE TABLE shift 
(
	id_shift int NOT NULL AUTO_INCREMENT,
	start_time TIME(0),
	finish_time TIME(0),
	CONSTRAINT shift_pk0 PRIMARY KEY (id_shift)
);

CREATE TABLE store_material
(
    id_store int AUTO_INCREMENT,
	id_workshop int,
	CONSTRAINT store_material_pk0 PRIMARY KEY (id_store)
);

CREATE TABLE product 
(
    id_product int NOT NULL AUTO_INCREMENT,
	type char(50),
	build_time TIME(4),
	CONSTRAINT product_pk0 PRIMARY KEY (id_product)
);

CREATE TABLE manufacture 
(
	id_workshop int,
	id_shift int,
	id_product int,
	id_otk int,
	result char(50),
	CONSTRAINT manufacture_pk0 PRIMARY KEY (id_workshop, id_shift, id_product)
);

CREATE TABLE task 
(
	id_shift int,
	id_passport int,
	date DATE,
	type_work char(45),
	CONSTRAINT task_pk0 PRIMARY KEY (id_shift, id_passport)
);

ALTER TABLE worker ADD CONSTRAINT worker_fk0 FOREIGN KEY (id_room) REFERENCES room (id_room);

ALTER TABLE worker ADD CONSTRAINT worker_fk1 FOREIGN KEY (id_store) REFERENCES store (id_store);

ALTER TABLE territory ADD CONSTRAINT territory_fk0 FOREIGN KEY (id_workshop) REFERENCES workshop(id_workshop) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE territory ADD CONSTRAINT territory_fk1 FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE status ADD CONSTRAINT status_fk0 FOREIGN KEY (id_workshop) REFERENCES workshop(id_workshop) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE status ADD CONSTRAINT status_fk1 FOREIGN KEY (id_passport) REFERENCES worker(id_passport) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE store_material ADD CONSTRAINT store_material_fk0 FOREIGN KEY (id_store) REFERENCES store(id_store) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE store_material ADD CONSTRAINT store_material_fk1 FOREIGN KEY (id_workshop) REFERENCES workshop(id_workshop) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE manufacture ADD CONSTRAINT manufacture_fk0 FOREIGN KEY (id_workshop) REFERENCES workshop(id_workshop) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE manufacture ADD CONSTRAINT manufacture_fk1 FOREIGN KEY (id_shift) REFERENCES shift(id_shift) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE manufacture ADD CONSTRAINT manufacture_fk2 FOREIGN KEY (id_product) REFERENCES product(id_product) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE task ADD CONSTRAINT task_fk0 FOREIGN KEY (id_shift) REFERENCES shift(id_shift) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE task ADD CONSTRAINT task_fk1 FOREIGN KEY (id_passport) REFERENCES worker(id_passport) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE worker ADD CONSTRAINT id_passport_check CHECK (id_passport > 0);

ALTER TABLE workshop ADD CONSTRAINT id_numberworker_check CHECK (1 <= number_worker);

ALTER TABLE store ADD CONSTRAINT id_number_check CHECK (0 <= numbers);

ALTER TABLE workshop COMMENT = 'Таблица содержит информацию о цехе';

ALTER TABLE room COMMENT = 'Таблица содержит информацию о помещениях';

ALTER TABLE worker COMMENT =  'Таблица содержит информацию о работнике';

ALTER TABLE store COMMENT = 'Таблица содержит информацию о складах';

ALTER TABLE shift COMMENT = 'Таблица содержит информацию о сменах';

ALTER TABLE product COMMENT = 'Таблица содержит информацию о продукции';

ALTER TABLE manufacture COMMENT = 'Таблица содержит информацию о производстве определёного типа продукта';

ALTER TABLE task COMMENT = 'Таблица содержит информацию о задачах';

ALTER TABLE store_material COMMENT = 'Таблица содержит информацию о материалах';

ALTER TABLE status COMMENT = 'Таблица содержит информацию о положении работника на заводе';

ALTER TABLE territory COMMENT = 'Таблица содержит информацию о помещениях и цехах';


INSERT INTO workshop (title, number_worker) VALUES ('Литейный', 50),
												   ('Сборочный', 43),
												   ('Наладочный', 15),
												   ('Администрация', 24),
												   ('Служба безопасности', 10);
INSERT INTO room (temperature, type) VALUES (20, 'type0'),
											(25, 'type1'),
											(-5, 'type0'),
											(25, 'type3');

INSERT INTO store (responsible, numbers, title) VALUES ('Ivan Danko', 20, 'Лысая башка'),
													   ('Ivan Danko', 10, 'Длинный'),
													   ('Ivan Danko', 120, 'старый'),
													   ('Evgeni Harkavik', 90, 'Лысая башка х 2');
INSERT INTO worker (id_passport, name, education, id_room, id_store) VALUES (123, 'Ivan Danko', 'BSUIR', 4, 3),
														                    (234, 'Kirill Petrov', 'BSUIR', 1, 1),
                                                                            (157, 'Vova Kupreev', 'BGU', 1, 2),
                                                                            (78, 'Evgeni Harkavik', 'BNTU', 3, 2),
																			(15, 'Evgeni Kabrinovich', 'MRK', 2, 2),
																		    (100,'Pavel Mosechuk', 'BATU', 3, 4),
                                                                            (101, 'Evgeni Kalabukhov', 'BSUIR', 2, NULL),
                                                                            (1, 'Nikolai Kabrinovich', 'BNTU', 2, NULL),
                                                                            (99, 'Ivan Ivanov', 'BGU', 4, 3);
INSERT INTO shift (start_time, finish_time) VALUES ('02:23', '12:32'),
													('07:00', '12:00'),
													('13:23', '22:30'),
													('02:23', '12:32'),
													('07:00', '12:00'),
													('13:23', '22:30');

INSERT INTO product (type, build_time) VALUES ('Холодильник', '00:20:56'),
													('Чайник', '10:20:56'),
													('Морозильник', '02:27:56'),
													('Стиральная машина', '03:23:56'),
													('Холодильник', '00:34:56'),
													('Изделие 62', '04:45:56'),
													('Изделие 71', '06:50:56'),
													('Документы', '01:30:00');
INSERT INTO manufacture (id_workshop, id_shift, id_product, id_otk, result) VALUES (1, 1, 1, 7, 'Брак отсутствует'),
																			 (1, 2, 1, 90, 'Брак отсутствует'),
                                                                             (1, 3, 2, 7, 'Брак отсутствует'),
                                                                             (2, 1, 5, 8, 'Брак отсутствует'),
                                                                             (2, 2, 2, 2, 'Брак отсутствует'),
                                                                             (2, 3, 6, 7, 'Брак 19 шт.'),
                                                                             (3, 1, 3, 1, 'Брак 1 шт.'),
                                                                             (3, 2, 2, 7, 'Брак отсутствует'),
                                                                             (3, 4, 3, 1, 'Брак 3 шт.'),
                                                                             (4, 1, 8, NULL, 'Документы заполнены');
INSERT INTO task (id_shift, id_passport, date, type_work) VALUES (1, 234, '2016-02-24', 'Покраска'),
																 (1, 100, '2016-02-24', 'Покраска');
INSERT INTO status (id_workshop, id_passport, position) VALUES (1, 123, 'Монтажник'),
															   (1, 78, 'Монтажник'),
															   (1, 15, 'Начальник'),
															   (3, 234 ,'Бригадир'),
															   (2, 157, 'Алкоголик'),
                                                               (4, 101, 'Преподователь');
INSERT INTO store_material (id_workshop) VALUES (1), (2), (3), (4);
INSERT INTO territory (id_workshop, id_room) VALUES (1, 1),
													(2, 2),
													(3, 3),
													(4, 4);
INSERT INTO task (id_shift, id_passport, date, type_work) VALUES (1, 78, '2016-02-25', 'Покраска'),
																 (1, 157, '2016-02-24', 'Сборка'),
                                                                 (4, 78, '2016-02-24', 'Покраска'),
                                                                 (2, 78, '2016-02-5', 'Покраска'),
																 (2, 101, '2016-02-4', 'Наладка'),
                                                                 (3, 78, '2016-02-15', 'Сборка'),
																 (3, 15, '2016-02-14', 'Тестирование');
UPDATE workshop SET workshop.number_worker = 5 WHERE workshop.id_workshop = 5;
INSERT INTO status (id_workshop, id_passport, position) VALUES (2, 1, 'Инженер'),
															   (2, 100, 'Програмист'),
															   (5, 99, 'Никто');
                                                               
                                                               
                                                               
                                                               
INSERT INTO product (type, build_time) VALUES ('Холодильник', '00:20:56'), ('Холодильник', '00:34:56');
												
INSERT INTO manufacture (id_workshop, id_shift, id_product, id_otk, result) VALUES (1, 1, 11, 7, 'Брак отсутствует'),
																					(1, 2, 11, 90, 'Брак отсутствует'),
																					(2, 1, 12, 8, 'Брак отсутствует');