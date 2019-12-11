USE fabrica_1;

# 1. Конкретный вид изделий перестали выпускать. Создать отдельную таблицу невыпускаемых изделий
-- в неё записать инфу об изделии. Найти невыпускаемые изделия и удалить из manufactory и  product
DROP TABLE not_manufact_product;

SELECT product.* FROM manufacture RIGHT JOIN product ON manufacture.id_product = product.id_product WHERE manufacture.id_product is NULL;

SELECT product.id_product, product.type FROM product WHERE product.type = 'Холодильник';
SELECT count(manufacture.id_product), t1.id_product, t1.type FROM manufacture, (SELECT product.id_product, product.type FROM product WHERE product.type = 'Холодильник') as t1
			WHERE t1.id_product = manufacture.id_product group by(manufacture.id_product);
INSERT INTO not_manufact_product (size, id_product, type)
		SELECT count(manufacture.id_product)as size, t1.id_product as id_product, t1.type as type FROM manufacture, (SELECT product.id_product, product.type FROM product WHERE product.type = 'Холодильник') as t1
			WHERE t1.id_product = manufacture.id_product group by(manufacture.id_product);

INSERT INTO not_manufact_product (id_product, type, size)  
	SELECT product.id_product AS id_product, product.type AS type, count(manufacture.id_product) AS size
		FROM manufacture RIGHT JOIN product ON manufacture.id_product = product.id_product WHERE manufacture.id_product is NULL;

START TRANSACTION;
CREATE TABLE not_manufact_product
(
    id_product int,
	type char(50),
    size int
)ENGINE=InnoDB default charset=cp1251;
INSERT INTO not_manufact_product (size, id_product, type)
		SELECT count(manufacture.id_product)as size, t1.id_product as id_product, t1.type as type FROM manufacture, (SELECT product.id_product, product.type FROM product WHERE product.type = 'Холодильник') as t1
			WHERE t1.id_product = manufacture.id_product group by(manufacture.id_product);
DELETE FROM product USING product, (SELECT product.id_product as pr FROM product WHERE product.type = 'Холодильник') as r WHERE product.id_product = r.pr;
COMMIT;

# 2. Поместить (изменить какое-нибудь поле, например символом '!') сотрудников, которые связаны с помещениями, а эти помещения не связаны с цехами
SELECT worker.name, territory.id_room, (worker.id_room) FROM worker left join territory on worker.id_room = territory.id_room where territory.id_room is null;
UPDATE worker, (SELECT worker.id_passport as a FROM worker left join territory on worker.id_room = territory.id_room where territory.id_room is null) as q 
		SET name = CONCAT('!', SUBSTR(name, 1)) WHERE worker.id_passport = q.a;
