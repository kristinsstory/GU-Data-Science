-- Операторы,фильтрация, сортировка, ограничение
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

use shop;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	created_at VARCHAR(50),
	updated_at VARCHAR(50)
);


SELECT * FROM users;
INSERT INTO users (`created_at`, `updated_at`) values ('08.03.2020 8:10', '09.04.2020 5:05');
INSERT INTO users (`created_at`, `updated_at`) values ('10.03.2020 8:10', '10.04.2020 6:01');

-- 2. Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users ADD column created_at_dt DATETIME, ADD column updated_at_dt DATETIME;
SET SQL_SAFE_UPDATES=0;
SET SQL_MODE='ALLOW_INVALID_DATES';
UPDATE users SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	updated_at_dt = STR_TO_DATE(`updated_at`, '%d.%m.%Y %h:%i');
SET SQL_SAFE_UPDATES=1;
ALTER TABLE users DROP created_at, CHANGE created_at_dt created_at DATETIME;
ALTER TABLE users DROP updated_at, CHANGE updated_at_dt updated_at DATETIME;

/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы.
 Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 Однако, нулевые запасы должны выводиться в конце, после всех записей
 */
 
use shop;
DROP TABLE IF EXISTS storehouses_products ;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	`value` INT NOT NULL
);

SELECT * FROM storehouses_products;
INSERT INTO storehouses_products (`value`) Values (0),
(2500),
(0),
(30),
(500),
(1);
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 2147483647 ELSE value END;