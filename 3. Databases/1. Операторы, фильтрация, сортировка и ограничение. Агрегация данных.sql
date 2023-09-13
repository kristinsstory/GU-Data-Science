DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамиль', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    -- INDEX users_phone_idx(phone), -- помним: как выбирать индексы
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- пока рано, т.к. таблицы media еще нет
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (значение по умолчанию)
    ON DELETE restrict; -- (значение по умолчанию)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    -- `status` TINYINT UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),

	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

    -- записей мало, поэтому индекс будет лишним (замедлит работу)!
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) – можно было и так вместо id в качестве PK
  	-- слишком увлекаться индексами тоже опасно, рациональнее их добавлять по мере необходимости (напр., провисают по времени какие-то запросы)  

    ,FOREIGN KEY (user_id) REFERENCES users(id)
    ,FOREIGN KEY (media_id) REFERENCES media(id)

);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

 -- Добавить 3 свои таблицы

DROP TABLE IF EXISTS music;
CREATE TABLE music(
    id SERIAL PRIMARY KEY,
    name VARCHAR(120),
    author VARCHAR(120),
    media_id BIGINT unsigned NOT NULL,
    
    INDEX music_name_author_idx(name, author),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS users_music;
CREATE TABLE users_music(
    user_id BIGINT UNSIGNED NOT NULL,
    music_id BIGINT UNSIGNED NOT NULL,
    date_added DATETIME,
  
    PRIMARY KEY (user_id, music_id), 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (music_id) REFERENCES music(id)
);

DROP TABLE IF EXISTS gifts;
CREATE TABLE gifts(
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    name TEXT,
    body TEXT,
	send_at DATETIME,
    
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- i. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)

INSERT INTO `users` VALUES ('1','Gabriella','Ondricka','barrows.howell@hotmail.com','130745'),
('2','Josie','Mante','doberbrunner@hayes.org','575'),
('3','Macey','Douglas','wyman.kitty@hotmail.com','778434'),
('4','Skye','Homenick','lia57@hotmail.com','76'),
('5','Elwyn','Morissette','rudolph.torp@croninschinner.org','0'),
('6','Rogelio','Wunsch','lschaden@yahoo.com','1'),
('7','Kody','Dare','bbartell@batzparisian.com','1132027348'),
('8','Hollis','Daugherty','abe17@gmail.com','893400'),
('9','Glen','Schroeder','carlee07@becker.com','86'),
('10','Dorothy','Langosh','hazel22@dickinsonemard.com','1'); 


INSERT INTO `messages` VALUES ('1','1','1','Quasi omnis consequatur voluptas sequi qui voluptas aut. Quo culpa sequi id expedita et. Aut quisquam rerum et amet numquam. Natus quia cupiditate atque ex minima accusamus ipsum.','2019-03-22 06:19:08'),
('2','2','2','Et libero non dolorum. Sint excepturi debitis consequuntur. Beatae quis non qui. Quia vel mollitia facilis voluptas et corrupti.','1996-01-23 19:56:04'),
('3','3','3','Error facilis velit magnam. Repellat eum magnam consequatur sapiente voluptas. Quaerat in ut porro aspernatur quis facilis numquam. Cum voluptatem provident ut blanditiis hic.','1997-06-25 08:23:58'),
('4','4','4','Atque omnis tempore quia corrupti illo. Aut et et natus est quam hic dicta. Magnam possimus neque quis quis aut.','2012-05-05 19:49:33'),
('5','5','5','Autem ipsum totam est quod. Ea molestias autem eaque unde esse omnis. Hic est corrupti vel optio omnis aut. Dolorem quia quam nobis.','2001-09-08 10:26:56'),
('6','6','6','Molestiae expedita sint quaerat. Ut aperiam expedita iste voluptas nostrum. Eos consequuntur quia beatae. Dolorum et eaque a consectetur.','2010-12-02 14:50:25'),
('7','7','7','Itaque doloribus ratione molestiae laboriosam expedita atque est. Sunt optio enim sed natus. Incidunt similique non ad est dolor excepturi. Vel est vitae rerum aut iusto in ducimus.','1996-03-05 11:35:27'),
('8','8','8','Ullam voluptas et fugiat asperiores quo quia. In soluta nemo quibusdam fugiat consequuntur itaque. Corporis consequuntur voluptatibus dolor illo amet accusamus veritatis.','1997-07-01 07:54:02'),
('9','9','9','Occaecati odit ut ut est. Harum earum ullam incidunt id quidem quas sunt. Velit similique at beatae. Qui non at ullam similique delectus optio.','1971-09-27 17:14:56'),
('10','10','10','Est voluptate aperiam voluptatibus accusantium est rem. Dolorem eum cumque maxime maxime sit est sed.','2000-04-07 13:48:44'),
('11','1','1','Quisquam odio qui dolorum explicabo maiores fuga maxime. Fuga quidem maxime dolores nisi. Omnis aut aut quisquam eaque eveniet.','2008-08-03 15:12:34'),
('12','2','2','Dolor deserunt et ad hic quod autem. Et quasi quo cupiditate occaecati. Quod deleniti omnis qui ut vel.','1980-08-02 05:31:58'),
('13','3','3','Ullam aperiam ex nihil. Est minima distinctio laborum ut eligendi rem. Corporis dolores praesentium necessitatibus et non est. Est et aspernatur numquam id et.','1988-09-21 09:39:38'),
('14','4','4','Deleniti doloribus dolorem neque dolor et. Voluptate sit perferendis sunt. Similique provident ad quia repudiandae consequatur.','2013-06-23 14:34:50'),
('15','5','5','Unde perferendis cum ab et esse. Non est quisquam explicabo aspernatur libero. Voluptas ut sunt consequuntur ipsum qui. Eum architecto id facere aliquid ea illum. Fugit vel velit pariatur dolor.','2019-06-22 19:29:04'),
('16','6','6','Quidem dolorum voluptates sunt harum ratione. Quae rerum nihil porro animi dolorem. Quaerat aperiam assumenda aperiam eveniet.','1973-07-28 22:09:00'),
('17','7','7','Voluptas aut tenetur id ut. Asperiores molestiae at et. Distinctio eum voluptatem magnam sed. Perferendis quia omnis sunt architecto consequatur voluptatem doloremque.','2009-05-26 05:24:48'),
('18','8','8','Doloribus excepturi modi recusandae repellat quo fugiat officia. Non quos ipsam non porro ut dolorum rerum. Culpa dolor et consequatur alias enim consequuntur.','1999-06-26 00:53:44'),
('19','9','9','Aut eius vel voluptas dolorem. Voluptates veniam omnis officia voluptatum aliquam temporibus placeat omnis. Vel accusantium expedita fugiat soluta est quis aut. Voluptas minus sed ipsa natus.','1980-09-16 02:45:44'),
('20','10','10','Deserunt quasi voluptatem odit occaecati. Dolore velit quasi rem dignissimos quae voluptate. Ipsa omnis vero molestias et tenetur.','1970-10-21 09:23:46'),
('21','1','1','Quo rem libero voluptatibus voluptatem voluptatem ex. Commodi ratione aut sit est. Autem veritatis sit et repellendus soluta.','1977-04-18 02:35:58'),
('22','2','2','Id rem qui soluta tempora quam. Illo qui dolor doloremque sed.','1977-08-01 03:24:55'),
('23','3','3','Dolores quibusdam dolores voluptatem atque est quas. Eos laboriosam omnis optio incidunt. Voluptates incidunt eum non consequatur id. Dignissimos ea excepturi omnis quasi.','1981-07-14 04:21:33'),
('24','4','4','Natus inventore eveniet voluptatem iure quo. Voluptas et quidem quis consequuntur ut accusamus illo numquam. Vel est nihil animi facilis commodi vitae quia. Et doloremque possimus at sunt commodi.','1980-03-13 12:51:02'),
('25','5','5','Ut delectus aut nihil nostrum expedita. Nulla qui dolorem rerum. Dicta quae deserunt molestias laudantium rerum voluptatibus. Et molestiae quaerat et distinctio magnam.','1979-12-23 08:06:35'),
('26','6','6','Deserunt mollitia sit expedita laudantium repellat blanditiis. Qui qui eaque ut delectus ut. Accusamus quidem aspernatur deserunt laborum aut consequuntur dignissimos. Nihil tenetur mollitia tempore id nostrum assumenda.','1988-03-26 06:24:24'),
('27','7','7','Hic nulla et qui quia adipisci voluptas. Voluptas harum neque deleniti provident et et vero. Dolor sint voluptate perferendis minus nisi veniam consequatur.','2007-08-12 02:39:34'),
('28','8','8','Ipsum deserunt est officia temporibus quod voluptas earum. Voluptas sequi maxime qui quam necessitatibus enim consectetur. Voluptatem mollitia aut velit doloribus voluptas ex at tempore. Quo dicta non dolorem et natus autem dolores.','1996-12-01 04:11:09'),
('29','9','9','Et explicabo eos quisquam odio sit expedita. Veritatis debitis reiciendis repellendus nam. Asperiores quia voluptatem corporis eligendi nostrum voluptatem. Nulla quisquam qui et hic itaque.','1972-04-16 08:27:01'),
('30','10','10','Neque qui culpa quasi eum officia. Cum ut nam quo itaque. Non non aut aut sit. Sit eum nesciunt magni fugit commodi consequatur. Distinctio omnis eos libero totam ut voluptatem quidem.','2008-08-23 07:03:01'); 

INSERT INTO `communities` VALUES ('4','a'),
('10','corporis'),
('5','excepturi'),
('6','inventore'),
('9','nam'),
('1','nihil'),
('2','officia'),
('8','possimus'),
('7','quo'),
('3','quos'); 


INSERT INTO `users_communities` VALUES ('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'); 

INSERT INTO `friend_requests` VALUES ('1','1','unfriended','1986-04-30 05:44:37','2010-02-13 13:26:23'),
('2','2','declined','1981-11-29 20:06:00','2009-03-26 19:01:06'),
('3','3','declined','1973-04-10 17:06:42','2000-02-17 07:27:02'),
('4','4','approved','1980-07-23 06:01:35','2013-11-14 02:39:40'),
('5','5','declined','1977-04-28 21:30:34','1985-08-16 15:58:25'),
('6','6','requested','2012-12-27 17:44:05','2004-06-10 18:06:40'),
('7','7','declined','1990-09-22 23:55:23','1997-05-31 19:47:47'),
('8','8','declined','1976-11-02 23:54:47','2006-11-08 16:47:38'),
('9','9','requested','1992-12-08 16:39:38','1984-09-22 00:20:56'),
('10','10','declined','1983-02-17 05:39:39','2013-04-05 14:53:08'); 

INSERT INTO `media` VALUES ('1','1','1','Voluptas perspiciatis hic commodi et consequuntur atque enim. Est ut molestias dolores sit a. Consequatur sed excepturi omnis repellendus laborum sint.','qui','0',NULL,'2015-09-19 08:44:19','2020-03-11 13:04:16'),
('2','2','2','Alias quasi ea nam dolor quos non aut. Aut reiciendis nulla quae consequuntur beatae. Consequatur animi consectetur labore et distinctio ipsam incidunt. Ut expedita a quis.','similique','0',NULL,'2015-09-30 22:38:26','2020-12-08 09:52:05'),
('3','3','3','Iste in ea sit impedit sapiente quibusdam. Sequi aut omnis dolor autem tempore consequatur. Officia commodi dolorum fuga modi.','repellendus','3811516',NULL,'2015-12-05 09:39:46','2020-10-03 12:52:12'),
('4','4','4','Illum velit voluptates qui eos perspiciatis qui et. Ipsam omnis doloribus voluptatum dicta. Aut similique molestiae ex dolorum sunt esse sunt vel.','ad','282698733',NULL,'2015-09-29 23:50:44','2020-12-25 07:58:14'),
('5','5','5','Et numquam cupiditate dolore repellat. Temporibus voluptate occaecati architecto dolorum porro aliquam. Quia facere est at excepturi quas aut nemo quos. Aut autem laudantium dolor quas blanditiis.','molestiae','765270',NULL,'2015-05-23 18:58:26','2020-02-23 19:02:00'),
('6','6','6','Quia rem in et esse ipsa aperiam. Ipsam non sed id fuga dolorem dolore est sint. Non corrupti deleniti quibusdam hic placeat mollitia.','dolores','0',NULL,'2015-01-12 09:31:23','2020-09-22 16:18:54'),
('7','7','7','Ut et dolores voluptates ratione. Modi sed magni deleniti corporis illo dolore necessitatibus pariatur. Numquam sequi in earum praesentium dolorum nihil aut. Nostrum aut et quia voluptate aut nihil maxime.','eius','32242995',NULL,'2015-09-09 14:16:48','2020-02-15 09:51:59'),
('8','8','8','Quos natus fugiat consectetur eum assumenda enim perferendis. Et aut veniam aut voluptas autem et quis. Sed deleniti et temporibus modi veniam et aspernatur. Neque optio a reiciendis enim nulla vel.','incidunt','1026',NULL,'2015-11-18 13:10:40','2020-02-23 18:53:28'),
('9','9','9','Quis ut ut odit praesentium. Laboriosam cum dolor fuga distinctio. Saepe illum dicta sint. Sunt dicta quis voluptatem sint aut.','ea','9380558',NULL,'2015-06-08 05:08:43','2020-09-06 20:37:34'),
('10','10','10','Voluptatem qui iste maxime ratione. Vel eos architecto reiciendis odio reprehenderit. Nesciunt est corporis officiis qui aut occaecati aut.','unde','8676922',NULL,'2015-09-05 23:26:54','2020-02-03 14:41:55'),
('11','1','1','Incidunt corporis consequatur neque veritatis et voluptatibus. Saepe et qui debitis magnam soluta esse veniam sit. Id maiores animi repellendus atque est quasi quos.','officia','86869717',NULL,'2015-09-09 05:24:33','2020-04-08 14:20:13'),
('12','2','2','Voluptatem rerum pariatur ratione quibusdam. Odio iusto et quam cumque excepturi. Sit id enim aut.','amet','0',NULL,'2015-05-12 16:07:23','2020-04-06 02:03:19'),
('13','3','3','Velit reiciendis ut magni rem consequatur aut dolor. Ut accusamus minima unde alias quia impedit architecto. Aut quasi corporis quod et veritatis voluptas laboriosam.','quaerat','14755',NULL,'2015-11-28 13:13:47','2020-01-11 00:40:50'),
('14','4','4','Est neque sunt autem nobis doloribus nam. Natus autem nobis ut et error quisquam aperiam. Animi facere voluptatum dolorem modi.','corrupti','968456',NULL,'2015-10-02 09:26:48','2020-06-19 09:19:55'),
('15','5','5','Ducimus temporibus molestiae nesciunt omnis. Impedit et laborum voluptatibus illum corrupti sint. Consequatur libero a accusantium et dolorum tenetur sequi perspiciatis. Dolorem placeat voluptatem quibusdam placeat.','quis','1894137',NULL,'2015-11-27 22:05:29','2020-08-15 08:30:24'),
('16','6','6','Id ea hic iste sed ex. Quia qui sit suscipit non occaecati tempore consequatur. Vero repellat mollitia ea sit assumenda nobis minus. Totam autem error et quas.','adipisci','7',NULL,'2015-10-13 14:52:34','2020-06-07 08:12:36'),
('17','7','7','Sed fugit animi veniam maiores dolorem beatae. Qui sunt nulla sit sunt ratione veniam. Repellendus nesciunt nihil debitis cum quaerat qui. Laudantium sed quaerat excepturi iste.','neque','0',NULL,'2015-05-31 08:44:21','2020-10-27 17:18:45'),
('18','8','8','Dolore vero autem dolor illo ut. Voluptatem vitae libero enim aut. Beatae alias est molestiae reiciendis ut.','ut','8996',NULL,'2015-08-27 19:26:08','2020-03-25 00:17:13'),
('19','9','9','Alias vel corporis fugiat ab saepe sint. Error ut sed et quo qui tenetur quae. Provident ut ipsam animi fugit officiis sit commodi. Necessitatibus sunt porro aut iure.','delectus','428',NULL,'2015-07-01 17:43:32','2020-06-24 10:39:33'),
('20','10','10','Culpa quia molestias rem praesentium itaque. Assumenda esse sit quas nihil aut aliquid id. Placeat omnis laudantium distinctio quo.','culpa','195960425',NULL,'2015-02-01 07:28:29','2020-12-16 18:04:00'); 

INSERT INTO `likes` VALUES ('1','1','1','1977-06-10 10:20:10'),
('2','2','2','1998-09-18 04:30:34'),
('3','3','3','1972-02-24 21:19:41'),
('4','4','4','2013-07-18 17:23:49'),
('5','5','5','1982-12-02 19:31:27'),
('6','6','6','2018-07-17 10:00:21'),
('7','7','7','1994-01-06 20:45:00'),
('8','8','8','1991-01-14 00:24:15'),
('9','9','9','2013-03-19 04:29:05'),
('10','10','10','1980-05-06 19:08:59'); 

INSERT INTO `media_types` VALUES ('1','aliquid','1983-11-08 19:14:55','1982-12-29 07:38:49'),
('2','dolores','1984-05-16 13:29:29','1993-03-07 12:32:59'),
('3','adipisci','1986-05-28 00:42:42','1989-12-17 21:13:47'),
('4','cupiditate','1974-05-21 11:19:47','2013-06-08 08:38:51'),
('5','tempore','1978-11-13 06:48:09','2012-07-07 13:34:36'),
('6','autem','1998-11-16 20:12:31','1991-09-16 03:14:13'),
('7','autem','2015-05-10 13:51:32','1977-10-21 20:56:00'),
('8','voluptas','2019-03-13 06:06:18','1984-05-03 17:01:15'),
('9','sequi','1989-12-03 06:06:05','2019-09-06 14:06:18'),
('10','ea','1992-05-24 17:50:44','2000-08-01 20:39:44'); 

INSERT INTO `photo_albums` VALUES ('1','modi','1'),
('2','perspiciatis','2'),
('3','vel','3'),
('4','quibusdam','4'),
('5','doloribus','5'); 

INSERT INTO `photos` VALUES ('1','1','1'),
('2','2','2'),
('3','3','3'),
('4','4','4'),
('5','5','5'),
('6','1','6'),
('7','2','7'),
('8','3','8'),
('9','4','9'),
('10','5','10'),
('11','1','11'),
('12','2','12'),
('13','3','13'),
('14','4','14'),
('15','5','15'),
('16','1','16'),
('17','2','17'),
('18','3','18'),
('19','4','19'),
('20','5','20'); 

INSERT INTO `profiles` VALUES ('1','m','1978-03-11','1','1998-07-03 06:25:23','West Cullen'),
('2','m','1997-02-19','2','1986-09-14 08:19:29','Ornview'),
('3','m','1970-08-24','3','1997-10-03 04:03:13','Lewbury'),
('4','m','2010-03-15','4','2017-08-08 19:36:39','Port Rosalindabury'),
('5','m','1984-06-30','5','1980-05-25 19:47:33','East Lincolnfort'),
('6','m','1995-12-14','6','2004-01-28 23:27:02','New Salvador'),
('7','f','2015-04-22','7','1978-06-21 23:42:51','New Mervin'),
('8','f','2010-06-29','8','2007-09-30 08:01:46','Port Myrtis'),
('9','f','1984-08-02','9','1995-07-20 08:55:24','Wittingchester'),
('10','f','2001-10-30','10','2007-01-12 02:34:53','Vanessafurt'); 


-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT distinct firstname
from users
order by firstname;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false)
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

alter table vk.profiles add column is_active varchar(10) default True AFTER `birthday`;

SET SQL_SAFE_UPDATES=0;
UPDATE profiles
SET is_active = '0' 
WHERE birthday >= '2002-01-01';
SET SQL_SAFE_UPDATES=1;



