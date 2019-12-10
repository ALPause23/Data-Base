USE fabrica_1;

# 1. Найти сколько разных изделий выпускал с ДАТА1 по ДАТА2 (сколько разных типов, отображать одно число)
SELECT task.id_shift FROM task WHERE (task.date >= '2016-02-04' AND '2016-02-15' >= task.date) group by(task.id_shift);
SELECT manufacture.id_product FROM manufacture WHERE 
	manufacture.id_shift IN (SELECT task.id_shift FROM task WHERE (task.date >= '2016-02-04' AND '2016-02-15' >= task.date) group by(task.id_shift)) group by(manufacture.id_product);
SELECT count(product.type) FROM product WHERE product.id_product IN
	(SELECT manufacture.id_product FROM manufacture WHERE 
		manufacture.id_shift IN (SELECT task.id_shift FROM task WHERE (task.date >= '2016-02-04' AND '2016-02-15' >= task.date) group by(task.id_shift)) group by(manufacture.id_product));

# 2. Для каждого цеха надо посчитать, какой процент сотрудников с ним связан, 
-- и сколько реальных изделий было выпущено(за весь период)(два числа - процент и число) 
SELECT count(name) FROM worker;
SELECT manufacture.id_workshop, count(manufacture.id_product) FROM manufacture group by(manufacture.id_workshop);

-- SELECT count(manufacture.id_product) FROM manufacture, workshop as workshop1 where manufacture.id_workshop = workshop1.id_workshop and workshop.title = workshop1.title;

SELECT workshop.title, CONCAT((workshop.number_worker*100/count(worker.name)), " %")persent FROM worker, workshop, manufacture group by(workshop.title);
SELECT workshop.title, CONCAT((workshop.number_worker*100/count(worker.name)), " %")persent, CONCAT(
	(SELECT count(manufacture.id_product) FROM manufacture, workshop as workshop1 where manufacture.id_workshop = workshop1.id_workshop and workshop.title = workshop1.title)) ' Количество реальные изделий'
		FROM worker, workshop, manufacture group by(workshop.title);

# 3. Найти должность на которой работает больше всего человек
select status.position, count(status.id_passport) FROM status group by(status.position);
SELECT status.position as pos, count(status.id_passport) as maks FROM status as s WHERE status.position = s.position group by(status.position);
SELECT pos, maks FROM (SELECT status.position as pos, count(status.id_passport) as maks FROM status group by(status.position)) as maks1 order by maks desc LIMIT 1;

# 4. Найти цеха, которые выпускают только один тип изделий (ниразу не выпускался по два раза в manufactory)
SELECT distinct count(manufacture.id_product), manufacture.id_workshop FROM manufacture group by manufacture.id_product, manufacture.id_workshop;  
SELECT w FROM (SELECT distinct count(manufacture.id_product), manufacture.id_workshop as w FROM manufacture group by manufacture.id_product, manufacture.id_workshop) as q group by(q);
SELECT workshop.title FROM workshop, 
	(SELECT manufacture.id_workshop as worksh, count(manufacture.id_product) as prod 
		FROM manufacture group by(manufacture.id_workshop)) as worksh1 
	WHERE worksh1.prod = 1 AND worksh1.worksh = workshop.id_workshop;
    
# 5. Для каждого вида работ сколько разных сотрудников хотя бы раз выполняли
-- (сколько видов работ есть, и сколько сумарнно сотрудников на них задействовано)
SELECT task.type_work, task.id_passport FROM task group by task.type_work, task.id_passport;
SELECT task, count(id) FROM 
	(SELECT task.type_work as task, task.id_passport as id FROM task group by task.type_work, task.id_passport) as task1
		group by(task);
