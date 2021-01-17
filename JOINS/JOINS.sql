-- LEFT JOIN
SELECT
	Vendas.ResellerKey,
	Vendas.EmployeeKey,
	Vendas.ExtendedAmount,
	Vendas.ShipDate,
	Vendas.ProductKey,
	NomeColab = Colab.FirstName + ' ' + Colab.LastName,
	Produto.EnglishProductName

FROM FactResellerSales Vendas (nolock)

LEFT JOIN DimEmployee Colab (nolock)
ON Vendas.EmployeeKey = Colab.EmployeeKey -- Buscar usar o índice clusterizado

LEFT JOIN DimProduct Produto (nolock)
ON Vendas.ProductKey = Produto.ProductKey

/*
Quando eu faço um join, ele retorna todas as correspondencias
E nao apenas a primeira, como no caso do PROCV
É preciso tomar cuidado para não duplicar dados
*/

-- Exemplo de JOIN não pensado
SELECT
	*
FROM DimEmployee Colab (nolock)
LEFT JOIN FactResellerSales Vendas (nolock)
ON Colab.EmployeeKey = Vendas.EmployeeKey -- O certo seria partir da informação granulada (vendas) e retornar a do colaborador
WHERE
	Colab.EmployeeKey = '281' -- duplicou os registros


-- RIGHT JOIN
SELECT
	Vendas.ResellerKey,
	Vendas.EmployeeKey,
	Vendas.ExtendedAmount,
	Vendas.ShipDate,
	Vendas.ProductKey,
	NomeColab = Colab.FirstName + ' ' + Colab.LastName

FROM FactResellerSales Vendas (nolock)
RIGHT JOIN DimEmployee Colab (nolock)
ON Vendas.EmployeeKey = Colab.EmployeeKey -- Buscar usar o índice clusterizado

WHERE
	Vendas.ProductKey IS NULL -- Colaboradores que nao tiveram vendas


-- INNER JOIN
SELECT
	Vendas.ResellerKey,
	Vendas.EmployeeKey,
	Vendas.ExtendedAmount,
	Vendas.ShipDate,
	Vendas.ProductKey,
	Vendas.PromotionKey,
	Prom.EnglishPromotionName,
	Prom.DiscountPct,
	DESCONTO = ROUND(Vendas.ExtendedAmount * Prom.DiscountPct, 2)

FROM FactResellerSales Vendas (nolock)

INNER JOIN DimPromotion Prom (nolock)
ON Vendas.PromotionKey = Prom.PromotionKey
AND Prom.PromotionKey <= '5' -- Usar a condição com o inner, só deixa na tabela os dados que tem correspondencia. (Sem necessidade do Where)

WHERE
	Vendas.PromotionKey != '1'


-- FULL OUTER JOIN
SELECT
	Vendas.ResellerKey,
	Vendas.EmployeeKey,
	Vendas.ExtendedAmount,
	Vendas.ShipDate,
	Vendas.ProductKey,
	Vendas.PromotionKey,
	Prom.EnglishPromotionName,
	Prom.DiscountPct,
	DESCONTO = ROUND(Vendas.ExtendedAmount * Prom.DiscountPct, 2)

FROM FactResellerSales Vendas (nolock)

FULL OUTER JOIN DimPromotion Prom (nolock)
ON Vendas.PromotionKey = Prom.PromotionKey


-- JOIN do JOIN (Quando fizer esse tipo de operação, trazer apenas as colunas que for utilizar e usar o INNER JOIN para retornar apenas aquilo que tem correspondencia).
SELECT 
	VENDAS.OrderDate,
	VENDAS.SalesOrderNumber,
	VENDAS.SalesOrderLineNumber,
	VENDAS.ProductKey,
	PRODUTO.EnglishProductName,
	PRODUTO.Color,
	VENDAS.OrderQuantity,
	VENDAS.ExtendedAmount,
	VENDAS.TotalProductCost,
	MARGEM = VENDAS.ExtendedAmount - VENDAS.ProductStandardCost - VENDAS.TaxAmt - VENDAS.Freight,
	VENDAS.ShipDate,
	VENDAS.CarrierTrackingNumber,
	VENDEDOR = COLAB.FirstName+' '+COLAB.LastName,
	REGIAO_VENDA = REGIAO.SalesTerritoryCountry+' / '+REGIAO.SalesTerritoryRegion
	
FROM FactResellerSales VENDAS (NOLOCK)

INNER JOIN DimProduct PRODUTO (NOLOCK) ON
		VENDAS.ProductKey = PRODUTO.ProductKey
	AND PRODUTO.Color != 'RED'

INNER JOIN DimEmployee COLAB (NOLOCK) ON
		VENDAS.EmployeeKey = COLAB.EmployeeKey
	AND COLAB.Gender = 'F'

INNER JOIN DimSalesTerritory REGIAO (NOLOCK) ON
		COLAB.SalesTerritoryKey = REGIAO.SalesTerritoryKey
	AND REGIAO.SalesTerritoryCountry != 'AUSTRALIA'


-- CROSSJOIN
SELECT DISTINCT
	Prod.Productkey,
	Colab.EmployeeKey,
	Vendas.*
FROM DimProduct Prod (nolock)
LEFT JOIN (
	SELECT DISTINCT
		A = 1,
		EmployeeKey
	FROM DimEmployee (nolock)
	) as Colab
ON 1 = Colab.A

-- Usando mais de uma coluna para fazer a ligação
LEFT JOIN FactResellerSales Vendas (nolock)
ON Prod.ProductKey = Vendas.ProductKey
AND Colab.EmployeeKey = Vendas.EmployeeKey

WHERE
	Prod.Color = 'RED'

ORDER BY 
	Prod.ProductKey,
	Colab.EmployeeKey