CREATE DATABASE PescadorExperiente;

CREATE TABLE Produtos (
    ID_Produto INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Quantidade_Estoque INT NOT NULL
);

INSERT INTO Produtos (ID_Produto, Nome, Descricao, Preco, Quantidade_Estoque)
VALUES
    (1, 'Vara de Pesca Telescópica', 'Vara de pesca telescópica de fibra de carbono, tamanho ajustável de 1.8m a 3.6m', 49.99, 30),
    (2, 'Iscas Artificiais', 'Conjunto de 10 iscas artificiais coloridas, imitação realista de diferentes tipos de peixes', 12.99, 50),
    (3, 'Carretilha de Pesca', 'Carretilha de pesca de alto desempenho, sistema de freio magnético, 7 rolamentos', 129.99, 20),
    (4, 'Anzol de Pesca', 'Conjunto de 50 anzóis de pesca de aço carbono, tamanhos variados', 6.99, 100),
    (5, 'Caixa de Pesca', 'Caixa de pesca resistente à água, com compartimentos ajustáveis e alça de transporte', 29.99, 15),
    (6, 'Linhas de Pesca', 'Pacote com 3 rolos de linha de pesca trançada, resistente e de baixa visibilidade', 17.99, 40),
    (7, 'Chumbada de Pesca', 'Conjunto de 20 chumbadas de pesca de diferentes pesos, revestimento antiderrapante', 8.99, 80),
    (8, 'Molinete de Pesca', 'Molinete de pesca leve e durável, sistema de anti-reverso instantâneo, 4 rolamentos', 69.99, 25),
    (9, 'Óculos Polarizados', 'Óculos polarizados para pesca, proteção UV, lentes anti-reflexo', 34.99, 10),
    (10, 'Bolsa de Pesca', 'Bolsa de pesca com múltiplos bolsos, compartimento térmico para iscas vivas', 39.99, 12),
    (11, 'Colete Salva-Vidas', 'Colete salva-vidas para pesca, ajustável e com bolsos para armazenamento de equipamentos', 49.99, 8),
    (12, 'Lanterna Subaquática', 'Lanterna subaquática de LED, resistente à água, feixe de luz ajustável', 24.99, 18),
    (13, 'Facas de Filetagem', 'Conjunto de 3 facas de filetagem, lâminas de aço inoxidável e cabo antiderrapante', 19.99, 22),
    (14, 'Estojo de Anzol', 'Estojo de anzol com 100 compartimentos individuais, transparente e resistente', 14.99, 35),
    (15, 'GPS para Pesca', 'GPS portátil para pesca, marcação de pontos de interesse e navegação precisa', 89.99, 5),
    (16, 'Rede de Pesca', 'Rede de pesca com cabo extensível, malha resistente e aro de alumínio', 21.99, 28),
    (17, 'Sinalizador de Boia', 'Sinalizador de boia luminoso, visibilidade noturna e bateria de longa duração', 9.99, 60),
    (18, 'Caixa Térmica', 'Caixa térmica para armazenar iscas e alimentos, capacidade de 20 litros', 49.99, 10),
    (19, 'Luvas de Pesca', 'Luvas de pesca resistentes à água, palma antiderrapante e ajuste de pulso', 11.99, 45),
    (20, 'Binóculos à Prova d''Água', 'Binóculos à prova d''água para observação de aves aquáticas e pontos de pesca', 79.99, 7),
    (21, 'Caixa de Pesca Multifuncional', 'Caixa de pesca multifuncional com bandejas removíveis e espaço para acessórios', 59.99, 8),
    (22, 'Saco Estanque', 'Saco estanque para armazenar equipamentos de pesca e protegê-los da água', 19.99, 20),
    (23, 'Capa de Vara de Pesca', 'Capa protetora para vara de pesca, material resistente e fecho ajustável', 8.99, 30),
    (24, 'Balança Digital', 'Balança digital portátil para pesca, capacidade de até 50kg e visor iluminado', 29.99, 15),
    (25, 'Alicate Multifuncional', 'Alicate multifuncional para pesca, cortador de linha, abridor de garrafas e mais', 16.99, 25),
    (26, 'Guarda-Sol para Pesca', 'Guarda-sol para pesca com estrutura resistente e inclinação ajustável', 39.99, 10),
    (27, 'Caixa de Acessórios', 'Caixa de acessórios para pesca, divisórias ajustáveis e fecho hermético', 12.99, 40),
    (28, 'Coletes Térmicos', 'Coletes térmicos para pesca, tecido isolante e bolsos internos para aquecedores', 54.99, 6),
    (29, 'Bússola de Navegação', 'Bússola de navegação para pesca, design compacto e leitura precisa', 9.99, 35),
    (30, 'Saco Térmico para Iscas Vivas', 'Saco térmico para iscas vivas, isolamento térmico e alça de transporte', 24.99, 12);

	CREATE TABLE Funcionarios (
    ID_Funcionario INT PRIMARY KEY NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Cargo VARCHAR(100) NOT NULL,
    Data_Admissao DATE NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL
);

INSERT INTO Funcionarios (ID_Funcionario, Nome, Cargo, Data_Admissao, Salario)
VALUES
    (1, 'João Silva', 'Vendedor', '2024-01-15', 2500.00),
    (2, 'Maria Santos', 'Gerente de Loja', '2024-01-10', 3500.00),
    (3, 'Luiz Antônio', 'Operador de Caixa', '2024-01-12', 2000.00);

CREATE TABLE Fornecedores (
    ID_Fornecedor INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    ID_Produto_Fornecido INT NOT NULL,
    FOREIGN KEY (ID_Produto_Fornecido) REFERENCES Produtos(ID_Produto)
);

INSERT INTO Fornecedores (ID_Fornecedor, Nome, Endereco, Email, Telefone, ID_Produto_Fornecido)
VALUES
    (1, 'Fornecedor Varas', 'Rua São Pedro, 128', 'fornecedorvaras@gmail.com', '(11) 1234-5678', 1),
    (2, 'Fornecedor Iscas', 'Rua Treze de Maio, 456', 'fornecedoriscas@gmail.com', '(22) 9876-5432', 2),
    (3, 'Fornecedor Carretilha', 'Rua da Paz, 789', 'fornecedorcarretilha@gmail.com', '(33) 4567-8901', 3),
    (4, 'Fornecedor Anzol', 'Rua Alameda dos Criadores, 1011', 'fornecedoranzol@gmail.com', '(44) 2345-6789', 4),
    (5, 'Fornecedor Caixa', 'Rua Maria das Flores, 1213','fornecedorcaixa@gmail.com', '(55) 7890-1234', 5),
    (6, 'Fornecedor Linha', 'Rua Castro Alves, 1415', 'fornecedorlinha@gmail.com', '(66) 8901-2345', 6),
    (7, 'Fornecedor Chumbada', 'Rua São Benedito, 1617', 'fornecedorchumbada@gmail.com', '(77) 0123-4567', 7),
    (8, 'Fornecedor Molinete', 'Rua João da Silva, 1819', 'fornecedormolinete@gmail.com', '(88) 2345-6789', 8),
    (9, 'Fornecedor Óculos', 'Rua Maria José, 2021', 'fornecedor óculos@gmail.com', '(99) 3456-7890', 9),
    (10, 'Fornecedor Bolsa', 'Rua São João, 2223', 'fornecedor bolsa@gmail.com', '(00) 4567-8901', 10),
    (11, 'Fornecedor Colete', 'Rua Bahia, 2425', 'fornecedorcolete@gmail.com', '(11) 8901-2345', 11),
    (12, 'Fornecedor Lanterna', 'Rua Tiradentes, 2627', 'fornecedorlanterna@gmail.com', '(22) 1234-5678', 12),
    (13, 'Fornecedor Facas', 'Rua São Francisco, 2829', 'fornecedorfacas@gamil.com', '(33) 4567-8901', 13),
    (14, 'Fornecedor Estojo', 'Rua Campo Florido, 3031', 'fornecedorestojo@gmail.com', '(44) 2345-6789', 14),
    (15, 'Fornecedor GPS', 'Rua Ceará, 3233', 'fornecedor god@gmail.com', '(55) 7890-1234', 15),
    (16, 'Fornecedor Rede', 'Rua Goiás, 3435', 'fornecedor rede@gmail.com', '(66) 8901-2345', 16),
    (17, 'Fornecedor Sinalizador', 'Rua Praça da Fé, 3637', 'fornecedor sinalizador@gmail.com', '(77) 0123-4567', 17),
    (18, 'Fornecedor Caixa Térmica', 'Rua Alameda dos Criadores, 3839', 'fornecedortermicas@gmail.com', '(88) 2345-6789', 18),
    (19, 'Fornecedor Luva', 'Rua Pernambuco, 4041', 'fornecedor luva@gmail.com', '(99) 3456-7890', 19),
    (20, 'Fornecedor Binóculos', 'Rua Vitória, 4243', 'fornecedorbinoculo@gmail.com', '(00) 4567-8901', 20);

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20) NOT NULL
);

INSERT INTO Clientes (ID_Cliente, Nome, Endereco, Email, Telefone)
VALUES
    (1, 'Ana Silva', 'Rua das Flores, 123', 'ana.silva@gmail.com', '(11) 1234-5678'),
    (2, 'Pedro Oliveira', ' Rua dos Pescadores, 456', 'pedro.oliveira@gmail.com', '(22) 9876-5432'),
    (3, 'Mariana Santos', 'Rua Travessa das Águas, 789', 'mariana.santos@gmail.com', '(33) 4567-8901'),
    (4, 'Lucas Pereira', 'Rua Alameda das Ondas, 1011', 'lucas.pereira@gmail.com', '(44) 2345-6789'),
    (5, 'Juliana Costa', 'Rua dos Rios, 1213', 'juliana.costa@gmail.com', '(55) 7890-1234'),
    (6, 'Fernando Souza', 'Rua das Marés, 1415', 'fernando.souza@gmail.com', '(66) 8901-2345'),
    (7, 'Camila Martins', 'Rua das Pescarias, 1617', 'camila.martins@gmail.com', '(77) 0123-4567'),
    (8, 'Rafaela Lima', 'Rua dos Pescadores, 1819', 'rafaela.lima@gmail.com', '(88) 2345-6789'),
    (9, 'Gustavo Barbosa', 'Rua das Trutas, 2021', 'gustavo.barbosa@gmail.com', '(99) 3456-7890'),
    (10, 'Carolina Fernandes', 'Rua Alameda das Sardinhas, 2223', 'carolina.fernandes@gmail.com', '(00) 4567-8901');

CREATE TABLE Pedidos (
    ID_Pedido INT PRIMARY KEY NOT NULL,
    ID_Cliente INT NOT NULL,
    Data_Pedido DATE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

INSERT INTO Pedidos (ID_Pedido, ID_Cliente, Data_Pedido)
VALUES
    (1, 1, '2024-03-28'),
    (2, 2, '2024-03-27'),
    (3, 3, '2024-03-26'),
    (4, 4, '2024-03-25'),
    (5, 5, '2024-03-24'),
    (6, 6, '2024-03-23'),
    (7, 7, '2024-03-22'),
    (8, 8, '2024-03-21'),
    (9, 9, '2024-03-20'),
    (10, 10, '2024-03-19');

CREATE TABLE DetalhesPedido (
    ID_Detalhe INT PRIMARY KEY NOT NULL,
    ID_Pedido INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

INSERT INTO DetalhesPedido (ID_Detalhe, ID_Pedido, ID_Produto, Quantidade, Preco)
VALUES
    (1, 1, 15, 1, 89.99),
    (2, 2, 3, 1, 129.99),
    (3, 3, 8, 1, 69.99),
    (4, 4, 20, 1, 79.99),
    (5, 5, 18, 1, 49.99),
    (6, 6, 16, 1, 21.99),
    (7, 7, 10, 1, 39.99),
    (8, 8, 12, 1, 24.99),
    (9, 9, 1, 1, 49.99),
    (10, 10, 28, 1, 54.99);

CREATE TABLE ComentariosClientes (
    ID_Comentario INT PRIMARY KEY NOT NULL,
    ID_Cliente INT NOT NULL,
    Comentario VARCHAR(255) NOT NULL,
    Classificacao INT NOT NULL,
    Data_Comentario DATE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

INSERT INTO ComentariosClientes (ID_Comentario, ID_Cliente, Comentario, Classificacao, Data_Comentario)
VALUES
    (1, 1, 'Ótimo atendimento e produtos de qualidade!', 5, '2024-03-28'),
    (2, 2, 'Entrega rápida e produto conforme anunciado.', 4, '2024-03-27'),
    (3, 3, 'Preço um pouco alto, mas vale a pena pela qualidade.', 4, '2024-03-26'),
    (4, 4, 'Produto excelente, superou minhas expectativas.', 5, '2024-03-25'),
    (5, 5, 'Bom custo-benefício, recomendo.', 4, '2024-03-24');

CREATE TABLE FeedbackFuncionarios (
    ID_Feedback INT PRIMARY KEY NOT NULL,
    ID_Funcionario INT NOT NULL,
    Comentario VARCHAR(255) NOT NULL,
    Data_Feedback DATE NOT NULL,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Funcionario)
);

INSERT INTO FeedbackFuncionarios (ID_Feedback, ID_Funcionario, Comentario, Data_Feedback)
VALUES
    (1, 1, 'Ótimo trabalho! Sempre prestativo e atencioso.', '2024-03-30'),
    (2, 2, 'Muito educada e proativa.', '2024-03-30'),
    (3, 3, 'Excelente desempenho durante o horário de pico.', '2024-03-30');

CREATE TABLE Pagamentos (
    ID_Pagamento INT PRIMARY KEY NOT NULL,
    ID_Pedido INT NOT NULL,
    Metodo_Pagamento VARCHAR(50) NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Data_Pagamento DATE NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido)
);

INSERT INTO Pagamentos (ID_Pagamento, ID_Pedido, Metodo_Pagamento, Valor, Data_Pagamento)
VALUES
    (1, 1, 'Cartão de Crédito', 89.99, '2024-03-28'),
    (2, 2, 'Cartão de Débito', 129.99, '2024-03-27'),
    (3, 3, 'Dinheiro', 69.99, '2024-03-26'),    
    (4, 4, 'Dinheiro', 79.99, '2024-03-25'),
    (5, 5, 'Cartão de Crédito', 49.99, '2024-03-24'),
    (6, 6, 'Dinheiro', 21.99, '2024-03-23'),  
    (7, 7, 'Cartão de Débito', 39.99, '2024-03-22'),
    (8, 8, 'Dinheiro', 24.99, '2024-03-21'),
    (9, 9, 'Cartão de Crédito', 49.99, '2024-03-20'),
	(10, 10, 'Cartão de Débito', 54.99, '2024-03-19');

SELECT 
    ID_Pedido,
    CASE 
        WHEN Quantidade <= 10 THEN 'Pequeno'
        WHEN Quantidade <= 20 THEN 'Médio'
        ELSE 'Grande'
    END AS Tamanho
FROM 
    DetalhesPedido;


DECLARE @contador INT = 1;
DECLARE @totalPedidos INT;

SELECT @totalPedidos = COUNT(*) FROM Pedidos;

WHILE @contador <= @totalPedidos
BEGIN
    DECLARE @ID_Pedido INT;
    DECLARE @Data_Pedido DATE;

    SELECT @ID_Pedido = ID_Pedido, @Data_Pedido = Data_Pedido
    FROM Pedidos
    WHERE ID_Pedido = @contador;

    PRINT 'Pedido ID: ' + CAST(@ID_Pedido AS VARCHAR) + ', Data do Pedido: ' + CAST(@Data_Pedido AS VARCHAR);

    SET @contador = @contador + 1;
END;

CREATE FUNCTION dbo.VerificarQuantidadeEmEstoque (@ID_Produto INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @QuantidadeEmEstoque varchar(50)

    SELECT @QuantidadeEmEstoque = Quantidade_Estoque
    FROM Produtos
    WHERE ID_Produto = @ID_Produto

    IF @QuantidadeEmEstoque > 0
        SET @QuantidadeEmEstoque = 'Em estoque'
    ELSE
        SET @QuantidadeEmEstoque = 'Sem estoque'
		RETURN @QuantidadeEmEstoque
END;


SELECT Nome, dbo.VerificarQuantidadeEmEstoque(ID_Produto) AS Status_Estoque
FROM Produtos;



CREATE PROCEDURE EstoquePequeno
AS
BEGIN
    DECLARE @ProdutoDisponivel INT = 0;
    DECLARE @ID_ProdutoVerificar INT = 5;
    DECLARE @Contador INT = 0;

    WHILE @Contador < 1
    BEGIN
        SELECT @ProdutoDisponivel = Quantidade_Estoque
        FROM Produtos
        WHERE ID_Produto = @ID_ProdutoVerificar;

        IF @ProdutoDisponivel IS NOT NULL
        BEGIN
            PRINT 'O produto com ID ' + CAST(@ID_ProdutoVerificar AS NVARCHAR(10)) + ' está disponível em estoque.';
        END
        ELSE
        BEGIN
            PRINT 'O produto com ID ' + CAST(@ID_ProdutoVerificar AS NVARCHAR(10)) + ' não está disponível em estoque.';
            BREAK; -- Interrompe a execução do loop
        END;

        SET @Contador = @Contador + 1;
    END;
END;

EXEC EstoquePequeno;



CREATE INDEX IX_Pedidos_ID_Cliente ON Pedidos (ID_Cliente);

SELECT * FROM Pedidos
WHERE ID_Cliente = 1;


CREATE TRIGGER AtualizarEstoque
ON DetalhesPedido
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ID_Produto INT;
    DECLARE @Quantidade INT;

    -- Obtém o ID do produto e a quantidade do pedido inserido
    SELECT @ID_Produto = ID_Produto, @Quantidade = Quantidade
    FROM inserted;

    -- Atualiza a quantidade de estoque do produto
    UPDATE Produtos
    SET Quantidade_Estoque = Quantidade_Estoque - @Quantidade
    WHERE ID_Produto = @ID_Produto;
END;

INSERT INTO DetalhesPedido (ID_Detalhe, ID_Pedido, ID_Produto, Quantidade, Preco)
VALUES (11, 1, 15, 1, 89.99);

SELECT Quantidade_Estoque
FROM Produtos
WHERE ID_Produto = 15;

DECLARE @ID_Comentario INT = 1;

WHILE @ID_Comentario <= (SELECT MAX(ID_Comentario) FROM ComentariosClientes)
BEGIN
    DECLARE @Classificacao INT;
    SELECT @Classificacao = Classificacao FROM ComentariosClientes WHERE ID_Comentario = @ID_Comentario;

    IF @Classificacao < 5
    BEGIN
        PRINT 'Comentário de ID ' + CAST(@ID_Comentario AS VARCHAR(10)) + ' possui classificação menor que 5.';
    END
    ELSE
    BEGIN
        SET @ID_Comentario = @ID_Comentario + 1;
        CONTINUE;
    END

    SET @ID_Comentario = @ID_Comentario + 1;
END;