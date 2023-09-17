/*  1. Создать таблицы учебной базы данных (Goodreads, 17 таблиц)
скрипт создания структуры БД
скрипт наполнения БД данными */

DROP DATABASE IF EXISTS Goodreads;
CREATE DATABASE Goodreads;
USE Goodreads;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR (20) COMMENT 'Имя пользователя',
	middlename VARCHAR (40), 
	surname VARCHAR (40),
	email VARCHAR(55) UNIQUE,
	phone BIGINT UNSIGNED NOT NULL,
    
	INDEX users_firstname_surname_idx(firstname, surname)
);

INSERT INTO users VALUES ('1', 'Vasya', 'Aleksandrovich', 'Pupkin', 'vasya@gmail.ru', '89255550011'),
('2', 'Maria', 'Vasilievna', 'Ivanova', 'ivanova@mail.ru', '89253330020'),
('3', 'Nika', '', 'Petrova', 'petrova@mail.ru', '89163331122'),
('4', 'Katerina', '', 'Vladimirova', 'vladimorova@mail.ru', '89259991100'),
('5', 'Andrey', 'Alexandrovich', 'Kotik', 'kotik@bk.ru', '89160890022'),
('6', 'Ivan', '', 'Sidorov', 'sidorov.ivan@mail.ru', '89221903422'),
('7', 'Anna', '', 'Sinichkina', 'sinichkina@gmail.com', '89102221100'),
('8', 'Savva', '', 'Akopova', 'savva@mail.ru', '89260001100'),
('9', 'Darya', 'Alexandrovna', 'Aleshina', 'aleshina@mail.ru', '89260001120'),
('10', 'Dima', 'Vladimirovich', 'Kovalev', 'kovalev@gmail.com', '89160001120');

DROP TABLE IF EXISTS photo;
CREATE TABLE photos(
	id SERIAL PRIMARY KEY,
	filename VARCHAR (55)
);

INSERT INTO photos VALUES ('1', 'img1.jpeg'),
('2', 'img2.jpeg'),
('3', 'img3.jpeg'),
('4', 'img4.jpeg'),
('5', 'img5.jpeg'),
('6', 'img6.jpeg'),
('7', 'img7.jpeg'),
('8', 'img8.jpeg'),
('9', 'img9.jpeg'),
('10', 'img10.jpeg'),
('11', 'img11.jpeg'),
('12', 'img12.jpeg');

DROP TABLE IF EXISTS profiles_photo;
CREATE TABLE profiles_photo (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL,
    
    INDEX (user_id, photo_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id)
    );
    
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('1', '1');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('2', '2');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('1', '3');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('3', '4');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('4', '5');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('5', '6');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('6', '7');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('6', '12');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('7', '11');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('8', '10');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('9', '9');
INSERT INTO profiles_photo (user_id, photo_id) VALUES ('10', '8');

DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id SERIAL PRIMARY KEY,
	title VARCHAR (120),
	body TEXT,
	ISBN BIGINT UNSIGNED NOT NULL
);

INSERT INTO books VALUES ('1', 'Цветы для Элджернона', 'научно-фантастический рассказ Дэниела Киза («мягкая» научная фантастика)', '9785699413324'),
('2', 'Футурологический конгресс', 'Книга, без которой не существовало бы трилогии «Матрица»', '9785170903436'),
('3', 'Мастер и Маргарита', 'Чтобы спасти любимого, гениального Мастера, Маргарита готова продать душу дьяволу...',	'9789661456425'),
('4', 'Загнанных лошадей пристреливают, не правда ли?',	'Если прибегнуть к обобщению, он повествует о судьбе целого поколения и каждого человека, о его одиночестве и мечтах, обреченных на вечное "несвершение"', '535200922'),
('5', 'Ноmo Deus. Краткая история будущего','"HomoDeus" продолжает логику первой книги, отвечая на вопрос: мы — венец творения. И что дальше?', '9785906837929'),
('6', 'Sapiens. Краткая история человечества', 'Как наука и капитализм стали господствующими вероучениями современной эры? Становились ли люди с течением времени счастливее? Какое будущее нас ожидает?', '9785905891960');

DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR (55) COMMENT 'Имя автора',
	surname VARCHAR (55) COMMENT 'Фамилия автора',
	body TEXT COMMENT 'Биография автора',
    
    INDEX authors_firstname_surname_idx(firstname, surname)
);

INSERT INTO authors VALUES ('1', 'Михаил', 'Булгаков', 'Михаил Афанасьевич Булгаков родился 3 (15) мая 1891 года 
(согласно дневникуЕлены Сергеевны Булгаковой праздновал день рождения 16 мая[a]) в семье доцента (с 1902 года — профессора)
 Киевской духовной академии Афанасия Ивановича Булгакова (1859—1907) и его жены, преподавательницы женской прогимназии, 
 Варвары Михайловны (в девичестве — Покровской; 1869—1922),
 в 1890 году начавших совместную жизнь, на Воздвиженской улице, 28 в Киеве.'),
 
 ('2', 'Станислав',	'Лем',	'Стани́слав Ге́рман Лем (польск. Stanisław Herman Lem; 12 сентября 1921, Львов, Польша — 27 марта 2006, Краков, Польша)
 — польский философ, футуролог и писатель (фантаст, эссеист, сатирик, критик). Его книги переведены на 41 язык, продано более 30 млн экземпляров[8]. 
 Автор фундаментального философского труда «Сумма технологии», в котором предвосхитил создание виртуальной реальности, искусственного интеллекта,
 а также развил идеи автоэволюции человека, сотворения искусственных миров и многие другие.'),
 
('3', 'Хорас', 'Маккой', 'Хорас МакКой (англ. Horace McCoy; 14 апреля 1897 — 15 декабря 1955) — американский писатель и сценарист. 
Родился в штате Теннесси, во время Первой мировой войны служил в авиации США, участвовал в боевых вылетах, был ранен. 
После возвращения в США в 1919—1930 гг. работал редактором отдела спорта в одной из газет Далласа. 
Затем отправился в Голливуд, где сперва пробовал себя в качестве актёра, затем работал сценаристом — в том числе с такими режиссёрами, 
как Генри Хэтэуэй, Николас Рэй и Рауль Уолш.'),
	
('4', 'Юваль Ной','Харари',	'Юваль Ной Харари родился 24 февраля 1976 года в городе Кирьят-Ата (Израиль), в семье ливанских и восточно-европейских евреев. 
С 1993 по 1998 год учился в Еврейском университете в Иерусалиме, изучая средневековую и военную истории. 
После учился в Оксфордском колледже Иисуса, где в 2002 году защитил докторскую диссертацию и вернулся в Израиль,
а с 2003 по 2005 год занимался постдокторантурой под эгидой благотворительного фонда Yad Hanadiv.'),
	
('5', 'Дэниэл',	'Киз', 'Дэниел Киз родился в Бруклине, в семье еврейских эмигрантов из Российской империи Уильяма Киза и Бетти Алицки. 
Семья его матери перебралась с Украины в Монреаль в конце XIX века. Отец держал магазин подержанных вещей, мать работала косметологом.');

DROP TABLE IF EXISTS book_author;
CREATE TABLE book_author (
	id SERIAL PRIMARY KEY,
	book_id BIGINT UNSIGNED NOT NULL,
	author_id BIGINT UNSIGNED NOT NULL,
    
	FOREIGN KEY (book_id) REFERENCES books(id),
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

INSERT INTO book_author VALUES ('1', '1', '5'),
('2', '2', '2'),
('3', '3', '1'),
('4', '4', '3'),
('5', '5', '4'),
('6', '6', '4');

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	type VARCHAR (55),
    
    KEY genres_type_idx(type)
);

INSERT INTO genres VALUES ('1', 'Художественная литерарура'),	
('2', 'Нон-фикшн'),
('3', 'Научная фантастика');

DROP TABLE IF EXISTS genres_author;
CREATE TABLE genres_author (
	id SERIAL PRIMARY KEY,
	author_id BIGINT UNSIGNED NOT NULL,
	genres_id BIGINT UNSIGNED NOT NULL,
    
    INDEX genres_author_author_id_genres_id (author_id, genres_id),
	FOREIGN KEY (author_id) REFERENCES authors(id),
	FOREIGN KEY (genres_id) REFERENCES genres(id)
);

INSERT INTO genres_author (author_id, genres_id) VALUES ('1', '2');
INSERT INTO genres_author (author_id, genres_id) VALUES ('2', '3');
INSERT INTO genres_author (author_id, genres_id) VALUES ('2', '2');
INSERT INTO genres_author (author_id, genres_id) VALUES ('4', '2');
INSERT INTO genres_author (author_id, genres_id) VALUES ('3', '1');
INSERT INTO genres_author (author_id, genres_id) VALUES ('5', '1');
INSERT INTO genres_author (author_id, genres_id) VALUES ('5', '3');

DROP TABLE IF EXISTS quotos;
CREATE TABLE quotos (
	id SERIAL PRIMARY KEY,
	book_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
    
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO quotos VALUES ('1',	'4','С человеком может произойти нечто, о чем он думает, будто раньше с ним подобного не бывало, нечто, 
казалось бы, совершенно новое, но это ошибка. Достаточно увидеть, услышать или почувствовать это новое,
и сразу же становится ясно, что все это однажды уже случалось с ним.'),

('2', '1', 'Я похож на человека, который проспал полжизни, а теперь пытается узнать, кем он был, пока спал.'),

('3', '1', 'Простейшая идея. Доверяй себе.'),

('4', '5',	'Испокон веков власть подразумевала доступ к информации. Сегодня власть подразумевает знание, на что не надо отвлекаться.'),

('5', '5', 'Но в наше дни философы, политики и даже некоторые экономисты призывают заменить ВВП на ВНС - валовое национальное счастье.
 В конце концов, чего хотят люди? Они не хотят производить. Они хотят быть счастливыми.');
 
DROP TABLE IF EXISTS quotos_user;
CREATE TABLE quotos_user (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	quotos_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quotos_id) REFERENCES quotos(id)
);

INSERT INTO quotos_user (user_id, quotos_id) VALUES ('4', '1');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('1', '3');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('2', '2');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('3', '5');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('5', '1');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('7', '5');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('6', '4');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('10', '3');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('8', '5');
INSERT INTO quotos_user (user_id, quotos_id) VALUES ('2', '1');


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	gender ENUM ('M', 'F'), 
	birthday DATE,
	hometown VARCHAR(100),
	profile_photo_id BIGINT UNSIGNED NOT NULL,
	joined_at DATETIME,
	user_name VARCHAR(100),
	website VARCHAR(100),
	about_me TEXT,
	updates DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (profile_photo_id) REFERENCES profiles_photo(id)
);

INSERT INTO profiles (user_id, gender, birthday, hometown, profile_photo_id, joined_at, user_name, website, about_me) 
VALUES
('1', 'M', '1990-01-10', 'Москва', '3', '2019-10-01 12:30:51','Vasyaaa', 'www.ilovebooks.com', ''),
('2', 'F', '1980-01-02', 'Санкт-Петербург', '2', '2010-02-21 12:50:00', '', '', 'Book lover!'),
('3', 'F', '2000-12-03', 'Астрахань', '4', '2008-02-21 12:50:00', 'NikaNikaNika', 'www.nikaweb.com', 'Fond of reading'),
('4', 'F', '1960-07-27', 'Москва', '5', '2020-02-20 12:50:00', '', '', ''),
('5', 'M', '1973-05-03', 'Санкт-Петербург',	'6', '2019-12-30 12:50:00','Andrew', 'www.andrew.com', 'About me'),
('6', 'M', '2005-01-10', 'Самара', '8', '2009-01-02 22:00:30', 'Nikname', 'nikname.com', 'Smth'),
('7', 'F', '2010-07-01', 'Москва',	'9', '2000-01-02 22:00:30', '', '', ''),
('8', 'F', '1999-08-11', 'Москва',	'10', '2010-01-02 22:00:30', '', '', 'about'),
('9', 'F', '1972-01-01', 'Санкт-Петербург', '11', '2000-01-02 22:00:30', 'Booklover', 'booklover.com', 'Im 30 y.o'),
('10', 'M',	'1987-10-10', 'Астрахань', '12', '2008-01-02 22:00:30', '', '', '');


DROP TABLE IF EXISTS users_books;
CREATE TABLE users_books (
	user_id BIGINT UNSIGNED NOT NULL,
	book_id BIGINT UNSIGNED NOT NULL,
	status ENUM ('read', 'currently reading', 'want to read'),
    
    PRIMARY KEY (user_id, book_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO users_books (user_id, book_id, status)
VALUES
('2', '2','read'),
('2', '1', 'want to read'),	
('2', '6', 'currently reading'),
('4', '5', 'currently reading'),	
('5', '4','read'),
('6', '3', 'currently reading'),
('7', '6', 'want to read');

DROP TABLE IF EXISTS covers;
CREATE TABLE covers (
	id SERIAL PRIMARY KEY,
	filename VARCHAR (55)
);

INSERT INTO covers (filename)
VALUES ('pic100.jpeg'),
('pic22.jpeg'),
('pic33.jpeg'),
('pic4.jpeg'),
('pic5.jpeg'),
('pic6.jpeg'),
('pic7.jpeg'),
('pic8.jpeg'),
('pic9.jpeg'),
('pic10.jpeg');


DROP TABLE IF EXISTS book_covers;
CREATE TABLE book_covers (
	id SERIAL PRIMARY KEY,
	book_id BIGINT UNSIGNED NOT NULL,
	cover_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (cover_id) REFERENCES covers(id)
);

INSERT INTO book_covers (book_id, cover_id)
VALUES ('2', '1'),
('5','3'),
('1', '4'),
('3', '5'),
('4', '6'),
('6', '8'),
('6', '7'),
('1', '9'),
('1', '10');


DROP TABLE IF EXISTS friend_requested;
CREATE TABLE friend_requested (
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	status ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME,
	confirmed_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	PRIMARY KEY (from_user_id, to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);
      
INSERT INTO friend_requested (from_user_id, to_user_id, status, requested_at) 
VALUES ('1', '2','approved', '2000-01-01'),
('2', '3', 'requested', '2005-01-01'),
('4', '1', 'declined', '2009-01-01'),
('5', '1', 'declined', '2019-01-01'),
('6', '2','approved', '2010-03-01'),
('7', '8', 'approved', '2018-01-10'),
('2', '6', 'requested', '2018-07-10'),
('3', '7', 'requested', '2018-09-10'),
('9','8', 'unfriended', '2015-01-10'),
('10', '2', 'unfriended','2018-01-10');


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO messages (from_user_id, to_user_id, body) 
VALUES ('2', '3', 'Привет! Как дела?'),
('4', '1', 'Классная рецензия книги'),
('6', '2', 'Нравится книга "Сияние"?'),
('2','9', 'Вступай в наш книжный клуб!');


DROP TABLE IF EXISTS books_info; 
CREATE TABLE books_info (
	book_cover_id BIGINT UNSIGNED NOT NULL,
	pages BIGINT UNSIGNED NOT NULL,
	date_published YEAR,
	get_a_copy VARCHAR(55),
	publisher VARCHAR(55),
    
	FOREIGN KEY (book_cover_id) REFERENCES book_covers(id)
);

INSERT INTO books_info VALUES ('9', '320', '2017', 'Ozon', 'Эксмо'),
('1', '167', '2020', 'Читай-город', 'АСТ'),
('5', '512', '2015', 'Ozon', 'АСТ'),
('5', '480', '2020', 'Ozon', 'Азбука'),
('6', '416', '2020', 'Читай-город', 'АСТ'),
('3', '496', '2018', 'Ozon', 'Синдбад'),
('7', '512', '2019', 'Ozon', 'Синдбад'),
('8', '520', '2017', 'Ozon', 'Синдбад');


/* 2. Cкрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы) */

-- SELECT
SELECT body FROM quotos;
SELECT surname, body FROM authors;
-- WHERE 
SELECT * FROM profiles WHERE gender = 'M';
SELECT * FROM profiles WHERE hometown = 'Москва';
SELECT * FROM users_books WHERE status = 'currently reading';
-- DISTINCT
SELECT distinct publisher FROM books_info;
-- BETWEEN
SELECT * FROM profiles WHERE user_id BETWEEN 3 AND 7;
SELECT * FROM profiles WHERE birthday BETWEEN '2000-01-01' AND '2010-01-01';
-- ORDER BY 
SELECT * FROM profiles WHERE hometown = 'Санкт-Петербург' order by user_id desc;
SELECT distinct hometown FROM profiles ORDER BY hometown;
SELECT user_id, SUBSTRING(birthday,1,3) AS decade FROM profiles ORDER BY decade;
-- LIKE
SELECT  * FROM profiles WHERE hometown LIKE 'Мо%';
SELECT  * FROM profiles WHERE hometown NOT LIKE 'Мо%';
SELECT * FROM profiles WHERE birthday LIKE '19%';
-- RAND
SELECT email FROM users ORDER BY RAND() LIMIT 1;
SELECT body FROM quotos ORDER BY RAND() LIMIT 1;
-- GROUP BY
SELECT publisher FROM books_info GROUP BY publisher;
SELECT hometown FROM profiles GROUP BY hometown;
-- COUNT
SELECT COUNT(user_id) from profiles;
SELECT COUNT(*), SUBSTRING(birthday,1,3) AS decade FROM profiles GROUP BY decade ORDER BY decade desc;
-- HAVING
SELECT * FROM profiles HAVING birthday > '2000-01-01';
SELECT * FROM books_info HAVING publisher = 'АСТ';

-- UNION
SELECT * FROM photos 
UNION 
SELECT * FROM covers;

SELECT body as description FROM books
UNION
SELECT body from authors;

-- Вложенные таблицы
SELECT
  book_id, body 
FROM 
  quotos 
WHERE
  book_id = (SELECT id from books WHERE title = 'Ноmo Deus. Краткая история будущего');

SELECT
 body,
 (SELECT title from books WHERE id = book_id) as 'Book name'
FROM 
  quotos;
  
-- JOIN'ы
SELECT books.title, genres.type FROM genres JOIN books;
  
SELECT 
  p.hometown, u.firstname, u.surname 
FROM 
  profiles as p 
JOIN 
  users as u
ON u.id = p.user_id;

SELECT
 *
FROM 
  genres as fst
JOIN
  genres as snd
USING (id);

SELECT 
	firstname, surname, email, phone, gender, birthday, hometown
  FROM profiles
    JOIN users ON users.id = profiles.user_id
  WHERE users.id = 1;
  
SELECT m.body as 'Cообщение', u.firstname, u.surname, m.created_at
  FROM messages as m
    JOIN users as u ON u.id = m.to_user_id
  WHERE u.id = 2;
  
  SELECT m.body as 'Cообщение', u.firstname, u.surname, m.created_at
  FROM messages as m
    JOIN users as u ON u.id = m.from_user_id
  WHERE u.id = 2;
  
  SELECT firstname, surname, COUNT(*) AS friends
  FROM users
    JOIN friend_requested ON (users.id = friend_requested.from_user_id or users.id = friend_requested.to_user_id)
  WHERE friend_requested.status = 'approved'
  GROUP BY users.id;
  
  SELECT  u.firstname, u.surname, COUNT(*) AS total_friends
  FROM users as u
  JOIN friend_requested as f ON u.id = f.to_user_id and f.from_user_id
  WHERE f.status = 'approved'
  GROUP BY u.id;
  
   SELECT  firstname, middlename, surname, COUNT(*) AS total_friends
  FROM users as u
  JOIN friend_requested as f ON u.id = f.to_user_id and f.from_user_id
  WHERE f.status = 'unfriended'
  GROUP BY u.id;
  
  /* 3. Представления (минимум 2), хранимые процедуры / триггеры */
  -- Переменные
  SELECT @month := NOW() - INTERVAL 5 MONTH;
  SELECT CURDATE(), @month;
  
  SELECT @title := title FROM books;
  
  -- Представления
  CREATE VIEW friends AS SELECT firstname, middlename, surname, COUNT(*) AS total_friends
  FROM users as u
  JOIN friend_requested as f ON u.id = f.to_user_id and f.from_user_id
  WHERE f.status = 'unfriended'
  GROUP BY u.id;
  
  SELECT * FROM friends;
  
CREATE VIEW book_stats AS SELECT firstname, surname, COUNT(*) AS total_books
  FROM users 
    JOIN users_books ON users.id = users_books.user_id
	  GROUP BY users.id;
      
 SELECT * FROM book_stats;
 
 SHOW TABLES;
 
DROP VIEW IF EXISTS friends, book_stats;

-- Хранимые процедуры
SHOW PROCEDURE STATUS;

DELIMITER //
CREATE PROCEDURE test ()
BEGIN 
  SELECT VERSION();
END //
DELIMITER ;

CALL test();
SHOW CREATE PROCEDURE test;

-- Триггеры
DELIMITER //
CREATE TRIGGER user_count AFTER INSERT ON users
FOR EACH ROW
BEGIN 
  SELECT COUNT(*) INTO @total FROM users;
END //

INSERT INTO users VALUES ('12', 'Maria', 'Vasilievna', 'Petrova', 'petrova1@mail.ru', '8925330020')//
SELECT * FROM users;
SELECT @total//