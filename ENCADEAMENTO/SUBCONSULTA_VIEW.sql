-- ENCADEAMENTO DA MESMA CONSULTA
SELECT
	Vendas.EmployeeKey,
	A.Nome,
	Ano = DATEPART(yyyy, Vendas.ShipDate),
	Total_Vendas = SUM(Vendas.ExtendedAmount)
	
FROM FactResellerSales Vendas 
LEFT JOIN V_PQ_PESSOAS A -- Usando a view V_PQ_PESSOAS
ON Vendas.EmployeeKey = A.ID
GROUP BY
	EmployeeKey,
	DATEPART(yyyy, Vendas.ShipDate),
	A.Nome

/*
SELECT DISTINCT
	CHAVE = Colab.EmployeeKey,
	NOME = Colab.FirstName
FROM DimEmployee Colab
*/
