-- Aula 2 - Functions
CREATE FUNCTION GetEstoque(@CodProduto INT) RETURNS INT AS
BEGIN
    DECLARE @QuantidadeEstoque INT;
    SELECT @QuantidadeEstoque = Estoque FROM Produto WHERE CodProduto = @CodProduto;
    RETURN @QuantidadeEstoque;
END;

CREATE FUNCTION GetTipoNome(@CodProduto INT) RETURNS VARCHAR(45) AS
BEGIN
    DECLARE @NomeTipo VARCHAR(45);
    SELECT @NomeTipo = NomeTipo FROM Tipo t INNER JOIN Produto p ON t.CodTipo = p.CodTipo WHERE p.CodProduto = @CodProduto;
    RETURN @NomeTipo;
END;

CREATE FUNCTION CalcularValorEstoque(@CodProduto INT) RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE @ValorEstoque DECIMAL(10,2);
    SELECT @ValorEstoque = Preco * Estoque FROM Produto WHERE CodProduto = @CodProduto;
    RETURN @ValorEstoque;
END;

CREATE FUNCTION GetQuantidadeVendida(@CodVenda INT) RETURNS INT AS
BEGIN
    DECLARE @Quantidade INT;
    SELECT @Quantidade = Quantidade FROM Venda WHERE CodVenda = @CodVenda;
    RETURN @Quantidade;
END;

CREATE FUNCTION CalcularTotalVenda(@CodVenda INT) RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = Quantidade * Preco FROM Venda v INNER JOIN Produto p ON v.CodProduto = p.CodProduto WHERE CodVenda = @CodVenda;
    RETURN @Total;
END;

CREATE FUNCTION ContarProdutosComprados(@CodUsuario INT) RETURNS INT AS
BEGIN
    DECLARE @Contagem INT;
    SELECT @Contagem = COUNT(*) FROM Venda WHERE CodUsuario = @CodUsuario;
    RETURN @Contagem;
END;

CREATE FUNCTION CalcularMediaQuantidadeVendida(@CodProduto INT) RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE @Media DECIMAL(10,2);
    SELECT @Media = AVG(Quantidade) FROM Venda WHERE CodProduto = @CodProduto;
    RETURN @Media;
END;

CREATE FUNCTION VerificarGastos(@CodUsuario INT) RETURNS INT AS
BEGIN
    DECLARE @Gastos DECIMAL(10,2);
    SELECT @Gastos = SUM(Quantidade * Preco) FROM Venda v INNER JOIN Produto p ON v.CodProduto = p.CodProduto WHERE CodUsuario = @CodUsuario;
    IF @Gastos > 200 RETURN 1;
    RETURN 0;
END;
