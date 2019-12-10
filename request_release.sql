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

