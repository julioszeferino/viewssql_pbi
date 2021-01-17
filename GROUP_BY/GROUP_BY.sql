-- GROUP BY
SELECT
	-- Agrupadores
	Colab.Gender,
	Prod.Color,

	-- Agrupados
	Soma = Sum(Vendas.ExtendedAmount),
	Maior_Venda = Max(Vendas.ExtendedAmount),
	Menor_Venda = Min(Vendas.ExtendedAmount),
	Media_Vendas = AVG(Vendas.ExtendedAmount)

FROM FactResellerSalesXL_CCI Vendas (nolock)

inner join DimEmployee Colab (nolock)
ON Vendas.EmployeeKey = Colab.EmployeeKey

INNER JOIN DimProduct Prod (nolock)
ON Vendas.ProductKey = Prod.ProductKey
AND Prod.Color != 'Yellow'

GROUP BY
	Colab.Gender,
	Prod.Color

HAVING
	avg(Vendas.ExtendedAmount) > 1500

ORDER BY
	Colab.Gender,
	Prod.Color


/*
O Having serve para filtrar os resultados do group by.
Ajuda a não trazer resultados que não são relevantes para a análise.
*/