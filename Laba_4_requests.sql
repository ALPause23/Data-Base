SELECT DISTINCT worker.name, workshop.title, status.position  FROM worker LEFT JOIN status
		ON status.id_passport = worker.id_passport
        LEFT JOIN workshop ON status.id_workshop = workshop.id_workshop
		ORDER BY worker.name; 

SELECT product.type FROM manufacture RIGHT JOIN product ON product.id_product = manufacture.id_product
					WHERE manufacture.id_product is NULL;
                    
SELECT distinct  product.type, workshop.title  FROM status
		INNER JOIN worker ON status.id_passport = worker.id_passport AND worker.name LIKE '%Evgeni%'
        INNER JOIN workshop ON workshop.id_workshop = status.id_workshop
        INNER JOIN manufacture ON manufacture.id_workshop = status.id_workshop
        INNER JOIN product ON manufacture.id_product = product.id_product;
        
SELECT distinct workshop.title, product.type  FROM manufacture INNER JOIN product ON product.id_product = manufacture.id_product AND product.type = 'Холодильник'
												INNER JOIN workshop ON workshop.id_workshop = manufacture.id_workshop;
                                                
SELECT worker.name, task.type_work FROM worker INNER JOIN task
		ON task.id_passport = worker.id_passport AND (task.id_shift = 1 or task.id_shift = 2) WHERE (task.date >= '2016-02-05' AND '2016-02-25' >= task.date);