-- Índices
-- Como descobrir se a tabela tem índice:
/*
A Tabela DimProduct possui índice nas colunas
ProductKey (clusterizado)
ProductAlternateKey_StartDate (não clusterizado)
*/
SELECT
	*
FROM DimProduct TabProd (nolock)
WHERE 
	TabProd.EnglishProductName = 'BLADE' -- coluna que não tem índice
	AND TabProd.ProductKey >= '' -- estou forçando o bd a usar o índice da coluna product key
	AND TabProd.StartDate >= '' -- estou forçando o bd a usar o índice da coluna start date