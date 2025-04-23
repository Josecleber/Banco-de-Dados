-- Aula 5 - Function com Cursor
CREATE FUNCTION CalculateOrderTotal (@orderNumber INT) RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE @totalAmount DECIMAL(10,2) = 0;
    DECLARE @productCode VARCHAR(15), @quantity INT, @price DECIMAL(10,2);
    DECLARE orderDetailsCursor CURSOR FOR
    SELECT productCode, quantityOrdered, priceEach FROM orderdetails WHERE orderNumber = @orderNumber;
    OPEN orderDetailsCursor;
    FETCH NEXT FROM orderDetailsCursor INTO @productCode, @quantity, @price;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalAmount = @totalAmount + (@quantity * @price);
        FETCH NEXT FROM orderDetailsCursor INTO @productCode, @quantity, @price;
    END;
    CLOSE orderDetailsCursor;
    DEALLOCATE orderDetailsCursor;
    RETURN @totalAmount;
END;
