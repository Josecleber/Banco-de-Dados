-- Aula 2 - Criação de Tabelas
CREATE TABLE Tipo (
    CodTipo INT PRIMARY KEY,
    NomeTipo VARCHAR(45)
);

CREATE TABLE Produto (
    CodProduto INT PRIMARY KEY,
    CodTipo INT,
    Preco DECIMAL(10,2),
    Estoque INT,
    FOREIGN KEY (CodTipo) REFERENCES Tipo(CodTipo)
);

CREATE TABLE Usuario (
    CodUsuario INT PRIMARY KEY,
    NomeUsuario VARCHAR(45)
);

CREATE TABLE Venda (
    CodVenda INT PRIMARY KEY,
    CodProduto INT,
    CodUsuario INT,
    Quantidade INT,
    FOREIGN KEY (CodProduto) REFERENCES Produto(CodProduto),
    FOREIGN KEY (CodUsuario) REFERENCES Usuario(CodUsuario)
);
