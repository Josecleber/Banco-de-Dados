-- Aula 4 - Procedure com Cursor
CREATE PROCEDURE UpdateStockQuantity @totalQuantityInStock DECIMAL(10,2) OUTPUT AS
BEGIN
    DECLARE @productCode VARCHAR(15), @quantityInStock DECIMAL(10,2);
    SET @totalQuantityInStock = 0;
    DECLARE productCursor CURSOR FOR SELECT productCode, quantityInStock FROM products;
    OPEN productCursor;
    FETCH NEXT FROM productCursor INTO @productCode, @quantityInStock;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @quantityInStock <= 1000
            SET @totalQuantityInStock = @totalQuantityInStock + @quantityInStock;
        FETCH NEXT FROM productCursor INTO @productCode, @quantityInStock;
    END
    CLOSE productCursor;
    DEALLOCATE productCursor;
END;
