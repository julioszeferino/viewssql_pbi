USE AdventureWorksDW2016


-- Criando uma tabela com base em outra para testes vazia
/*
SELECT * INTO dbo.DimProduct02 
FROM dbo.DimProduct as produto 
WHERE 1 = 0;
*/

-- Criando uma tabela com base em outra para testes com dados inputados
-- SELECT * INTO dbo.DimProduct03 FROM dbo.DimProduct WHERE ProductKey between 150 and 205;


SET STATISTICS TIME ON

-- Pesquisando sem índice (0 ms de tempo de execução)
SELECT * 
FROM dbo.DimProduct03 as teste 
WHERE teste.ProductKey = '151';

-- Criando um índice na coluna ProductKey de teste
CREATE INDEX idx_ProductKey ON dbo.DimProduct03(ProductKey);

/*
Clusterizado é um indice exclusivo
Não clusterizado, ajuda o banco de dados na busca
*/

-- Pesquisando sem índice (0 ms de tempo de execução)
SELECT 
Size,
teste.Color
FROM dbo.DimProduct03 as teste 
WHERE teste.ProductKey = '151';

-- Deletando o índice
DROP INDEX  dbo.DimProduct03.idx_ProductKey;



