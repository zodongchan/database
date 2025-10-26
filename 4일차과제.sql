고객 목록 조회: 모든 고객의 이름과 이메일을 조회하세요.
SELECT customerName FROM customers;

특정 제품 라인의 제품 조회: 'Classic Cars' 제품 라인에 속하는 모든 제품의 이름과 가격을 조회하세요. TABLE: products, COL: productLine
SELECT productName, buyPrice  FROM products WHERE productLine = 'Classic Cars';

최근 주문: 가장 최근에 주문된 10개의 주문을 주문 날짜(orderDate)와 함께 조회하세요. TABLE: orders, COL: orderDate
SELECT * FROM orders ORDER BY orderDate DESC LIMIT 10;

최소 금액 이상의 결제: 100달러 이상 결제된 거래(amount)만 조회하세요. TABLE: payments, COL: amount 
SELECT * FROM payments WHERE amount >= 100;

주문과 고객 정보 조합: 각 주문에 대한 주문 번호(orders-orderNumber)와 주문한 고객(customers-customerName)의 이름을 조회하세요.
SELECT o.orderNumber, c.customerName
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNUmber;

제품과 제품 라인 결합: 각 제품의 이름(products-productName)과 속한 제품 라인의 설명(productlines-textDescription)을 조회하세요.
SELECT p.productName, p.productLine, pl.textDescription
FROM products p
JOIN productlines pl ON p.productLine = pl.productLine; 

직원과 상사 정보: 각 직원의 이름과 직속 상사의 이름을 조회하세요.
SELECT e1.employeeNumber, e1.firstName, e1.lastName, e2.firstName AS 'ManagerFirstName', e2.lastName AS 'ManagerLastName'
FROM employees e1
LEFT JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;

특정 사무실의 직원 목록: 'San Francisco' 사무실에서 근무하는 모든 직원의 이름을 조회하세요.
SELECT e.employeeNumber, e.lastName, e.firstName, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.city = 'San Francisco';

제품 라인별 제품 수: 각 제품 라인에 속한 제품의 수를 조회하세요.
SELECT productLine, COUNT(*) AS productCount
FROM products
GROUP BY productLine;

고객별 총 주문 금액: 각 고객별로 총 주문 금액을 계산하세요.
SELECT customers.customerNumber, 
       customers.customerName, 
       SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS totalAmount
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerNumber, customers.customerName;

가장 많이 팔린 제품: 가장 많이 판매된 제품의 이름과 판매 수량을 조회하세요.
SELECT productName, SUM(quantityOrdered) AS totalQuantity
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY productName
ORDER BY totalQuantity DESC
LIMIT 1;

매출이 가장 높은 사무실: 가장 많은 매출을 기록한 사무실의 위치와 매출액을 조회하세요.
SELECT o.city, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM orders ord
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
JOIN customers c ON ord.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
GROUP BY o.city
ORDER BY totalSales DESC
LIMIT 1;

금액 이상의 주문: 500달러 이상의 총 주문 금액을 기록한 주문들을 조회하세요.
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS totalAmount
FROM orderdetails
GROUP BY orderNumber
HAVING totalAmount > 500;
​
평균 이상 결제 고객: 평균 결제 금액보다 많은 금액을 결제한 고객들의 목록을 조회하세요.
SELECT customerNumber, SUM(amount) AS totalPayment
FROM payments
GROUP BY customerNumber
HAVING totalPayment > (SELECT AVG(amount) FROM payments);
​
주문 없는 고객: 아직 주문을 하지 않은 고객의 목록을 조회하세요.
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);
​
최대 매출 고객: 가장 많은 금액을 지불한 고객의 이름과 총 결제 금액을 조회하세요.
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalSpent
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY totalSpent DESC
LIMIT 1;

신규 고객 추가: 'customers' 테이블에 새로운 고객을 추가하는 쿼리를 작성하세요.
INSERT INTO customers (customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES ('New Customer', 'Lastname', 'Firstname', '123-456-7890', '123 Street', 'Suite 1', 'City', 'State', 'PostalCode', 'Country', 1002, 50000.00);

제품 가격 변경: 'Classic Cars' 제품 라인의 모든 제품 가격을 10% 인상하는 쿼리를 작성하세요.
UPDATE products
SET buyPrice = buyPrice * 1.10
WHERE productLine = 'Classic Cars';

고객 데이터 업데이트: 특정 고객의 이메일 주소를 변경하는 쿼리를 작성하세요.
UPDATE customers
SET email = 'newemail@example.com'
WHERE customerNumber = 103;

직원 전보: 특정 직원을 다른 사무실로 이동시키는 쿼리를 작성하세요.
UPDATE employees
SET officeCode = '2'
WHERE employeeNumber = 1002;

----과제----(초급)

customers 테이블에 새 고객을 추가하세요.
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, creditLimit)
VALUES ('499', 'jongchan', 'kim', 'zodongchan', '010-1577-1577', 'bongduck', '1254', 'City', 'Deagu', '053', 'Korean', 5000000.00);

products 테이블에 새 제품을 추가하세요.
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('S73_4444', 'newproduct', 'Ships', '1:72', 'limited company', 'sweet', '1004', '5.00', '52.00');

employees 테이블에 새 직원을 추가하세요.
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES ('1004', 'JongChan', 'Kim', 'x5800', '15_BE_chan@ozcoding.com', '4', 1102, 'Sales Rep');

offices 테이블에 새 사무실을 추가하세요.
INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES ('8', 'Busan', '+82 7203 2575', 'home', 'room', 'Bin', 'Korean', '053', 'NA');

orders 테이블에 새 주문을 추가하세요.
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES ('10426', '2005-03-26', '2005-04-01', NULL, 'In Process', NULL, '112');

orderdetails 테이블에 주문 상세 정보를 추가하세요.
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES ('10425', 'S73_4444', '24', '72.00', '9');

payments 테이블에 지불 정보를 추가하세요.
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES ('499', 'JC336337', '2004-07-12', '11811.18');

productlines 테이블에 제품 라인을 추가하세요.
INSERT INTO productlines (productLine, textDescription, htmlDescription, image)
VALUES ('Hello kitty', 'spicy', NULL, NULL);

customers 테이블에 다른 지역의 고객을 추가하세요.
SELECT * FROM customers;
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES ('500', 'JinWoo', 'Jang', 'Doraemong', '010-1588-1588', 'bongduck', NULL, 'City', 'Deagu', '053', 'Korean', NULL, '150000.00');

products 테이블에 다른 카테고리의 제품을 추가하세요.
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('S73_5555', 'HotNewProduct', 'Ships', '1:700', 'limited company', 'sweet', '1009', '10.00', '72.00');

customers 테이블에서 모든 고객 정보를 조회하세요.
SELECT * FROM customers;

products 테이블에서 모든 제품 목록을 조회하세요.
SELECT productName FROM products;

employees 테이블에서 모든 직원의 이름과 직급을 조회하세요.
SELECT lastName, firstName, jobTitle FROM employees;

offices 테이블에서 모든 사무실의 위치를 조회하세요.
SELECT city, addressLine1, addressLine2, state, territory FROM offices;

orders 테이블에서 최근 10개의 주문을 조회하세요.
SELECT * FROM orders ORDER BY orderDate DESC LIMIT 10;

orderdetails 테이블에서 특정 주문의 모든 상세 정보를 조회하세요.
SELECT * FROM orderdetails WHERE orderNumber >= 10130;

payments 테이블에서 특정 고객의 모든 지불 정보를 조회하세요.
SELECT * FROM payments WHERE customerNumber = 398;

productlines 테이블에서 각 제품 라인의 설명을 조회하세요.
SELECT productLine, textDescription FROM productlines;

customers 테이블에서 특정 지역의 고객을 조회하세요.
SELECT * FROM customers WHERE city = Nantes;

products 테이블에서 특정 가격 범위의 제품을 조회하세요.
SELECT * FROM products WHERE buyPrice BETWEEN 40 AND 80;

customers 테이블에서 특정 고객의 주소를 갱신하세요.
SELECT * FROM customers WHERE customerNumber = 500;
UPDATE customers SET customerName = 'Yeop' WHERE customerNumber = 500;

products 테이블에서 특정 제품의 가격을 갱신하세요.
SELECT * FROM products;
UPDATE products
SET buyPrice = CASE
    WHEN productLine = 'Classic Cars' THEN buyPrice * 2
    ELSE buyPrice
END;

employees 테이블에서 특정 직원의 직급을 갱신하세요.
SELECT * FROM employees WHERE lastName = 'Murphy';
UPDATE employees SET jobTitle = 'Sales Manager (KR)' WHERE lastName = 'Murphy' AND firstName = 'Diane';

offices 테이블에서 특정 사무실의 전화번호를 갱신하세요.
SELECT * FROM offices;
UPDATE offices SET phone = '+82 9594 3209' WHERE officeCode = 8;

orders 테이블에서 특정 주문의 상태를 갱신하세요.
SELECT * FROM orders;
UPDATE orders 
SET status = 'Shipped', shippedDate = '2005-05-07'
WHERE status = 'In Process';

orderdetails 테이블에서 특정 주문 상세의 수량을 갱신하세요.
SELECT * FROM orderdetails;
UPDATE orderdetails SET quantityOrdered = 60 WHERE orderNumber = 10425;

payments 테이블에서 특정 지불의 금액을 갱신하세요.
SELECT * FROM payments;
UPDATE payments 
SET amount = CASE
	WHEN checkNumber = 'JPMR4544' THEN amount * 1.5
    ELSE amount
END;

productlines 테이블에서 특정 제품 라인의 설명을 갱신하세요.
SELECT * FROM productlines;
UPDATE productlines
SET textDescription = 'Hello Kitty is cute.'
WHERE productLine = 'Hello kitty';

customers 테이블에서 특정 고객의 이메일을 갱신하세요.
SELECT * FROM customers
UPDATE customers
SET customerName = 'Yeop Bee'
WHERE customerNumber = 500;

products 테이블에서 여러 제품의 가격을 한 번에 갱신하세요.
SELECT * FROM products
UPDATE products
SET buyPrice = CASE
	WHEN productScale = '1:10' THEN buyPrice * 2
	ELSE buyPrice
END;

customers 테이블에서 특정 고객을 삭제하세요.
SELECT * FROM customers
DELETE FROM customers WHERE country = 'Israel';

products 테이블에서 특정 제품을 삭제하세요.
DELETE FROM products
WHERE productName = 'HotNewProduct';

employees 테이블에서 특정 직원을 삭제하세요.
DELETE FROM employees WHERE lastName = 'Jones';

offices 테이블에서 특정 사무실을 삭제하세요.
DELETE FROM offices WHERE city = 'Busan';

orders 테이블에서 특정 주문을 삭제하세요.
DELETE FROM orders
WHERE status = 'Cancelled';

orderdetails 테이블에서 특정 주문 상세를 삭제하세요.
DELETE FROM orderdetails WHERE productCode = 'S73_4444';

payments 테이블에서 특정 지불 내역을 삭제하세요.
DELETE FROM payments WHERE customerNumber = '499';

products 테이블에서 특정 제품 라인을 삭제하세요.
SELECT * FROM products 
DELETE FROM orderdetails
WHERE productCode IN (SELECT productCode FROM products WHERE productLine = 'Vintage Cars');
DELETE FROM products WHERE productLine = 'Vintage Cars';

customers 테이블에서 특정 지역의 모든 고객을 삭제하세요.
SELECT * FROM customers 
DELETE FROM customers WHERE city = 'city'

products 테이블에서 특정 카테고리의 모든 제품을 삭제하세요.
SELECT * FROM products
DELETE FROM orderdetails
WHERE productCode IN (SELECT productCode FROM products WHERE productLine = 'Ships');
DELETE FROM products WHERE productLine = 'Ships';