-- ALIMENTANDO A TABELA VIRTUAL
SELECT TOP 5
	CodFunc = Vendas.EmployeeKey
	into #Maiores -- Armazena os maiores vendedores

FROM FactResellerSalesXL_CCI Vendas
WHERE
	DATEPART(YY, ShipDate) = '2013'
GROUP BY
	Vendas.EmployeeKey
ORDER BY
	SUM(ExtendedAmount) DESC

-- CONSULTANDO A TABELA VIRTUAL
SELECT *
FROM #Maiores

-- CONSULTANDO AS VENDAS (recupera as info dos maiores vendedores)
SELECT *
FROM FactResellerSalesXL_CCI Vendas
INNER JOIN #Maiores M
ON Vendas.EmployeeKey = M.CodFunc
WHERE
	DATEPART(YY, ShipDate) = '2013'

-- Excluindo a Tabela Virtual
DROP TABLE #Maiores