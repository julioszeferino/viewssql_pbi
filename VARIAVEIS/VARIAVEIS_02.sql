------- variaveis -------

DECLARE @DATA_FIM DATE
SET @DATA_FIM = (
SELECT 
	MAX(Vendas.ShipDate)
FROM FactResellerSalesXL_CCI Vendas (nolock)
)


DECLARE @DATA_INI DATE
SET @DATA_INI = (DATEADD(m, -6, @DATA_FIM)) -- recuperar os ultimos 6 meses


DECLARE @PER_INICIAL VARCHAR(6)
SET @PER_INICIAL = CONVERT(VARCHAR(6), @DATA_INI, 112) -- Para recuperar os ultimos 6 meses inteiros

DECLARE @PERIODO_FIM VARCHAR(6)
SET @PERIODO_FIM = CONVERT(VARCHAR(6), @DATA_FIM, 112)

------- consulta -------

SELECT
	*
FROM FactResellerSalesXL_CCI Vendas (nolock)
WHERE
	CONVERT(VARCHAR(6), Vendas.ShipDate, 112) >= @PER_INICIAL
	AND CONVERT(VARCHAR(6), Vendas.ShipDate, 112) <= @PERIODO_FIM

