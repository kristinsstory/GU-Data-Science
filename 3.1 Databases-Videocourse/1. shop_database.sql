CREATE SCHEMA `shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE `shop`.`category` (
  `idcategory` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `discount` TINYINT NOT NULL,
  PRIMARY KEY (`idcategory`));
  
ALTER TABLE `shop`.`category` 
ADD COLUMN `alias_name` VARCHAR(128) NULL AFTER `discount`;

CREATE TABLE `shop`.`brand` (
  `idbrand` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`idbrand`));

CREATE TABLE `shop`.`product_type` (
  `idproduct_type` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`idproduct_type`));
  
INSERT INTO `shop`.`category` (`idcategory`, `name`, `discount`) VALUES ('1', 'Женская одежда', '5');
INSERT INTO `shop`.`category` (`idcategory`, `name`, `discount`) VALUES ('2', 'Мужская одежда', '0');

ALTER TABLE `shop`.`category` 
CHANGE COLUMN `idcategory` `idcategory` INT(11) NOT NULL AUTO_INCREMENT ;

INSERT INTO category (idcategory, name, discount, allias_name) VALUES(3, 'Женская обувь', 10, null);
INSERT INTO category (idcategory, name, discount, allias_name) VALUES(4, 'Мужская обувь', 15, 'man''s shoes');
INSERT INTO category (name, discount) VALUES ('Шляпы', 0);

CREATE TABLE `shop`.`product` (
  `id` INT NOT NULL,
  `brand_id` INT NOT NULL,
  `product_type_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`));
  
Insert into shop.brand (idbrand, name) values (10, 'Тетя Клава');
delete from shop.brand where id = 10;


ALTER TABLE `shop`.`product` 
ADD CONSTRAINT `fk_brand_product`
  FOREIGN KEY (`brand_id`)
  REFERENCES `shop`.`brand` (`idbrand`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  ALTER TABLE `shop`.`product` 
  DROP FOREIGN KEY `fk_brand_product`;
  ALTER TABLE `shop`.`product` 
  ADD CONSTRAINT `fk_brand_product`
  FOREIGN KEY (`brand_id`)
  REFERENCES `shop`.`brand` (`idbrand`)
  ON DELETE CASCADE;
  
  
SELECT * FROM shop.product;
use shop;
INSERT INTO product (brand_id, product_type_id, category_id, price) Values (1, 1, 1, 8999);
INSERT INTO product (brand_id, product_type_id, category_id, price) Values (10, 1, 1, 8999);
INSERT INTO product (brand_id, product_type_id, category_id, price) Values (20, 1, 1, 8999);  

ALTER TABLE `shop`.`product` 
ADD INDEX `fr_category_product_idx` (`category_id` ASC) VISIBLE,
ADD INDEX `fk_category_product_type_idx` (`product_type_id` ASC) VISIBLE;
;
ALTER TABLE `shop`.`product` 
ADD CONSTRAINT `fr_category_product`
  FOREIGN KEY (`category_id`)
  REFERENCES `shop`.`category` (`idcategory`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_product_type_product`
  FOREIGN KEY (`product_type_id`)
  REFERENCES `shop`.`product_type` (`idproduct_type`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

CREATE TABLE `shop`.`order` (
  `idorder` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(128) NOT NULL,
  `phone` VARCHAR(32) NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`idorder`));
  
CREATE TABLE `shop`.`order_products` (
  `order_id` INT NOT NULL,
  `product_id` VARCHAR(45) NOT NULL,
  `count` VARCHAR(45) NULL,
  PRIMARY KEY (`order_id`, `product_id`));
  
  
UPDATE `shop`.`product` SET `brand_id` = '1', `product_type_id` = '2', `price` = '7999.00' WHERE (`id` = '2');
INSERT INTO `shop`.`product` (`id`, `brand_id`, `product_type_id`, `category_id`, `price`) VALUES ('3', '2', '1', '3', '6999.00');
  
CREATE TABLE `shop`.`user_bank_account` (
  `id` INT NOT NULL,
  `money` DECIMAL(10,2) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
