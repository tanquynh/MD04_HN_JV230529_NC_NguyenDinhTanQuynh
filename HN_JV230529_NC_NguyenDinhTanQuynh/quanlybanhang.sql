create database QUANLYBANHANG;
use QUANLYBANHANG;
CREATE TABLE IF NOT EXISTS CUSTOMERS (
    customer_id VARCHAR(4) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(25) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS ORDERS (
    order_id VARCHAR(4) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(4) NOT NULL,
    order_date DATE NOT NULL,
    total_amount DOUBLE NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES CUSTOMERS (customer_id)
);


CREATE TABLE IF NOT EXISTS PRODUCTS (
    product_id VARCHAR(4) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    status BIT(1) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS ORDER_DETAILS (
    order_id VARCHAR(4) NOT NULL,
    product_id VARCHAR(4) NOT NULL,
    quantity INT(11) NOT NULL,
    price DOUBLE NOT NULL,
    CONSTRAINT pk_od PRIMARY KEY (order_id , product_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES ORDERS (order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES PRODUCTS (product_id)
);

-- Bài 2: Thêm dữ liệu
-- Add customers
INSERT INTO CUSTOMERS(customer_id, name, email, phone, address) VALUES
 ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
 ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
 ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904725784', 'Mộc Châu, Sơn La'),
 ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
 ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');
-- ktra
-- SELECT * FROM CUSTOMERS

-- Add products
INSERT INTO PRODUCTS(product_id, name, description, price) VALUES
 ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999),
 ('P002', 'Dell Vostro V3510', 'Core i5, RAM 8GB', 14999999),
 ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 28999999),
 ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999),
 ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000);
 
 -- ktra
-- SELECT * FROM PRODUCTS

-- Add orders
INSERT INTO ORDERS(order_id, customer_id, total_amount, order_date) VALUES
 ('H001', 'C001', 52999997, '2023-02-22'),
 ('H002', 'C001', 80999997, '2023-03-11'),
 ('H003', 'C002', 54359998, '2023-01-22'),
 ('H004', 'C003', 102999995, '2023-03-14'),
 ('H005', 'C003', 80999997, '2022-03-12'),
 ('H006', 'C004', 110449994, '2023-02-01'),
 ('H007', 'C004', 79999996, '2023-03-29'),
 ('H008', 'C005', 29999998, '2023-02-14'),
 ('H009', 'C005', 28999999, '2023-01-10'),
 ('H010', 'C005', 149999994, '2023-04-01');
 
  -- ktra
-- SELECT * FROM ORDERS

-- Add order details
INSERT INTO ORDER_DETAILS(order_id, product_id, price, quantity) VALUES
 ('H001', 'P002', 14999999, 1),
 ('H001', 'P004', 18999999, 2),
 ('H002', 'P001', 22999999, 1),
 ('H002', 'P003', 28999999, 2),
 ('H003', 'P004', 18999999, 2),
 ('H003', 'P005', 4090000, 4),
 ('H004', 'P002', 14999999, 3),
 ('H004', 'P003', 28999999, 2),
 ('H005', 'P001', 22999999, 1),
 ('H005', 'P003', 28999999, 2),
 ('H006', 'P005', 4090000, 5),
 ('H006', 'P002', 14999999, 6),
 ('H007', 'P004', 18999999, 3),
 ('H007', 'P001', 22999999, 1),
 ('H008', 'P002', 14999999, 2),
 ('H009', 'P003', 28999999, 1),
 ('H010', 'P003', 28999999, 2),
 ('H010', 'P001', 22999999, 4);
 
   -- ktra
-- SELECT * FROM ORDER_DETAILS

-- Bài 3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers
SELECT name AS Tên, email, phone AS 'Số điện thoại', address AS ' Địa chỉ' FROM Customers;

-- 2.Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng).
SELECT CUSTOMERS.name AS Tên, CUSTOMERS.phone AS 'Số điện thoại',CUSTOMERS.address AS 'Địa chỉ'
FROM CUSTOMERS 
JOIN ORDERS  ON ORDERS.customer_id = CUSTOMERS.customer_id
WHERE CONCAT(YEAR(order_date), '-', MONTH(order_date)) = '2023-3';

-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ).
SELECT MONTH(order_date) AS Tháng, SUM(total_amount) AS 'Tổng doanh thu'
FROM ORDERS
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại).
SELECT DISTINCT CUSTOMERS.name AS 'Tên', CUSTOMERS.address AS 'Địa chỉ', CUSTOMERS.email AS 'Email', CUSTOMERS.phone AS 'Số điện thoại'
FROM CUSTOMERS 
JOIN ORDERS ON  ORDERS.customer_id = CUSTOMERS.customer_id
WHERE CONCAT(YEAR(order_date), '-', MONTH(order_date)) <> '2023-2';

-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra).
SELECT PRODUCTS.product_id AS `Mã sản phẩm`, PRODUCTS.name as `Tên sản phẩm`, sum(ORDER_DETAILS.quantity) AS `Số lượng sản phẩm` FROM PRODUCTS 
JOIN ORDER_DETAILS  ON  ORDER_DETAILS.product_id = PRODUCTS.product_id
JOIN ORDERS  ON ORDERS.order_id = ORDER_DETAILS.order_id
WHERE concat(YEAR(order_date), '-', MONTH(order_date)) = '2023-2'
GROUP BY PRODUCTS.product_id, PRODUCTS.name;


-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu).

SELECT CUSTOMERS.customer_id AS 'Mã khách hàng', CUSTOMERS.name AS ' Tên Khách hàng', SUM(total_amount) AS 'Mức chi tiêu năm 2023'
FROM CUSTOMERS 
JOIN ORDERs  ON ORDERs.customer_id = CUSTOMERS.customer_id
GROUP BY CUSTOMERS.customer_id , CUSTOMERS.name
ORDER BY SUM(total_amount) DESC;

-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm)
SELECT CUSTOMERS.name AS 'Tên người mua', ORDERS.total_amount AS 'Tổng tiền', ORDERS.order_date AS 'Ngày tạo hóa đơn' , sum(ORDER_DETAILS.quantity) as 'Tổng sản phẩm' 
FROM ORDERS 
JOIN  CUSTOMERS  ON CUSTOMERS.customer_id = ORDERS.customer_id
JOIN ORDER_DETAILS  ON ORDER_DETAILS.order_id = ORDERS. order_id
JOIN PRODUCTS  ON PRODUCTS.product_id = ORDER_DETAILS.product_id
GROUP BY CUSTOMERS.name, ORDERS.total_amount, ORDERS.order_date
HAVING sum(ORDER_DETAILS.quantity) >= 5;

-- Bài 4: Tạo View, Procedure
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn
CREATE VIEW ORDER_VIEW AS
SELECT CUSTOMERS.name AS 'Tên khách hàng', CUSTOMERS.phone AS 'Số điện thoại', CUSTOMERS.address as 'Địa chỉ', ORDERS.total_amount as 'Tổng tiền', ORDERS.order_date as 'Ngày tạo hoá đơn'
FROM CUSTOMERS 
JOIN ORDERS  ON ORDERS.customer_id = CUSTOMERS.customer_id;

-- ktra
-- SELECT * FROM ORDER_VIEW

-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt.
CREATE VIEW CUSTOMER_VIEW as
SELECT CUSTOMERS.name AS 'Tên khách hàng', CUSTOMERS.address AS 'Địa chỉ', CUSTOMERS.phone AS 'Số điện thoại', count(ORDERS.order_id) as 'Tổng số đơn'
FROM CUSTOMERS 
JOIN ORDERS ON ORDERS.customer_id = CUSTOMERS.customer_id
GROUP BY CUSTOMERS.name, CUSTOMERS.address, CUSTOMERS.phone;
 -- ktra
-- SELECT * FROM CUSTOMER_VIEW

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.
CREATE VIEW PRODUCT_VIEW AS
SELECT PRODUCTS.name AS 'Tên sản phẩm', PRODUCTS.description AS 'Mô tả', PRODUCTS.price AS 'Giá', sum(ORDER_DETAILS.quantity) AS 'Tổng số lượng đã bán'
FROM PRODUCTS
JOIN ORDER_DETAILS ON ORDER_DETAILS.product_id = PRODUCTS.product_id
GROUP BY PRODUCTS.name, PRODUCTS.description, PRODUCTS.price;
 -- ktra
-- SELECT * FROM PRODUCT_VIEW

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer.
CREATE INDEX idx_phone_email ON CUSTOMERS(phone, email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.
DELIMITER //
CREATE PROCEDURE PRO_GET_INFOR_CUSTOMER(input_id VARCHAR(4))
BEGIN
	SELECT * FROM CUSTOMERS WHERE customer_id = input_id;
END //
DELIMITER ;

-- ktra
-- CALL PRO_GET_INFOR_CUSTOMER('C001')

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm.
DELIMITER //
CREATE PROCEDURE PRO_GET_ALL_PRODUCTS()
BEGIN
	SELECT * FROM PRODUCTS ;
END //
DELIMITER ;

-- ktra
-- CALL PRO_GET_ALL_PRODUCTS()

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng.
DELIMITER //
CREATE PROCEDURE PRO_GET_ORDERS_BY_CUS_ID(input_id VARCHAR(4))
BEGIN
	SELECT ORDERS.order_id AS 'Mã Đơn Hàng', ORDERS.order_date AS 'Ngày tạo đơn hàng',CUSTOMERS.customer_id AS 'Mã khách hàng' FROM ORDERS 
    JOIN CUSTOMERS ON ORDERS.customer_id = input_id;
END //
DELIMITER ;
drop PROCEDURE PRO_GET_ORDERS_BY_CUS_ID
-- Ktra
-- CALL PRO_GET_ORDERS_BY_CUS_ID('C001')

-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo.
DELIMITER //
CREATE PROCEDURE PRO_CREATE_NEW_ORDER(input_cid VARCHAR(4), input_total_amount DOUBLE, input_date DATE)
BEGIN
	DECLARE last_id INT;
    DECLARE new_id VARCHAR(4);

	SET last_id = (
    SELECT CAST(SUBSTRING(order_id, 2, 4) AS SIGNED)
    FROM ORDERS
    ORDER BY SUBSTRING(order_id, 2, 4) DESC
    LIMIT 1
	);
    
	SET new_id = (CASE
		WHEN (last_id + 1) < 10 THEN CONCAT('H00', (last_id + 1))
        WHEN (last_id + 1) < 100 THEN CONCAT('H0', (last_id + 1))
        ELSE CONCAT('H', (last_id + 1))
        END
	);
    
	INSERT INTO ORDERS(order_id, customer_id, total_amount, order_date) VALUES 
    (new_id, input_cid, input_total_amount, input_date);
    
    SELECT new_id;
END //
DELIMITER ;
-- Ktra
-- CALL PRO_CREATE_NEW_ORDER('C002', 1499999, '2023-11-23');

-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc.
DELIMITER //
CREATE PROCEDURE PRO_SUM_QUANTITY_BET_TIME(startDate DATE, endDate DATE)
BEGIN
	SELECT PRODUCTS.product_id AS 'Mã sản phẩm', PRODUCTS.name AS 'Tên sản phẩm', sum(ORDER_DETAILS.quantity) AS 'Số lượng' 
    FROM ORDERS 
    JOIN ORDER_DETAILS  ON ORDER_DETAILS.order_id = ORDERS.order_id
    JOIN PRODUCTS  ON PRODUCTS.product_id = ORDER_DETAILS.product_id
    WHERE ORDERS.order_date BETWEEN startDate AND endDate
    GROUP BY PRODUCTS.product_id, PRODUCTS.name;
END //
DELIMITER ;
-- ktra
-- CALL PRO_SUM_QUANTITY_BET_TIME('2023-02-01', '2023-03-31')

-- 10.Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê.
DELIMITER //
CREATE PROCEDURE PRO_SUM_QTTY_DESC_FROM_YEAR_MONTH(inputYear INT(4), inputMonth INT(2))
BEGIN
    SELECT PRODUCTS.product_id AS 'Mã sản phẩm', PRODUCTS.name AS 'Tên sản phẩm', sum(ORDER_DETAILS.quantity) AS 'Số lượng'
    FROM PRODUCTS 
    JOIN ORDER_DETAILS  ON ORDER_DETAILS.product_id = PRODUCTS.product_id
    JOIN ORDERS  ON ORDERS.order_id = ORDER_DETAILS.order_id
    WHERE YEAR(ORDERS.order_date) = inputYear AND MONTH(ORDERS.order_date) = inputMonth
    GROUP BY PRODUCTS.product_id, PRODUCTS.name
    ORDER BY sum(ORDER_DETAILS.quantity) DESC;
END //
DELIMITER ;

-- ktra
-- CALL PRO_SUM_QTTY_DESC_FROM_YEAR_MONTH(2023, 03)
