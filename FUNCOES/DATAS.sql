-- GET DATE e FORMATOS DE DATA
SELECT 
	DATA_ENVIO = Vendas.ShipDate,
	HOJE = GETDATE(), --recupera a data e hora atuais
	HOJE_2 = CONVERT(VARCHAR(8), GETDATE(), 112), -- 112: yyyymmdd
	MES_ENVIO = CONVERT(VARCHAR(6), Vendas.ShipDate, 112), -- 112: yyyymm
	Vendas.*
FROM FactResellerSales Vendas (nolock)
WHERE 
	-- CONVERT(VARCHAR(6),Vendas.ShipDate, 112) = '201303'
	CONVERT(VARCHAR(6),Vendas.ShipDate, 112) IN ('201303', '201212')


/*
FORMATOS DE DATA
https://docs.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15
*/

-- DATEPART (extraindo fragmentos de data)
SELECT
	AnoEnvio = DATEPART(yyyy, Vendas.ShipDate),
	TrimEnvio = DATEPART(q, Vendas.ShipDate),
	MesEnvio = DATEPART(m, Vendas.ShipDate),
	DiaSemana = DATEPART(dw, Vendas.ShipDate),
	Vendas.*

FROM FactResellerSales Vendas (nolock)

/*
DATEPART
https://docs.microsoft.com/pt-br/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15
*/

-- DATEADD (adicionar ou subtrair dateparts a data)
SELECT
	DataEnvio = Vendas.ShipDate,
	DataEnvioRecalc = DATEADD(d, 5, Vendas.ShipDate), -- Soma 5 dias a data
	DataEnvioRecalcNeg = DATEADD(d, -5, Vendas.ShipDate), -- Subtrai 5 dias a data
	Vendas.*

FROM FactResellerSales Vendas (nolock)
WHERE
Vendas.ShipDate >=
DATEADD(
m, -- vou adicionar meses
-3, -- 3 ultimos
(
SELECT
	MAX(Vendas.ShipDate) -- A ultima data 
FROM FactResellerSales Vendas (nolock)
)) -- A ultima data do bd

-- DATEDIFF (Diferenca entre datas)
SELECT
	Colab.EmployeeKey,
	Colab.FirstName,
	Colab.BirthDate,
	DataHoje = GETDATE(),
	IDADE = DATEDIFF(YY, Colab.BirthDate, GETDATE()), -- quantos anos eu tenho entre a data do aniversario e hoje
	
	CLUSTER_IDADE =
		CASE
			WHEN DATEDIFF(YY, Colab.BirthDate, GETDATE()) >= 60 THEN '60+'
			WHEN DATEDIFF(YY, Colab.BirthDate, GETDATE()) > 40 THEN '40-59'
			WHEN DATEDIFF(YY, Colab.BirthDate, GETDATE()) > 30 THEN '30-49'
			ELSE '30-'
		END
		

FROM DimEmployee Colab (nolock)
--WHERE
	--DATEDIFF(YY, Colab.BirthDate, GETDATE()) >= 30