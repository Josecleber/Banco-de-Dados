
-- Inserção de 200 clientes
DECLARE @contador INT = 1;
CREATE TABLE tabela (cliente VARCHAR(100), email CHAR(100), id INT);
WHILE @contador <= 200
BEGIN
    INSERT INTO tabela
    VALUES (
        CONCAT('Cliente', @contador),
        CONCAT('email', @contador, '@uniube.br'),
        10000 + @contador
    );
    SET @contador += 1;
END;

-- Inserção de 50 plantas
DECLARE @contador INT = 1;
WHILE @contador <= 50
BEGIN
    INSERT INTO Planta (PlantaID, Nome, LuzDiaria, Agua, Peso)
    VALUES (
        @contador,
        'Planta ' + CAST(@contador AS VARCHAR(10)),
        0, 0, 0
    );
    SET @contador += 1;
END;
