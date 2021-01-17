SELECT
	Colab.EmployeeKey,
	Colab.FirstName,
	Colab.MiddleName,
	-- MiddleName = ISNULL(Colab.MiddleName, '_'), --Se for nulo coloca '_'
	Colab.LastName
FROM DimEmployee Colab (nolock)
WHERE
	-- Colab.MiddleName IS NULL -- Retorna apenas quando a coluna é nula
	Colab.MiddleName IS NOT NULL -- Retorna apenas quando a coluna não é nula