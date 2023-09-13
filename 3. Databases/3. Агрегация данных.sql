-- Агрегация данных
-- 1. Подсчитайте средний возраст пользователей в таблице users
use shop;
ALTER TABLE users ADD column birthday DATETIME;
SELECT * FROM users;
UPDATE shop.users SET birthday = '2010-04-09' WHERE id = 1;
UPDATE shop.users SET birthday = '1970-08-24' WHERE id = 2;
SELECT ROUND(AVG(YEAR(NOW())-YEAR(birthday))) as `Average` FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

use shop;
SELECT MONTH(birthday), DAY(birthday) from users;
SELECT YEAR(NOW()), MONTH(birthday), DAY(birthday) from users;
SELECT CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday)) from users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') from users;
