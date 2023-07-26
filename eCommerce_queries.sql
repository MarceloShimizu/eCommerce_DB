-- Project: eCommerce
-- Model: eCommerce
-- Queries
-- Version: 1.0
-- Created at: 2023-07-21
-- Modified at: 
-- Author: Marcelo Tiago Lopes Shimizu

-- selects products that contain "shoes" in their name.
SELECT 
	prd.* 
FROM 
	ecommerce.product prd
WHERE 
	prd.product_name LIKE '%shoes%';

--   sorts orders from highest to lowest value.
SELECT 
	*
FROM
	ecommerce.order ord
ORDER BY
	ord.order_total_amount DESC;

-- cart with more than 3 items 
SELECT 
	crt.shopping_session_id,
    SUM(crt.quantity) AS 'Number of items'
FROM
	ecommerce.cart_item crt
GROUP BY
	crt.shopping_session_id
HAVING
	SUM(crt.quantity) > 3;

-- adds up the orders, makes the count and the average ticket.
SELECT
	SUM(ord.order_total_amount) AS 'Total Sales',
    COUNT(ord.id) AS 'Number of Orders',
    FORMAT(AVG(ord.order_total_amount), 2) AS 'Average Ticket'
FROM
	ecommerce.order ord;

-- gives a summary of the order
SELECT 
    CONCAT(UPPER(SUBSTRING(cli.client_first_name, 1, 1)), LOWER(SUBSTRING(cli.client_first_name, 2)), ' ', UPPER(SUBSTRING(cli.client_last_name, 1, 1)), LOWER(SUBSTRING(cli.client_last_name, 2))) AS 'Customer Name', 
    adr.client_address AS 'Address',
    adt.client_address_type_name AS 'Type of Address',
    phn.client_phone AS 'Phone',
	pht.client_phone_type_name AS 'Phone Type',
    ord.order_status AS 'Order Status',
    ord.order_total_amount AS 'Total Amount',
    pmt.payment_type AS 'Paymento Type',
    date(pmt.payment_date) AS 'Payment Date'
FROM 
	ecommerce.order ord 
LEFT JOIN
	ecommerce.user usr ON ord.user_id = usr.id
LEFT JOIN
	ecommerce.clients cli ON cli.id = usr.client_id
LEFT JOIN
	ecommerce.client_address adr ON cli.id = adr.client_id
LEFT JOIN
	ecommerce.client_address_type adt ON adr.client_address_type_id = adt.id
LEFT JOIN
	ecommerce.client_phone phn ON cli.id = phn.client_id
LEFT JOIN
	ecommerce.client_phone_type pht ON phn.client_phone_type_id = pht.id
LEFT JOIN 
	ecommerce.order_items itm ON ord.id = itm.order_id
LEFT JOIN
	ecommerce.payment_details pmt ON ord.payment_id = pmt.id
WHERE
		itm.product_id=3
    AND pht.id = 1
    AND adt.id = 1;
    
-- admin session details
SELECT
	ads.id AS 'Session ID',
    ads.admin_id AS 'Admin ID',
    CONCAT(emp.employee_first_name, ' ', emp.employee_last_name) AS 'Employee Name',
	art.admin_role_name AS 'Role Name',
    IF(ads.is_active = 1, 'Active', 'Inactive')  AS 'Session Status',
    ads.login_time AS 'Login',
    ads.logout_time 'Logout',
    ads.ip_address AS 'IP'
FROM
	ecommerce.admin_session ads
LEFT JOIN
	ecommerce.admin adm ON ads.admin_id = adm.id
LEFT JOIN
	ecommerce.admin_role adr ON adm.id = adr.admin_id
LEFT JOIN
	ecommerce.admin_role_type art ON adr.admin_role_type = art.id
LEFT JOIN
	ecommerce.employee emp ON adm.employee_id = emp.id;

-- check stock
SELECT
	prd.product_name AS 'Product',
    sts.stock_name AS 'Location',
    stk.quantity AS 'Quantity',
    FORMAT(AVG(stm.value_per_unit), 2) AS 'Average price per unit'
FROM
	ecommerce.stock stk
LEFT JOIN
	ecommerce.stock_site sts ON stk.stock_site_id = sts.id
LEFT JOIN
	ecommerce.product prd ON stk.id = prd.stock_id
LEFT JOIN
	ecommerce.stock_movement stm ON stk.id = stm.stock_id
GROUP BY
	prd.product_name,
    sts.stock_name,
    stk.quantity
ORDER BY
	prd.product_name ASC