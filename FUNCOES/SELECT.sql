-- Selecionando dados da tabela DimProduct
SELECT
	-- * -- Todas as colunas
	-- TabProd.* -- Todas as colunas
	COD_PRUDUTO = TabProd.ProductKey, -- renomeando o nome da coluna
	TabProd.ProductAlternateKey AS PROD_COD, -- renomeando o nome da coluna
	TabProd.EnglishProductName
FROM DimProduct TabProd (nolock)
WHERE
	/*
	TabProd.ProductKey >= '100'
	AND TabProd.ProductKey <= '115'
	AND TabProd.ProductKey != '110' -- pode ser como <> (!= negacao da igualdade)
	*/
	/*
	TabProd.ProductKey = '101'
	OR TabProd.ProductKey = '107'
	OR TabProd.ProductKey = '125'
	*/
	-- TabProd.ProductKey IN ('101', '107', '125') -- Mais performatico que o OR
	-- TabProd.ProductKey NOT IN ('101', '107', '125') -- funciona apenas na frente de listas
	-- TabProd.EnglishProductName  LIKE('%WASHER%') -- contém washer
	-- TabProd.EnglishProductName NOT LIKE('%WASHER%') -- não contém washer
	-- TabProd.EnglishProductName LIKE('LOCK%') -- comeca com lock
	TabProd.EnglishProductName LIKE('%LOCK') -- termina com


/*
O Like não é performático.
*/

