-- VARIAVEIS
DECLARE @SEXO VARCHAR(1)
SET @SEXO = 'M' -- Isso aqui pode ser dinâmico (Por exemplo, a última data de atualização)

SELECT
	*
FROM DimEmployee
WHERE
	Gender = @SEXO