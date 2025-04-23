-- Aula 2 - Procedure de Processamento de Venda
CREATE PROCEDURE ProcessarVenda @CodProduto INT, @CodUsuario INT, @Quantidade INT AS
BEGIN
    DECLARE @Status INT;
    IF NOT EXISTS (SELECT 1 FROM Produto WHERE CodProduto = @CodProduto)
    BEGIN SET @Status = 4; RETURN @Status; END
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE CodUsuario = @CodUsuario)
    BEGIN SET @Status = 3; RETURN @Status; END
    DECLARE @EstoqueAtual INT;
    SELECT @EstoqueAtual = Estoque FROM Produto WHERE CodProduto = @CodProduto;
    IF @Quantidade <= @EstoqueAtual
    BEGIN
        UPDATE Produto SET Estoque = @EstoqueAtual - @Quantidade WHERE CodProduto = @CodProduto;
        INSERT INTO Venda (CodProduto, CodUsuario, Quantidade) VALUES (@CodProduto, @CodUsuario, @Quantidade);
        SET @Status = 1;
    END
    ELSE SET @Status = 2;
    RETURN @Status;
END;
