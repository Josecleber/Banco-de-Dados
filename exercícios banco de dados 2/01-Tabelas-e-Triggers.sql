
-- Criação das tabelas Funcionario e FuncionarioAuditoria
CREATE TABLE Funcionario(
    IDfuncionario INT PRIMARY KEY NOT NULL,
    IDpessoa INT NOT NULL,
    DataContratacao DATE NOT NULL,
    NomeConjuge VARCHAR(125) NULL,
    QtdFilhos INT NOT NULL,
    Salario DECIMAL(12,2) NOT NULL,
    Observacoes VARCHAR(512) NULL
);

CREATE TABLE FuncionarioAuditoria(
    ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    IDfuncionario INT NOT NULL,
    IDpessoa INT NOT NULL,
    DataContratacao DATE NOT NULL,
    NomeConjuge VARCHAR(125) NULL,
    QtdFilhos INT NOT NULL,
    Salario DECIMAL(12,2) NOT NULL,
    Observacoes VARCHAR(512) NULL
);

-- Inserção de dados na tabela Funcionario
INSERT INTO Funcionario VALUES (
    1, 1, CONVERT(DATETIME, '01/01/2024', 103), 'Joao', 2, 2500, 'Capaz de atuar em qualquer área'
);

-- Trigger para histórico de funcionário ao deletar
CREATE TRIGGER tr_historico_funcionario
ON Funcionario
AFTER DELETE
AS
BEGIN
    INSERT INTO FuncionarioAuditoria
    SELECT IDfuncionario, IDpessoa, DataContratacao, NomeConjuge, QtdFilhos, Salario, Observacoes
    FROM deleted;
END;

-- Criação das tabelas Produto, Estoque, Venda e trigger para atualizar estoque
CREATE TABLE Produto(
    ID INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(50) NOT NULL
);

INSERT INTO Produto VALUES (1, 'Calça');

CREATE TABLE Estoque(
    ID INT PRIMARY KEY NOT NULL,
    ID_Produto INT NOT NULL REFERENCES Produto(ID),
    Quantidade INT NOT NULL
);

INSERT INTO Estoque VALUES (1, 1, 80);

CREATE TABLE Venda(
    ID INT PRIMARY KEY NOT NULL,
    ID_Produto INT NOT NULL REFERENCES Produto(ID),
    Quantidade INT NOT NULL
);

INSERT INTO Venda VALUES (1, 1, 30);

CREATE TRIGGER atualizaEstoque
ON Venda
AFTER INSERT
AS
BEGIN
    DECLARE @quantidade_venda INT,
            @id_produto INT;

    SELECT @id_produto = ID_Produto, @quantidade_venda = Quantidade FROM inserted;

    UPDATE Estoque SET Quantidade = Quantidade - @quantidade_venda
    WHERE ID_Produto = @id_produto;
END;
