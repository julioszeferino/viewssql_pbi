CREATE VIEW V_PQ_VENDAS_ATE_2012 AS

SELECT
	Vendas.EmployeeKey,
	A.Nome,
	Ano = DATEPART(yyyy, Vendas.ShipDate),
	Total_Vendas = SUM(Vendas.ExtendedAmount)
FROM FactResellerSales Vendas 
LEFT JOIN V_PQ_PESSOAS A -- Usando a view V_PQ_PESSOAS
ON Vendas.EmployeeKey = A.ID
WHERE
	DATEPART(yyyy, Vendas.ShipDate) <= '2012'
GROUP BY
	EmployeeKey,
	DATEPART(yyyy, Vendas.ShipDate),
	A.Nome