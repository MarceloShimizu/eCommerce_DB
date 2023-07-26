-- Project: eCommerce
-- Model: eCommerce
-- Version: 1.0
-- Created at: 2023-07-21
-- Modified at: 
-- Author: Marcelo Tiago Lopes Shimizu

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Database creation for the E-commerce scenario
create database ecommerce;
use ecommerce;

-- Creates table client_address_type
CREATE TABLE IF NOT EXISTS `ecommerce`.`client_address_type` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`client_address_type_name` VARCHAR(50) NOT NULL UNIQUE,
	`client_address_type_description` VARCHAR(255) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table client_address
CREATE TABLE IF NOT EXISTS `ecommerce`.`client_address` (
	`client_id` INT NOT NULL,
	`client_address_type_id` INT NOT NULL,
	`client_address` VARCHAR(100) NOT NULL,
	`client_address2` VARCHAR(50) NULL DEFAULT NULL,
	`client_address_number` INT NULL DEFAULT NULL,
	`client_address_suite` VARCHAR(15) NULL DEFAULT NULL,
	`client_address_city` VARCHAR(50) NULL DEFAULT NULL,
	`client_address_state` VARCHAR(50) NULL DEFAULT NULL COMMENT 'State or province',
	`client_address_country` VARCHAR(50) NULL DEFAULT NULL,
	`client_address_zip` VARCHAR(15) NULL DEFAULT NULL,
	`client_address_observation` VARCHAR(150) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	INDEX `fk_client_address_clients_idx` (`client_id` ASC) VISIBLE,
	PRIMARY KEY (`client_id`, `client_address_type_id`),
	INDEX `fk_client_address_client_address_type_idx` (`client_address_type_id` ASC) VISIBLE,
	CONSTRAINT `fk_client_address_clients`
		FOREIGN KEY (`client_id`)
		REFERENCES `ecommerce`.`clients` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_client_address_client_address_type`
		FOREIGN KEY (`client_address_type_id`)
		REFERENCES `ecommerce`.`client_address_type` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table client_phone_type
CREATE TABLE IF NOT EXISTS `ecommerce`.`client_phone_type` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`client_phone_type_name` VARCHAR(50) NOT NULL UNIQUE,
	`client_phone_type_description` VARCHAR(255) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table client_phone
CREATE TABLE IF NOT EXISTS `ecommerce`.`client_phone` (
	`client_id` INT NOT NULL,
	`client_phone_type_id` INT NOT NULL,
	`client_phone` VARCHAR(50) NULL DEFAULT NULL,
	`client_phone_ext` VARCHAR(50) NULL DEFAULT NULL,
	`client_phone_verified` TINYINT NULL DEFAULT NULL,
	`created_at` DATETIME NULL DEFAULT NULL,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`client_id`, `client_phone_type_id`),
	INDEX `fk_client_phone_client_phone_type_idx` (`client_phone_type_id` ASC) VISIBLE,
	CONSTRAINT `fk_client_phone_type`
		FOREIGN KEY (`client_phone_type_id`)
		REFERENCES `ecommerce`.`client_phone_type` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CONSTRAINT `fk_client_phone_client`
		FOREIGN KEY (`client_id`)
		REFERENCES `ecommerce`.`clients` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table clients
CREATE TABLE IF NOT EXISTS `ecommerce`.`clients` (
	`id` INT UNIQUE AUTO_INCREMENT PRIMARY KEY,
	`client_active` TINYINT NOT NULL,
	`client_first_name` VARCHAR(50) NOT NULL,
	`client_middle_name` VARCHAR(50) NULL DEFAULT NULL,
	`client_last_name` VARCHAR(50) NOT NULL,
	`client_birth_date` DATE NOT NULL,
	`client_email` VARCHAR(500) NOT NULL,
	`client_email_verified` TINYINT NULL DEFAULT NULL,
	`client_registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
    UNIQUE KEY (`client_first_name`, `client_last_name`, `client_birth_date`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table user_role_type
CREATE TABLE IF NOT EXISTS `ecommerce`.`user_role_type` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`user_role_name` VARCHAR(50) NOT NULL UNIQUE,
	`user_role_description` VARCHAR(255) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table user_role
CREATE TABLE IF NOT EXISTS `ecommerce`.`user_role` (
	`user_id` INT NOT NULL,
	`user_role_id` INT NOT NULL,
	`user_role_inserted_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`user_role_updated_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`user_id`, `user_role_id`),
	INDEX `fk_user_roles_idx` (`user_role_id` ASC) VISIBLE,
	CONSTRAINT `fk_user_roles_type`
		FOREIGN KEY (`user_role_id`)
		REFERENCES `ecommerce`.`user_role_type` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table users
CREATE TABLE IF NOT EXISTS `ecommerce`.`user` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_name` VARCHAR(50) NOT NULL,
	`user_password` VARCHAR(255) NULL DEFAULT NULL,
	`client_id` INT NOT NULL UNIQUE,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	UNIQUE KEY (`client_id`, `user_name`),
	INDEX `fk_users_clients_idx` (`client_id` ASC) VISIBLE,
	CONSTRAINT `fk_users_clients`
		FOREIGN KEY (`client_id`)
		REFERENCES `ecommerce`.`clients` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table user_session
CREATE TABLE IF NOT EXISTS `ecommerce`.`user_session` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL COMMENT 'user_id references the user_id field in the \'users\' table.',
	`token` VARCHAR(255) NOT NULL COMMENT 'Authentication token associated with the session.',
    `login_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`logout_time` DATETIME,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `ip_address` VARCHAR(45),
	PRIMARY KEY (`id`, `user_id`),
	INDEX `fk_user_session_user_idx` (`user_id` ASC) VISIBLE,
	CONSTRAINT `fk_user_session_user`
		FOREIGN KEY (`user_id`)
		REFERENCES `ecommerce`.`user` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table admin_role_type
CREATE TABLE IF NOT EXISTS `ecommerce`.`admin_role_type` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`admin_role_name` VARCHAR(50) NOT NULL UNIQUE,
	`admin_roles_description` VARCHAR(255) NOT NULL,
	`admin_permissions` VARCHAR(255) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table admin_role
CREATE TABLE IF NOT EXISTS `ecommerce`.`admin_role` (
	`admin_id` INT NOT NULL,
	`admin_role_type` INT NOT NULL,
	`admin_role_inserted_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`admin_role_updated_at` DATETIME NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`admin_id`, `admin_role_type`),
	INDEX `fk_admin_role_admin_roles_idx` (`admin_role_type` ASC) VISIBLE,
	CONSTRAINT `fk_admin_role_admin_role_type`
	FOREIGN KEY (`admin_role_type`)
		REFERENCES `ecommerce`.`admin_role_type` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table admin
CREATE TABLE IF NOT EXISTS `ecommerce`.`admin` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`employee_id` INT NOT NULL,
	`username` VARCHAR(30) NOT NULL UNIQUE,
	`password` VARCHAR(500) NULL DEFAULT NULL,
	`admin_created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`admin_created_by` INT NOT NULL COMMENT 'admin_created_by refers to employee_id',
	`admin_modified_at` DATETIME NULL DEFAULT NULL,
	`admin_modified_by` INT NULL DEFAULT NULL COMMENT 'admin_modified_by refers to employee_id',
	PRIMARY KEY (`id`, `employee_id`),
	CONSTRAINT `fk_employee_admin`
		FOREIGN KEY (`employee_id`)
		REFERENCES `ecommerce`.`employee` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table admin_session
CREATE TABLE IF NOT EXISTS `ecommerce`.`admin_session` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`admin_id` INT NOT NULL COMMENT 'user_id references the user_id field in the \'users\' table.',
	`token` VARCHAR(255) NOT NULL COMMENT 'Authentication token associated with the session.',
    `login_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`logout_time` DATETIME,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `ip_address` VARCHAR(45),
	PRIMARY KEY (`id`, `admin_id`),
	INDEX `fk_admin_session_idx` (`admin_id` ASC) VISIBLE,
	CONSTRAINT `fk_admin_session`
		FOREIGN KEY (`admin_id`)
		REFERENCES `ecommerce`.`admin` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table employee
CREATE TABLE IF NOT EXISTS `ecommerce`.`employee` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`employee_status` ENUM("Active", "Inactive") NOT NULL DEFAULT 'Active',
	`employee_role` VARCHAR(50) NOT NULL,
	`employee_first_name` VARCHAR(50) NOT NULL,
	`employee_middle_name` VARCHAR(50) NULL DEFAULT NULL,
	`employee_last_name` VARCHAR(50) NOT NULL,
	`employee_birth_date` DATETIME NOT NULL,
	`employee_phone` VARCHAR(50) NOT NULL,
	`employee_email` VARCHAR(500) NULL DEFAULT NULL,
	`employee_address` VARCHAR(100) NULL DEFAULT NULL,
	`employee_address2` VARCHAR(50) NULL DEFAULT NULL,
	`employee_city` VARCHAR(50) NULL DEFAULT NULL,
	`employee_state` VARCHAR(50) NULL DEFAULT NULL,
	`employee_zip` VARCHAR(15) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`, `employee_first_name`, `employee_last_name`, `employee_birth_date`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Create table suppliers
CREATE TABLE IF NOT EXISTS `ecommerce`.`suppliers` (
	`id` INT NOT NULL AUTO_INCREMENT COMMENT 'The first record must be that of the company itself to allow internal transfers between different stock locations.',
	`supplier_name` VARCHAR(255) NOT NULL,
	`supplier_contact` VARCHAR(150) NOT NULL,
	`supplier_phone` VARCHAR(50) NULL DEFAULT NULL,
	`supplier_email` VARCHAR(100) NULL DEFAULT NULL,
	`supplier_address` VARCHAR(250) NULL DEFAULT NULL,
	`supplier_zip` VARCHAR(50) NULL DEFAULT NULL,
	`supplier_city` VARCHAR(50) NULL DEFAULT NULL,
	`supplier_country` VARCHAR(50) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `supplier_name_UNIQUE` (`supplier_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table stock_movement
CREATE TABLE IF NOT EXISTS `ecommerce`.`stock_movement` (
	`id` INT AUTO_INCREMENT,
	`stock_id` INT NOT NULL,
	`supplier_id` INT NOT NULL COMMENT 'If it is internal transfer, between different location sites, the supplier_id must be the company itself and the purchase value must be kept.',
	`movement_type` ENUM("Entry", "Exit", "Transfer") NOT NULL DEFAULT 'Entry',
	`movement_date` DATE NOT NULL,
	`quantity` INT NOT NULL,
	`value_per_unit` DECIMAL(10,2) NOT NULL,
	`source_site_id` INT NULL DEFAULT NULL COMMENT 'source_site_id referst to sock_site_id,in case of stock transfer.',
	`destination_site_id` INT NOT NULL COMMENT 'destination_site_id referst to sock_site_id, destination of the product.',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
	UNIQUE KEY (`stock_id`, `supplier_id`, `movement_type`, `movement_date`, `quantity`, `value_per_unit`, `destination_site_id`),
	INDEX `fk_stock_movement_stock_idx` (`stock_id` ASC) VISIBLE,
	INDEX `fk_stock_movement_suppliers_idx` (`supplier_id` ASC) VISIBLE,
	INDEX `fk_stock_movement_stock_site_idx` (`destination_site_id` ASC) VISIBLE,
	CONSTRAINT `fk_stock_movement_stock`
		FOREIGN KEY (`stock_id`)
		REFERENCES `ecommerce`.`stock` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CONSTRAINT `fk_stock_movement_suppliers`
	FOREIGN KEY (`supplier_id`)
		REFERENCES `ecommerce`.`suppliers` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CONSTRAINT `fk_stock_movement_stock_site`
		FOREIGN KEY (`destination_site_id`)
		REFERENCES `ecommerce`.`stock_site` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table stock_site
CREATE TABLE IF NOT EXISTS `ecommerce`.`stock_site` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stock_name` VARCHAR(50) NOT NULL,
  `stock_address` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `stock_name_UNIQUE` (`stock_name` ASC) VISIBLE,
  CONSTRAINT `fk_stock_site_stock`
    FOREIGN KEY (`id`)
    REFERENCES `ecommerce`.`stock` (`stock_site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table stock
CREATE TABLE IF NOT EXISTS `ecommerce`.`stock` (
	`id` INT NOT NULL AUTO_INCREMENT COMMENT 'The stock number(internal number) of the product.',
	`stock_site_id` INT NOT NULL,
	`quantity` INT NOT NULL,
	PRIMARY KEY (`id`),
    INDEX `fk_stock_stock_site_idx` (`stock_site_id` ASC) VISIBLE,
	CONSTRAINT `fk_stock_product`
		FOREIGN KEY (`id`)
		REFERENCES `ecommerce`.`product` (`stock_id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table product_category
CREATE TABLE IF NOT EXISTS `ecommerce`.`product_category` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`category_name` VARCHAR(50) NOT NULL,
	`category_description` VARCHAR(255) NULL DEFAULT NULL,
	`created_at` DATETIME NULL DEFAULT NULL,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table product_discount
CREATE TABLE IF NOT EXISTS `ecommerce`.`product_discount` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`discount_name` VARCHAR(50) NOT NULL,
	`discount_description` VARCHAR(250) NULL DEFAULT NULL,
	`discount_valid` TINYINT NOT NULL COMMENT 'The discount is valid or not.',
	`discount_valid_from` DATETIME NOT NULL,
	`discount_valid_until` DATETIME NOT NULL,
	`discount_percentage` DECIMAL(2,2) NOT NULL COMMENT '0.0 to 1.0',
    `discount_validated_by` INT,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `discount_name_UNIQUE` (`discount_name` ASC) VISIBLE,
	CONSTRAINT `fk_discount_validated_by_employee`
		FOREIGN KEY (`discount_validated_by`)
        REFERENCES `ecommerce`.`employee` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT `chk_discount_percentage`
		CHECK (`discount_percentage` BETWEEN 0.00 AND 1.00))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table product
CREATE TABLE IF NOT EXISTS `ecommerce`.`product` (
	`id` INT AUTO_INCREMENT,
	`product_name` VARCHAR(50) NOT NULL,
	`product_cart_description` VARCHAR(250) NULL DEFAULT NULL,
	`product_short_description` VARCHAR(1000) NULL DEFAULT NULL,
	`product_long_description` LONGTEXT NULL DEFAULT NULL,
	`product_thumb` VARCHAR(100) NULL DEFAULT NULL,
	`product_image` VARCHAR(100) NULL DEFAULT NULL,
	`category_id` INT NOT NULL,
	`product_sku` VARCHAR(50) NULL DEFAULT NULL,
	`product_unit_price` DECIMAL(10,2) NOT NULL,
	`discount_id` INT NULL DEFAULT NULL,
	`product_taxable` TINYINT NOT NULL DEFAULT 1,
	`stock_id` INT NOT NULL,
    `product_rating` FLOAT DEFAULT 0 COMMENT '0 TO 5',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `product_name_idx` (`product_name` ASC) VISIBLE,
	CONSTRAINT `fk_product_category`
		FOREIGN KEY (`category_id`)
		REFERENCES `ecommerce`.`product_category` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CONSTRAINT `fk_discount_id`
		FOREIGN KEY (`discount_id`)
        REFERENCES `ecommerce`.`product_discount` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT `fk_product_stock_id`
		FOREIGN KEY (`stock_id`)
        REFERENCES `ecommerce`.`stock` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT `fk_product_cart_item`
		FOREIGN KEY (`id`)
		REFERENCES `ecommerce`.`cart_item` (`product_id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `chk_product_rate`
		CHECK (`product_rating` BETWEEN 0.00 AND 5.00))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table shopping_session
CREATE TABLE IF NOT EXISTS `ecommerce`.`shopping_session` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`total_amount` DECIMAL(10,2) NOT NULL,
	`shopping_session_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`, `user_id`),
	INDEX `fk_shopping_session_user_idx` (`user_id` ASC) VISIBLE,
	CONSTRAINT `fk_shopping_session_user`
		FOREIGN KEY (`user_id`)
		REFERENCES `ecommerce`.`user` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table cart_item
CREATE TABLE IF NOT EXISTS `ecommerce`.`cart_item` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`shopping_session_id` INT NOT NULL,
	`product_id` INT NOT NULL,
	`quantity` INT NOT NULL DEFAULT 1,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
    UNIQUE INDEX `fk_cart_item_shopping_session` (shopping_session_id,  product_id ASC) VISIBLE,
	INDEX `fk_cart_item_shopping_session_idx` (`shopping_session_id` ASC) VISIBLE,
    INDEX `fk_cart_item_product_idx` (`product_id` ASC) VISIBLE,
	CONSTRAINT `fk_cart_item_shopping_session`
		FOREIGN KEY (`shopping_session_id`)
		REFERENCES `ecommerce`.`shopping_session` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table order_items
CREATE TABLE IF NOT EXISTS `ecommerce`.`order_items` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`order_id` INT NOT NULL,
	`product_id` INT NOT NULL,
	`created_at` DATETIME NULL DEFAULT NULL,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `fk_order_items_order_details_idx` (`order_id`, `product_id` ASC) VISIBLE,
	CONSTRAINT `fk_order_items_order_details`
		FOREIGN KEY (`order_id`)
		REFERENCES `ecommerce`.`order` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_order_items_product`
		FOREIGN KEY (`product_id`)
		REFERENCES `ecommerce`.`product` (`id`)
		ON DELETE NO ACTION
		ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table order
CREATE TABLE IF NOT EXISTS `ecommerce`.`order` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`order_total_amount` DECIMAL(10,2) NOT NULL,
	`payment_id` INT NOT NULL,
    `order_status` ENUM("Canceled", "Confirmed", "Processing", "Completed") NOT NULL DEFAULT 'Processing',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `fk_order_details` (`user_id`, `payment_id` ASC) VISIBLE,
	CONSTRAINT `fk_order_details_user`
	FOREIGN KEY (`user_id`)
		REFERENCES `ecommerce`.`user` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_order_payment`
		FOREIGN KEY (`payment_id`)
		REFERENCES `ecommerce`.`payment_details` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table payment_details
CREATE TABLE IF NOT EXISTS `ecommerce`.`payment_details` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`order_id` INT NOT NULL,
	`amount` DECIMAL(10,2) NOT NULL,
	`payment_type` ENUM("Cash", "Credit Card", "Debit Card") NOT NULL DEFAULT 'Credit Card',
	`status` ENUM("Approved","Declined") NOT NULL DEFAULT 'Declined',
	`payment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`modified_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
    UNIQUE INDEX `fk_order_id` (`order_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- Creates table credit_card_payment
CREATE TABLE IF NOT EXISTS `eCommerce`.`credit_card_payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `card_number` VARCHAR(16) NOT NULL,
  `cardholder_name` VARCHAR(100) NOT NULL,
  `expiration_month` INT NOT NULL,
  `expiration_year` INT NOT NULL,
  `cvv` VARCHAR(4) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `payment_amount` DECIMAL(10, 2) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cc_payment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `eCommerce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_payment_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `eCommerce`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;