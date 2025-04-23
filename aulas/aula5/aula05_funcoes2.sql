-- Aula 5 - Outras Funções com Cursor
CREATE FUNCTION CountProductsByProductLine (@productLine VARCHAR(50)) RETURNS INT AS
BEGIN
    DECLARE @productCount INT = 0;
    DECLARE @productName VARCHAR(70);
    DECLARE productCursor CURSOR FOR
    SELECT productName FROM products WHERE productLine = @productLine;
    OPEN productCursor;
    FETCH NEXT FROM productCursor INTO @productName;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @productCount = @productCount + 1;
        FETCH NEXT FROM productCursor INTO @productName;
    END;
    CLOSE productCursor;
    DEALLOCATE productCursor;
    RETURN @productCount;
END;

CREATE FUNCTION GetProductCodesByProductLine (@productLine VARCHAR(50)) RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @productCodesList VARCHAR(MAX) = '';
    DECLARE @productCode VARCHAR(15);
    DECLARE productCursor CURSOR FOR
    SELECT productCode FROM products WHERE productLine = @productLine;
    OPEN productCursor;
    FETCH NEXT FROM productCursor INTO @productCode;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @productCodesList = @productCodesList + @productCode + ';';
        FETCH NEXT FROM productCursor INTO @productCode;
    END;
    CLOSE productCursor;
    DEALLOCATE productCursor;
    RETURN @productCodesList;
END;

CREATE FUNCTION CalculateTotalPaymentsByCustomer (@customerNumber INT) RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE @totalPayments DECIMAL(10,2) = 0;
    DECLARE @paymentAmount DECIMAL(10,2);
    DECLARE paymentCursor CURSOR FOR
    SELECT amount FROM payments WHERE customerNumber = @customerNumber;
    OPEN paymentCursor;
    FETCH NEXT FROM paymentCursor INTO @paymentAmount;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalPayments = @totalPayments + @paymentAmount;
        FETCH NEXT FROM paymentCursor INTO @paymentAmount;
    END;
    CLOSE paymentCursor;
    DEALLOCATE paymentCursor;
    RETURN @totalPayments;
END;

CREATE FUNCTION GetTwoLowestStockProductsPerProductLine() RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @result VARCHAR(MAX) = '';
    DECLARE @productLine VARCHAR(50), @productName VARCHAR(70), @quantityInStock INT, @rank INT;

    DECLARE productLineCursor CURSOR FOR SELECT DISTINCT productLine FROM products;
    OPEN productLineCursor;
    FETCH NEXT FROM productLineCursor INTO @productLine;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE productStockCursor CURSOR FOR
        SELECT productName, quantityInStock, ROW_NUMBER() OVER (ORDER BY quantityInStock) AS rank
        FROM products WHERE productLine = @productLine;

        OPEN productStockCursor;
        SET @rank = 1;
        FETCH NEXT FROM productStockCursor INTO @productName, @quantityInStock, @rank;

        WHILE @@FETCH_STATUS = 0 AND @rank <= 2
        BEGIN
            SET @result = @result + @productName + '; ';
            FETCH NEXT FROM productStockCursor INTO @productName, @quantityInStock, @rank;
        END;

        CLOSE productStockCursor;
        DEALLOCATE productStockCursor;

        FETCH NEXT FROM productLineCursor INTO @productLine;
    END;

    CLOSE productLineCursor;
    DEALLOCATE productLineCursor;

    RETURN @result;
END;
