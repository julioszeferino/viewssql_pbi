-- Criando uma função
CREATE FUNCTION ClusterIdade -- ALTER FUNCTION para 
(
	-- @Parametro 1,
	-- @Parametro 2,
	@DataAniversario DATE
)
RETURNS VARCHAR(10)
AS BEGIN
	RETURN
		CASE
			WHEN DATEDIFF(YY, @DataAniversario, GETDATE()) >= 60 THEN '60+'
			WHEN DATEDIFF(YY, @DataAniversario, GETDATE()) > 40 THEN '40-59'
			WHEN DATEDIFF(YY, @DataAniversario, GETDATE()) > 30 THEN '30-49'
			ELSE '30-'
		END
END



-- Utilizando
SELECT
	Colab.EmployeeKey,
	Colab.FirstName,
	Colab.BirthDate,
	DataHoje = GETDATE(),
	IDADE = DATEDIFF(YY, Colab.BirthDate, GETDATE()), -- quantos anos eu tenho entre a data do aniversario e hoje
	CLUSTER_IDADE = dbo.ClusterIdade(Colab.BirthDate) -- Aplica a função na data de aniversario
FROM DimEmployee Colab (nolock)


-- Criando Funcao SOMA
CREATE FUNCTION SomaDoisNumeros 
(
	@A FLOAT,
	@B FLOAT
)
RETURNS FLOAT
AS BEGIN
	RETURN
		@A + @B
END


-- Aplicando a função
SELECT
	Vendas.Freight,
	Vendas.TaxAmt,
	FRETEIMPOSTOS = dbo.SomaDoisNumeros(Vendas.Freight, Vendas.TaxAmt)
FROM FactResellerSales Vendas (nolock)