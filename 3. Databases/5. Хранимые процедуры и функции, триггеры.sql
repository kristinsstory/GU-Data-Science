-- Хранимые процедуры и функции, триггеры
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
SELECT NOW(), HOUR(NOW())//

-- SET GLOBAL log_bin_trust_function_creators = 1;
CREATE FUNCTION `hour` ()
RETURNS INT NOT DETERMINISTIC
BEGIN
  RETURN HOUR(NOW());
END//
  
SELECT `hour`()//

CREATE FUNCTION hello ()
RETURNS TINYTEXT NOT DETERMINISTIC
BEGIN
  DECLARE h INT;
  SET h = HOUR(NOW());
  CASE
    WHEN h BETWEEN 0 AND 5 THEN
    RETURN 'Доброй ночи';
    WHEN h BETWEEN 6 AND 11 THEN
    RETURN 'Доброе утро';
    WHEN h BETWEEN 12 AND 17 THEN
    RETURN 'Добрый день';
    WHEN h BETWEEN 18 AND 23 THEN
    RETURN 'Добрый вечер';
  END CASE;
END//

SELECT NOW(), hello()//



