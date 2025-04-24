-- 1. Função para prefixar número com 055
CREATE FUNCTION prefixo (@numero INT)
RETURNS VARCHAR(15)
AS
BEGIN
    RETURN CONCAT('055', @numero)
END
GO

-- 2. Função para preços positivos + 5% (ABS + multiplicação)
CREATE FUNCTION ajustes_precos (@numero DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN ABS(@numero) * 1.05
END
GO

-- 3. View + função para gerar preços aleatórios (RAND)
CREATE VIEW numero_randomico AS
SELECT RAND() AS numero
GO

CREATE FUNCTION randomico_preco(@mutiplicador INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (SELECT numero * @mutiplicador FROM numero_randomico)
END
GO

-- 4. Arredondamento de preços com final .99
CREATE FUNCTION arredonda_preco(@valor DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN ROUND(@valor, 0) - 0.01
END
GO

-- 5. Concatenação de dois textos
CREATE FUNCTION concatena_par_valores(@valor1 VARCHAR(MAX), @valor2 VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
    RETURN CONCAT(@valor1, '-', @valor2)
END
GO

-- 6. Data/hora formatada com CURRENT_TIMESTAMP + FORMAT
CREATE FUNCTION data_corrente()
RETURNS CHAR(23)
AS
BEGIN
    RETURN FORMAT(CURRENT_TIMESTAMP, 'dd/MM/yyyy hh:mm:ss fff')
END
GO

-- 7. Verificar se uma tabela existe no banco de dados
CREATE FUNCTION tabela_existe (@nome_tabela VARCHAR(255))
RETURNS BIT
AS
BEGIN
    DECLARE @existe BIT
    IF EXISTS (SELECT 1 FROM sys.tables WHERE name = @nome_tabela)
        SET @existe = 1
    ELSE
        SET @existe = 0
    RETURN @existe
END
GO

-- 8a. Procedure: Buscar produtos de um cliente
CREATE PROCEDURE sp_buscar_produtos_cliente @id_cliente INT
AS
SELECT * FROM produto pr
JOIN item_pedido i ON pr.id = i.id_produto
JOIN pedido p ON i.id_pedido = p.id
JOIN cliente c ON p.id_cliente = c.id
WHERE c.id = @id_cliente
GO

-- 8b. Procedure: Buscar produtos ociosos (não vendidos)
CREATE PROCEDURE sp_buscar_produtos_ocioso @id_produto INT, @preco_minimo DECIMAL(10,2)
AS
SELECT * FROM produto pr
WHERE NOT EXISTS (
    SELECT 1 FROM item_pedido i WHERE pr.id = i.id_produto
)
AND (pr.id = @id_produto OR pr.preco >= @preco_minimo)
GO

-- 9a. Tabelas do DER (canteiro, funcionario, planta, plantio, colhido)
CREATE TABLE canteiro (
    canteiroid INT PRIMARY KEY IDENTITY(1,1),
    nome CHAR(20) NULL,
    luzdiaria INT NULL,
    agua INT NULL
);

CREATE TABLE funcionario (
    funcid INT PRIMARY KEY IDENTITY(1,1),
    nome CHAR(80) NOT NULL,
    idade INT NULL
);

CREATE TABLE planta (
    ID INT PRIMARY KEY IDENTITY(1,1),
    nome CHAR(20) NOT NULL,
    luzdiaria INT NULL,
    agura INT NULL,
    peso INT NULL
);

CREATE TABLE plantio (
    plantioID INT PRIMARY KEY IDENTITY(1,1),
    plantaID INT NOT NULL,
    funcID INT NOT NULL,
    canteiroID INT NOT NULL,
    Data DATE NULL,
    sementes INT NOT NULL DEFAULT 0
);

CREATE TABLE colhido (
    colhidoID INT PRIMARY KEY IDENTITY(1,1),
    plantaID INT NOT NULL,
    funcID INT NOT NULL,
    canteiroID INT NOT NULL,
    Data DATE NULL,
    quantidade INT NOT NULL DEFAULT 0,
    peso FLOAT NOT NULL
);

-- 9b. Relacionamentos (ALTER TABLE + FOREIGN KEY)
ALTER TABLE plantio
ADD CONSTRAINT FK_plantio_planta FOREIGN KEY (plantaID) REFERENCES planta(ID);

ALTER TABLE plantio
ADD CONSTRAINT FK_plantio_funcionario FOREIGN KEY (funcID) REFERENCES funcionario(funcid);

ALTER TABLE plantio
ADD CONSTRAINT FK_plantio_canteiro FOREIGN KEY (canteiroID) REFERENCES canteiro(canteiroid);

ALTER TABLE colhido
ADD CONSTRAINT FK_colhido_planta FOREIGN KEY (plantaID) REFERENCES planta(ID);

ALTER TABLE colhido
ADD CONSTRAINT FK_colhido_funcionario FOREIGN KEY (funcID) REFERENCES funcionario(funcid);

ALTER TABLE colhido
ADD CONSTRAINT FK_colhido_canteiro FOREIGN KEY (canteiroID) REFERENCES canteiro(canteiroid);

-- 9c. Procedure: buscar colheitas por funcionário
CREATE PROCEDURE sp_ColheitaPorFuncionario @funcionarioID INT
AS
BEGIN
    SELECT * FROM colhido
    WHERE funcID = @funcionarioID;
END;
GO

-- 10a. Tabelas do sistema de produtos
CREATE TABLE PRD_DEPARTAMENTO (
    ID_DEPARTAMENTO INT PRIMARY KEY,
    DESCRICAO VARCHAR(255)
);

CREATE TABLE PRD_MARCA (
    ID_MARCA INT PRIMARY KEY,
    DESCRICAO VARCHAR(255)
);

CREATE TABLE PRD_UNIDADE_MEDIDA (
    ID_UNIDADE_MEDIDA INT PRIMARY KEY,
    DESCRICAO VARCHAR(255)
);

CREATE TABLE PRD_CATEGORIA (
    ID_CATEGORIA INT PRIMARY KEY,
    DESCRICAO VARCHAR(255),
    ID_DEPARTAMENTO INT,
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES PRD_DEPARTAMENTO(ID_DEPARTAMENTO)
);

CREATE TABLE PRD_SUBCATEGORIA (
    ID_SUBCATEGORIA INT PRIMARY KEY,
    DESCRICAO VARCHAR(255),
    ID_CATEGORIA INT,
    FOREIGN KEY (ID_CATEGORIA) REFERENCES PRD_CATEGORIA(ID_CATEGORIA)
);

CREATE TABLE PRD_PRODUTO (
    ID_PRODUTO INT PRIMARY KEY,
    CODIGO VARCHAR(50),
    DESCRICAO VARCHAR(255),
    ID_SUBCATEGORIA INT,
    ID_MARCA INT,
    ID_UNIDADE_MEDIDA INT,
    ESPECIFICACAO_TECNICA TEXT,
    STATUS VARCHAR(50),
    PESO_BRUTO DECIMAL(10, 2),
    PESO_LIQUIDO DECIMAL(10, 2),
    QTD_MULT INT,
    QTD_MIN INT,
    COD_BARRA VARCHAR(50),
    FOREIGN KEY (ID_SUBCATEGORIA) REFERENCES PRD_SUBCATEGORIA(ID_SUBCATEGORIA),
    FOREIGN KEY (ID_MARCA) REFERENCES PRD_MARCA(ID_MARCA),
    FOREIGN KEY (ID_UNIDADE_MEDIDA) REFERENCES PRD_UNIDADE_MEDIDA(ID_UNIDADE_MEDIDA)
);

CREATE TABLE PRD_PRODUTO_SIMILAR (
    ID_PRODUTO INT,
    ID_PRODUTO_SIMILAR INT,
    PRIMARY KEY (ID_PRODUTO, ID_PRODUTO_SIMILAR),
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRD_PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_PRODUTO_SIMILAR) REFERENCES PRD_PRODUTO(ID_PRODUTO)
);

CREATE TABLE PRD_PRECO_VENDA (
    ID_PRECO_VENDA INT PRIMARY KEY,
    ID_PRODUTO INT,
    PRECO_VENDA DECIMAL(10, 2),
    DATA_VALIDADE_INICIAL DATE,
    DATA_VALIDADE_FINAL DATE,
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRD_PRODUTO(ID_PRODUTO)
);

-- 10b. Cursor para buscar subcategorias dos departamentos 1 e 2
DECLARE @ID_DEPARTAMENTO1 INT = 1;
DECLARE @ID_DEPARTAMENTO2 INT = 2;
DECLARE Cur_Subcategorias CURSOR FOR
SELECT sc.ID_SUBCATEGORIA, sc.DESCRICAO
FROM PRD_SUBCATEGORIA sc
JOIN PRD_CATEGORIA c ON sc.ID_CATEGORIA = c.ID_CATEGORIA
WHERE c.ID_DEPARTAMENTO IN (@ID_DEPARTAMENTO1, @ID_DEPARTAMENTO2);

OPEN Cur_Subcategorias;
FETCH NEXT FROM Cur_Subcategorias;
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Aqui você pode realizar ações com as subcategorias
    FETCH NEXT FROM Cur_Subcategorias;
END;
CLOSE Cur_Subcategorias;
DEALLOCATE Cur_Subcategorias;

-- 10c. Procedure para excluir subcategorias sem produtos
CREATE PROCEDURE ExcluirSubcategoriasSemProdutos
AS
BEGIN
    DECLARE @ID_DEPARTAMENTO1 INT = 1;
    DECLARE @ID_DEPARTAMENTO2 INT = 2;
    DECLARE @ID_SUBCATEGORIA INT;
    DECLARE @DESCRICAO VARCHAR(255);

    DECLARE Cur_Subcategorias CURSOR FOR
    SELECT sc.ID_SUBCATEGORIA, sc.DESCRICAO
    FROM PRD_SUBCATEGORIA sc
    JOIN PRD_CATEGORIA c ON sc.ID_CATEGORIA = c.ID_CATEGORIA
    WHERE c.ID_DEPARTAMENTO IN (@ID_DEPARTAMENTO1, @ID_DEPARTAMENTO2);

    OPEN Cur_Subcategorias;
    FETCH NEXT FROM Cur_Subcategorias INTO @ID_SUBCATEGORIA, @DESCRICAO;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (
            SELECT 1 FROM PRD_PRODUTO p WHERE p.ID_SUBCATEGORIA = @ID_SUBCATEGORIA
        )
        BEGIN
            DELETE FROM PRD_SUBCATEGORIA WHERE ID_SUBCATEGORIA = @ID_SUBCATEGORIA;
        END
        FETCH NEXT FROM Cur_Subcategorias INTO @ID_SUBCATEGORIA, @DESCRICAO;
    END;

    CLOSE Cur_Subcategorias;
    DEALLOCATE Cur_Subcategorias;
END;
GO
