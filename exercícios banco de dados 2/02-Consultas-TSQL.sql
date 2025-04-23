
-- Classificação de clientes por volume de vendas
SELECT c.nome,
    CASE
        WHEN COUNT(pe.total) < 1 THEN 'VENDAS BAIXAS'
        WHEN COUNT(pe.total) < 10 THEN 'VENDAS MÉDIAS'
        ELSE 'VENDAS ALTAS'
    END AS classificacao_cliente
FROM cliente c
JOIN pedido pe ON c.id = pe.id_cliente
JOIN item_pedido i ON pe.id = i.id_pedido
JOIN produto pr ON i.id_produto = pr.id
GROUP BY c.nome;

-- Classificação de funcionários por idade
SELECT Nome, Idade,
    CASE
        WHEN Idade < 25 THEN 'Novato'
        WHEN Idade > 40 THEN 'Experiente'
        ELSE 'Moderado'
    END AS Categoria
FROM Funcionario;

-- Classificação de produtividade por peso da colheita
SELECT f.Nome AS NomeFuncionario,
       c.Quantidade AS QuantidadeColhida,
       CASE
           WHEN c.Peso < 1000 THEN 'Não produtivo'
           ELSE 'Produtivo'
       END AS Produtividade
FROM Funcionario f
JOIN Colhido c ON f.FuncionarioID = c.FuncionarioID;
