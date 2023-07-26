-- Project: eCommerce
-- Model: eCommerce
-- Persistence Test
-- Version: 1.0
-- Created at: 2023-07-21
-- Modified at: 
-- Author: Marcelo Tiago Lopes Shimizu

-- client_address_type
INSERT INTO `ecommerce`.`client_address_type` 
    (`client_address_type_name`,`client_address_type_description`)
VALUES 
	("Home","Home address"),
	("Work", "Work address");

-- clients table    
 INSERT INTO `ecommerce`.`clients`
	(`client_active`, `client_first_name`, `client_middle_name`, `client_last_name`, `client_birth_date`, `client_email`, `client_email_verified`)
VALUES
	(1, "John", NULL, "MCDONALD", '2000-01-01', 'mcdonald@gmail.com', 1),
    (1, "Mary", NULL, "ZENN", '2001-05-19', 'zenn@yahoo.com', 1);

-- client_address    
INSERT INTO `ecommerce`.`client_address`
	(`client_id`, `client_address_type_id`, `client_address`, `client_address2`, `client_address_number`, `client_address_suite`, `client_address_city`, `client_address_state`, `client_address_country`, `client_address_zip`, `client_address_observation`)
VALUES
	(1, 1, "Main Street", null, 1500, null, "Vancouver", "BC", "Canada", "V0NV7W", null),
    (2, 1, "North Ave", "Star Building", 500, 110, "Vancouver", "BC", "Canada", "V0NV7W", "Buzzer: 9999");
    
-- client_phone_type
INSERT INTO `ecommerce`.`client_phone_type`
	(`client_phone_type_name`, `client_phone_type_description`)
VALUES
	('Home','Home phone number'),
    ('Mobile', 'Mobile phone number');
    
-- client_phone
INSERT INTO `ecommerce`.`client_phone`
	(`client_id`, `client_phone_type_id`, `client_phone`, `client_phone_ext`, `client_phone_verified`)
VALUES
	(1, 1, '(111) 1234-5678', null, 1),
    (2, 1, '00012345678', '123', 0),
    (2, 2, '111-1234-5678', null, 1);

-- user_role_type
INSERT INTO `ecommerce`.`user_role_type`
	(`user_role_name`, `user_role_description`)
VALUES
	('client', 'End-customer'),
	('user', 'Test user'),
    ('support', 'Customer service staff');

-- user_role
INSERT INTO `ecommerce`.`user_role`
	(`user_id`, `user_role_id`)
VALUES
	(2, 1),
    (1, 2);
    
-- users
INSERT INTO `ecommerce`.`user`
	(`user_name`, `user_password`, `client_id`, `modified_at`)
VALUES
	('waterman', '12345678', 1, '2023-01-01'),
    ('ladybug','12345678', 2, null);
        
-- user_session
INSERT INTO `ecommerce`.`user_session`
	(`user_id`, `token`, `is_active`,`ip_address`)
VALUES
	(1, 'token', 0, '222.111.111.112'),
	(1, 'token', 1, '222.111.111.112'),
	(2, 'token', 1, '222.111.111.113');

-- admin_role_type
INSERT INTO `ecommerce`.`admin_role_type`
	(`admin_role_name`, `admin_roles_description`, `admin_permissions`, `created_at`, `modified_at`)
VALUES
	('System administrator', 'System administrator.', 'GRANT', '2023-02-01','1900-01-01');
    
-- admin_role
INSERT INTO `ecommerce`.`admin_role`
	(`admin_id`, `admin_role_type`)
VALUES
	(1, 1),
    (2, 1);

-- employee
INSERT INTO `ecommerce`.`employee`
	(`employee_role`, `employee_first_name`, `employee_middle_name`, `employee_last_name`, `employee_birth_date`, `employee_phone`, `employee_email`, `employee_address`, `employee_address2`, `employee_city`, `employee_state`, `employee_zip`)
VALUES
	('Database Administrator', 'Marta', null, 'Silva', '2000-05-06', '000-1234-5678', 'martasilva@gmail.com', 'orange street', null, 'orlando', 'fl', 'a1a1a1'),
	('Database Manager', 'Taylor', null, 'Smith', '2002-03-04', '000-1234-5678', 'tsmith@gmail.com', 'banana street', null, 'orlando', 'fl', 'a1a1a1');
    
-- admin
INSERT INTO `ecommerce`.`admin`
	(`employee_id`, `username`, `password`, `admin_created_by`)
VALUES
	(1, 'admin', '1234', 1),
    (2, 'tsmith', '123', 1);
    
-- admin_session
INSERT INTO `ecommerce`.`admin_session`
	(`admin_id`, `token`, `login_time`, `logout_time`, `is_active`,`ip_address`)
VALUES
	(1, 'token', '2015-02-01', '2015-02-01', 0, '111.111.111.112'),
	(1, 'token', current_timestamp(), current_timestamp(), 1, '111.111.111.112'),
	(2, 'token', current_timestamp(), current_timestamp(), 1, '111.111.111.113');
    
-- suppliers
INSERT INTO `ecommerce`.`suppliers`
	(`supplier_name`, `supplier_contact`, `supplier_phone`,  `supplier_email`, `supplier_address`, `supplier_zip`, `supplier_city`, `supplier_country`)
VALUES
	('Microsoft', 'Bill', '123-5555-6666', 'bill@microsoft.com', '777 Cloud St', 'a1a1a1', 'skyland', 'united states'),
    ('Adidas', 'Spike', '123-7777-6666', 'adidas@adidas.com', '11 Sport St', 'a1a1a1', 'sportland', 'germany');

-- stock_site
INSERT INTO `ecommerce`.`stock_site`
	(`stock_name`, `stock_address`)
VALUES
	('Rainbow Store', '888 Rainbow Street');

-- stock
INSERT INTO `ecommerce`.`stock`
	(`stock_site_id`, `quantity`)
VALUES
	(1, 100),
    (1, 50),
    (1, 10);

-- stock_movement
INSERT INTO `ecommerce`.`stock_movement`
	(`stock_id`, `supplier_id`, `movement_date`, `quantity`, `value_per_unit`, `source_site_id`, `destination_site_id`)
VALUES
	(1, 1, '2011-02-19', 3, 99.99, 0, 1),
    (2, 1, '2011-02-21', 1, 149.99, 0, 1),
    (3, 2, '2011-02-21', 1, 79.99, null, 1);
    
-- product_category
INSERT INTO `ecommerce`.`product_category`
	(`category_name`, `category_description`)
VALUES
	('Software', 'Software'),
	('Hardware', 'Hardware'),
	('Stationery','Stationery'),
    ('Shoes', 'Shoes');

-- product_discount
INSERT INTO `ecommerce`.`product_discount`
	(`discount_name`, `discount_description`, `discount_valid`, `discount_valid_from`, `discount_valid_until`, `discount_percentage`, `discount_validated_by`)
VALUES
('Special Day', 'Discount for special day purchase.', 1,  '2025-06-15', '2025-06-15', '0.1', 1),
('Store Birthdate', 'Discount for Store Birthdate.', 1,  '2025-01-01', '2025-01-31', '0.1', 1);

-- product
INSERT INTO `ecommerce`.`product`
	(`product_name`, `product_cart_description`, `product_short_description`,`product_long_description`, `product_thumb`, `product_image`, `category_id`, `product_sku`, `product_unit_price`, `discount_id`, `product_taxable`, `stock_id`, `product_rating`)
VALUES
	('product1', 'product one', 'first product', 'product one first product product1', 'thumb', 'image', 1, 'd1adfa111sdfa1', 70.5, 2, 1, 1, 5),
    ('product2', 'product tow', 'second product', 'product two second product product2', 'thumb', 'image', 2, 'd1adfa111sdfa1', 199.99, 2, 1, 2, 3),
    ('sport shoes', 'Adidas shoes model z1', 'Adidas shoes model z1', 'Designed for sports...', 'thumb', 'image', 3, 'd1adfa111sdfa1', 99.99, null, 1, 3, 4.5);

-- shopping_session
INSERT INTO `ecommerce`.`shopping_session`
	(`user_id`,`total_amount`, `shopping_session_date`)
VALUES
	(1, 201.98, current_timestamp()),
    (2, 303.97, current_timestamp());

-- cart_item
INSERT INTO `ecommerce`.`cart_item`
	(`shopping_session_id`, `product_id`, `quantity`)
VALUES
	(1, 1, 1),
	(1, 2, 2),
    (2, 1, 1),
    (2, 2, 2),
	(2, 3, 1);
    
-- order_items
INSERT INTO `ecommerce`.`order_items`
	(`order_id`, `product_id`) 
VALUES
	(1, 1),
	(1, 2),
    (2, 1),
    (2, 2),
	(2, 3);

-- order
INSERT INTO `ecommerce`.`order`
	(`user_id`, `order_total_amount`, `payment_id`, `order_status`)
VALUES
	(1, 201.98, 1, 'Processing'),
    (2, 303.97, 2, 'Completed');

-- payment_details
INSERT INTO `ecommerce`.`payment_details`
	(`order_id`, `amount`, `payment_type`, `status`, `payment_date`)
VALUES
	(1, 201.98, 'Credit Card','Approved', current_timestamp()),
    (2, 303.97, 'Cash', 'Approved', current_timestamp());

-- credit_card_payment
INSERT INTO `ecommerce`.`credit_card_payment`
	(`user_id`, `order_id`, `card_number`, `cardholder_name`, `expiration_month`, `expiration_year`, `cvv`, `payment_date`, `payment_amount`) 
VALUES
	(1, 1, '0000111122223333', 'JOHN MCDONALD', 12, 2026, '000', current_timestamp(), 1000.5);