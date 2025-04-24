--//LISTA 04
  Name: MySQL Sample Database classicmodels
  Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
*/


/* Create the database */
-- Verificar se o banco de dados existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'classicmodels')
BEGIN
    -- Criar o banco de dados
    CREATE DATABASE classicmodels;
USE classicmodels;

-- Remover tabelas existentes, se houver
DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS productlines;
-- Criar as tabelas
CREATE TABLE productlines (
  productLine varchar(50),
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription text,
  image varbinary(max),
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode varchar(15),
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription text NOT NULL,
  quantityInStock smallint NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);


CREATE TABLE offices (
  officeCode varchar(10),
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
);

CREATE TABLE employees (
  employeeNumber int,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);

CREATE TABLE customers (
  customerNumber int,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
  customerNumber int,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);
CREATE TABLE orders (
  orderNumber int,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customerNumber int NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber int,
  productCode varchar(15) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint NOT NULL,
  PRIMARY KEY (orderNumber,productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  FOREIGN KEY (productCode) REFERENCES products (productCode)
);
--1) Implementar uma Stored Procedure, usando um cursor, que percorre toda a 
--tabela de products, e caso a quantidade em estoque (quantityInStock) seja 
--menor ou igual a 1000, acumula a quantidade em estoque e retorna esse valor 
--como argumento de saída (e de entrada).
--Usar um Cursor pra percorrer os dados da tabela products!

CREATE PROCEDURE UpdateStockQuantity
    @totalQuantityInStock decimal(10,2) OUTPUT
AS
BEGIN
    DECLARE @productCode varchar(15)
    DECLARE @quantityInStock decimal(10,2)

    -- Inicializa a variável de saída
    SET @totalQuantityInStock = 0

    -- Declara e abre o cursor
    DECLARE productCursor CURSOR FOR
    SELECT productCode, quantityInStock
    FROM products

    OPEN productCursor

    FETCH NEXT FROM productCursor INTO @productCode, @quantityInStock

    -- Percorre os registros da tabela de produtos
    WHILE @@FETCH_STATUS = 0
    BEGIN
    -- Verifica se a quantidade em estoque é menor ou igual a 1000
        IF @quantityInStock <= 1000
        BEGIN
   -- Acumula a quantidade em estoque
            SET @totalQuantityInStock = @totalQuantityInStock + @quantityInStock
        END

        FETCH NEXT FROM productCursor INTO @productCode, @quantityInStock
    END

    -- Fecha o cursor
    CLOSE productCursor
    DEALLOCATE productCursor
END

--//LISTA 05

--1 Implementar uma função de banco de dados que, usando um cursor, calcula o valor total de um pedido (order) dado um número de pedido. O cursor deve percorrer os itens do pedido (orderdetails) e realizar o cálculo acumulado do total de cada item.
CREATE FUNCTION CalculateOrderTotal (@orderNumber int)
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @totalAmount decimal(10,2) = 0
    DECLARE @productCode varchar(15)
    DECLARE @quantity int
    DECLARE @price decimal(10,2)

    DECLARE orderDetailsCursor CURSOR FOR
    SELECT productCode, quantityOrdered, priceEach
    FROM orderdetails
    WHERE orderNumber = @orderNumber

    OPEN orderDetailsCursor

    FETCH NEXT FROM orderDetailsCursor INTO @productCode, @quantity, @price

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalAmount = @totalAmount + (@quantity * @price)
        FETCH NEXT FROM orderDetailsCursor INTO @productCode, @quantity, @price
    END

    CLOSE orderDetailsCursor
    DEALLOCATE orderDetailsCursor

    RETURN @totalAmount
END

--2 Implementar uma função de banco de dados que, usando um cursor, percorre a tabela de produtos (products) e conta e retorna, com auxílio de uma variável contadora, quantos produtos existem da linha de produtos a qual é passada como parâmetro para a função.

CREATE FUNCTION CountProductsByProductLine (@productLine varchar(50))
RETURNS int
AS
BEGIN
    DECLARE @productCount int = 0
    DECLARE @productName varchar(70)

    DECLARE productCursor CURSOR FOR
    SELECT productName
    FROM products
    WHERE productLine = @productLine

    OPEN productCursor

    FETCH NEXT FROM productCursor INTO @productName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @productCount = @productCount + 1
        FETCH NEXT FROM productCursor INTO @productName
    END

    CLOSE productCursor
    DEALLOCATE productCursor

    RETURN @productCount
END

--3 Implementar uma função de banco de dados que, recebe como parâmetro uma linha de produtos (productline) e, usando um cursor, retorna uma lista de códigos de produtos dessa linha de produtos. A lista deve estar separada por ponto e vírgula (;).

CREATE FUNCTION GetProductCodesByProductLine (@productLine varchar(50))
RETURNS varchar(max)
AS
BEGIN
    DECLARE @productCodesList varchar(max) = ''
    DECLARE @productCode varchar(15)

    DECLARE productCursor CURSOR FOR
    SELECT productCode
    FROM products
    WHERE productLine = @productLine

    OPEN productCursor

    FETCH NEXT FROM productCursor INTO @productCode

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @productCodesList = @productCodesList + @productCode + ';'
        FETCH NEXT FROM productCursor INTO @productCode
    END

    CLOSE productCursor
    DEALLOCATE productCursor

    RETURN @productCodesList
END

--4Implementar uma função de banco de dados que, calcula usando um cursor, o total de pagamentos feitos por um determinado cliente (customer). 
--O número do cliente é passado como argumento e um cursor é usado para percorrer a tabela de payments com o objetivo de acumular o valor da coluna “amount”.

CREATE FUNCTION CalculateTotalPaymentsByCustomer (@customerNumber int)
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @totalPayments decimal(10,2) = 0
    DECLARE @paymentAmount decimal(10,2)

    DECLARE paymentCursor CURSOR FOR
    SELECT amount
    FROM payments
    WHERE customerNumber = @customerNumber

    OPEN paymentCursor

    FETCH NEXT FROM paymentCursor INTO @paymentAmount

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalPayments = @totalPayments + @paymentAmount
        FETCH NEXT FROM paymentCursor INTO @paymentAmount
    END

    CLOSE paymentCursor
    DEALLOCATE paymentCursor

    RETURN @totalPayments
END

--5 Implementar uma function de banco de dados, que retorna os dois produtos, com menor quantidade de estoque por linha de produto. Criar um cursor que percorre a tabela produtlines e a cada iteração na tabela productlines verifica-se 
--dois produtos com menor quantidade de estoque. O resultado pode ser apresentado como uma concatenação de dados do nome dos produtos pela linha de produção.
CREATE FUNCTION GetTwoLowestStockProductsPerProductLine()
RETURNS varchar(max)
AS
BEGIN
    DECLARE @result varchar(max) = ''
    DECLARE @productLine varchar(50)
    DECLARE @productName varchar(70)
    DECLARE @quantityInStock int
    DECLARE @rank int

    -- Declaração do cursor para percorrer as linhas de produto
    DECLARE productLineCursor CURSOR FOR
    SELECT DISTINCT productLine
    FROM products

    OPEN productLineCursor

    FETCH NEXT FROM productLineCursor INTO @productLine

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Declaração do cursor interno para classificar os produtos por quantidade de estoque dentro de cada linha de produto
        DECLARE productStockCursor CURSOR FOR
        SELECT productName, quantityInStock, ROW_NUMBER() OVER (ORDER BY quantityInStock) AS rank
        FROM products
        WHERE productLine = @productLine

        OPEN productStockCursor

        -- Inicializa a variável de rank
        SET @rank = 1

        FETCH NEXT FROM productStockCursor INTO @productName, @quantityInStock, @rank

        -- Selecione os dois produtos com as menores quantidades de estoque para cada linha de produto
        WHILE @@FETCH_STATUS = 0 AND @rank <= 2
        BEGIN
        -- Concatena os nomes dos produtos à variável de resultado
            SET @result = @result + @productName + '; '

            FETCH NEXT FROM productStockCursor INTO @productName, @quantityInStock, @rank
        END

        CLOSE productStockCursor
        DEALLOCATE productStockCursor

        FETCH NEXT FROM productLineCursor INTO @productLine
    END

    CLOSE productLineCursor
    DEALLOCATE productLineCursor

    RETURN @result
END
