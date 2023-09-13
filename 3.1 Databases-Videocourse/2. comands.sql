use shop;

-- == SELECT == --
-- вывести все категории товаров
SELECT * FROM category;


-- == WHERE == --
-- вывести категорию товаров с идентификатором, равным 3
SELECT * FROM category WHERE idcategory = 3;
-- вывести категории товаров, у которых скидка не равна 0
SELECT * FROM category WHERE discount <> 0;
-- вывести категории товаров, у которых скидка больше 5
SELECT * FROM category WHERE discount > 5;
-- вывести категории товаров, у которых скидка больше 5 и меньше 15
SELECT * FROM category WHERE (discount > 5) and (discount < 15);
-- вывести категории товаров, у которых скидка меньше 5 или больше или равен 10
SELECT * FROM category WHERE (discount < 5) or (discount >=10);
-- вывести категории товаров, у которых скидка не меньше 5 
SELECT * FROM category WHERE NOT (discount < 5);
-- вывести категории товаров, у которых есть псевдоним
SELECT * FROM category WHERE allias_name is not null;
-- вывести категории товаров, у которых нет псевдонима
SELECT * FROM category WHERE allias_name is null;


-- == SELECT <столбец> == --
-- вывести названия всех категорий товаров
SELECT name FROM category;
-- вывести названия категорий товаров и скидки
SELECT name, discount FROM category;
-- вывести все скидки
SELECT discount FROM category;


-- DISTINCT
-- вывести все уникальные значения скидок 
SELECT distinct discount FROM category; 

-- == ORDER BY == --
-- вывести все категории товаров и отсортировать их по размеру скидки
SELECT * FROM category order by discount;
-- вывести все категории товаров и отсортировать их по размеру скидки в обратном порядке
SELECT * FROM category order by discount desc;

-- вывести все категории товаров с ненулевой скидкой и отсортировать их по размеру скидки в обратном порядке 
SELECT * FROM category where discount <> 0 order by discount desc; 

-- == LIMIT
-- вывести первые 2 категории товара 
Select * from category where idcategory < 3;
-- вывести первые 2 категории товара 
Select * from category limit 2;
-- вывести первые 2 категории товара со скидкой не равной нулю
Select * from category where discount <> 0 limit 2;

-- Получить название бренда с идентификатором 3;
Select name From brand where idbrand =3;
-- Получить первые 2 типа товара;
Select * from product_type limit 2;
-- Получить все категории товаров со скидкой меньше 10 и отстортировать их по названию 
Select * From category where discount < 10 order by name; 

-- == UPDATE == --
Update category set name = 'Головные уборы' where idcategory = 5;

Select * from category;
Update category set discount = 3 where idcategory = 2 or idcategory = 5;
Update category set discount = 3 where idcategory in (2, 5);

-- == Delete == --
Delete from category where idcategory = 5; 

-- С помощью команды Update заполнить alias name для всех категорий
UPDATE category set alias_name = 'women''s clothing' WHERE idcategory = 1;
UPDATE category set alias_name = 'man''s clothing' WHERE idcategory = 2;
UPDATE category set alias_name = 'women''s shoes' WHERE idcategory = 3;

-- Добавить новый бренд Тетя Клава
INSERT INTO category (name, discount) VALUES ('Тетя Клава Company', 0);

-- Удалить этот бренд 
DELETE FROM category WHERE idcategory = 7;



use shop;
SELECT * FROM product;
Select * from category where id = 1 or id = 3 or id = 2;
Select * from category where id >= 1 and id <=3;
Select * from category where id IN (1,2,3);


select * from product 
	inner join category on product.category_id = category.id;
    
select product.id, price, name from product  
    inner join category on product.category_id = category.id; 
    
select * from category  
    inner join product on product.category_id = category.id;
     
select * from product  
	inner join category on product.category_id = category.id
    where discount <= 5;
    -- where price < 10000;
    
    
select * from product  
	inner join category on product.category_id = category.id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id;
    
    -- Изменила местами category.id и product.category_id
    select * from product  
	inner join category on category.id = product.category_id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id;
    
    
select product.id, brand.name, product_type.name, category.name, product.price from product  
	inner join category on category.id = product.category_id   
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id;
    
-- == Домашнее задание    

use shop;
select * from product  
	inner join category on category.id = product.category_id;
    
select product.id, brand.name as brand_name, product_type.name as product_type, category.name as category_name, product.price from product  
	inner join category on category.id = product.category_id   
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id
    where product_type.id = 2; 
    
select * from category  
    left join product on product.category_id = category.id;
    
select category. * from category  
    left join product on product.category_id = category.id
    where product.id is null;
    
    
select category. * from product
    right join category on product.category_id = category.id
    where product.id is null;    

-- Вывести все типы товаров, для которых нет ни одного товара в нашем интернет-магазине
use shop;
Insert into product_type (name) Values ('шуба');

select product_type.* from product_type
	left join product on product_type_id = product_type.id
    where product.id is null;
    
-- Вывести информацию обо всех товаров, которые не попали ни в один из заказов
select * from `order`
inner join order_products on order_products.order_id = `order`.id
inner join product on order_products.product_id = product.id;


select product. * from `order`
inner join order_products on order_products.order_id = `order`.id
right join product on order_products.product_id = product.id
where  `order`.id is null;



insert into `order` (user_name, phone, datetime) values ('Петр', '888-88-88', '2016-05-28');

select * from `order`
inner join order_products on order_products.order_id = `order`.id
inner join product on order_products.product_id = product.id;

-- == Full outer join

select * from `order`
full outer join order_products on order_products.order_id = `order`.id
full outer join product on order_products.product_id = product.id;


--== UNION ==--


use shop;

select * from product_type where id = 1
union
select * from product_type where id = 2;


select * from `order`
	left join order_products on order_products.order_id = `order`.id
    left join product on order_products.product_id = product.id
    
union

select * from `order`	
	inner join order_products on order_products.order_id = `order`.id
    right join product on order_products.product_id = product.id
    where `order`.id is null;
    
    
-- Домашнее задание 
use shop;
insert into order_products (order_id, product_id, `count`) values (2,3,2);
insert into order_products (order_id, product_id, `count`) values (2,4,3);

select * from `order`
	inner join order_products on order_products.order_id = `order`.id
    inner join product on order_products.product_id = product.id
	where `order`.id = 1;
    
    
select *, price * `count` as total_price from `order`
	inner join order_products on order_products.order_id = `order`.id
    inner join product on order_products.product_id = product.id
	where `order`.id = 1;
    
    
    
select sum(price * `count`) as total_price from `order`
	inner join order_products on order_products.order_id = `order`.id
    inner join product on order_products.product_id = product.id
	where `order`.id = 1;  
    
    
use shop;

SELECT * FROM product;
SELECT count(*) FROM product;
SELECT count(*) FROM product where product.price < 10000;
SELECT sum(price) from product;
Select sum(price), min(price), max(price) from product;

use shop;

insert into order_products (order_id, product_id, `count`) values (2, 3, 2);
insert into order_products (order_id, product_id, `count`) values (2, 4, 3);


-- Агрегирующие функции --
-- GROUP BY--
SELECT * FROM shop.`order`;


SELECT sum(price * `count`) as total_price from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    where `order`.id = 2;
    
    
SELECT `order`.user_name, sum(price * `count`) as total_price  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;
    
SELECT `order`.user_name, max(price), sum(`count`)  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;
    
    SELECT `order`.user_name, max(price), sum(`count`) as order_count from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    -- where user_name like 'Р’%'
    
    group by `order`.user_name
    having order_count >= 5; 
    
    
    
insert into `shop`.`user_bank_account` (id, money, user_name) values ('1', '100', 'Дмитрий');
insert into `shop`.`user_bank_account` (id, money, user_name) values ('2', '200', 'Евгений');

select * from `shop`.`user_bank_account`;

-- start transaction;
	update `shop`.`user_bank_account` set money = money - 100 where id = 1;
    update `shop`.`user_bank_account` set money = money + 100 where id = 2;
-- commit    
