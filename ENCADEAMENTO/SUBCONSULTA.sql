-- ENCADEAMENTO DA MESMA CONSULTA
SELECT
	Vendas.EmployeeKey,
	A.Nome,
	Ano = DATEPART(yyyy, Vendas.ShipDate),
	Total_Vendas = SUM(Vendas.ExtendedAmount)
	
FROM FactResellerSales Vendas 
INNER JOIN (
SELECT DISTINCT
	CHAVE = Colab.EmployeeKey,
	NOME = Colab.FirstName
FROM DimEmployee Colab
WHERE
	Colab.Gender = 'F'
) A
ON Vendas.EmployeeKey = A.CHAVE
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