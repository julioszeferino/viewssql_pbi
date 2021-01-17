-- ORDER BY é inimigo da performance!
SELECT
	*
FROM DimEmployee Colab (nolock)

ORDER BY 
	DepartmentName ASC,
	StartDate DESC


-- Retornar os 10 ultimos registros do BD
SELECT TOP 10
	*
FROM DimEmployee Colab (nolock)

ORDER BY 
	StartDate DESC
