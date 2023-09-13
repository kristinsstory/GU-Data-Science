use sample;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.


START TRANSACTION;
INSERT INTO sample.users SELECT * FROM ecommerce.users WHERE id = 1;
DELETE FROM ecommerce.users WHERE id = 1 LIMIT 1;
COMMIT;


-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

use ecommerce;

CREATE OR REPLACE VIEW products_catalogs AS
SELECT
p.name AS product,
c.name AS catalog
FROM
products AS p
JOIN catalogs AS c
ON p.catalog_id = c.id;
SELECT * FROM products_catalogs;

