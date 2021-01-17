-- UPPER e LOWER
SELECT
	TabProd.ProductKey,
	TabProd.EnglishProductName,
	PROD_MINUSCULA = LOWER(TabProd.EnglishProductName), -- Coloca as letras em minuscula
	PROD_MAIUSCULA = UPPER(TabProd.EnglishProductName) -- Coloca as letras em minuscula
FROM DimProduct as TabProd (nolock);

-- LEFT E RIGHT
SELECT
	Cliente_ID = Cliente.CustomerKey,
	Cliente.EnglishOccupation,
	Cliente_esquerda = LEFT(Cliente.EnglishOccupation, 3), -- Retorna os 3 primeiros caracteres
	liente_direita = RIGHT(Cliente.EnglishOccupation, 3) -- Retorna os 3 últimos caracteres
FROM DimCustomer as Cliente (nolock);

-- LEN
SELECT
	Cliente.CustomerKey,
	Cliente.FirstName,
	Cliente.EmailAddress,
	QTDE_Email = LEN(Cliente.EmailAddress) -- Retorna o tamanho
FROM DimCustomer as Cliente (nolock);

-- CHARINDEX e SUBSTRING
SELECT
	Cliente.CustomerKey,
	Cliente.FirstName,
	Cliente.EmailAddress,
	POSICAO_ARROBA = CHARINDEX('@', Cliente.EmailAddress), -- Aponta a posição do caractere
	POSICAO_A = CHARINDEX('a', Cliente.FirstName),
	SUBPOSICAO_A = CHARINDEX('a', Cliente.FirstName, 5), -- Aponta a posicao do A a partir do 5º caractere
	TEXTOPOS4 = SUBSTRING(Cliente.EmailAddress, 4, 10000), -- Extrai o texto a partir da posição 4
	TEXTOENTRE3E10 = SUBSTRING(Cliente.EmailAddress, 3, 10),  -- Extrai o texto a partir da posição 3 até a posição 10
	DOMINIOEMAIL = SUBSTRING(Cliente.EmailAddress, CHARINDEX('@', Cliente.EmailAddress) + 1, 1000), -- Extrai o texto do @ pra frente
	USERNAME = SUBSTRING(Cliente.EmailAddress, 1, CHARINDEX('@', Cliente.EmailAddress) - 1) -- Extrai o texto até   @
FROM DimCustomer as Cliente (nolock);

-- Limpando espaços
SELECT
	Cliente.CustomerKey,
	Cliente.FirstName,
	Cliente.EmailAddress,
	A = RTRIM(Cliente.AddressLine1), -- limpa espaços a direita
	B = LTRIM(Cliente.AddressLine1), -- limpa espaços a esquerda
	C = TRIM(Cliente.AddressLine1) -- limpa espaços a direita e a esquerda
FROM DimCustomer as Cliente (nolock);

-- REPLACE e CONCAT
SELECT
	Cliente.CustomerKey,
	Cliente.FirstName,
	Cliente.LastName,
	SUBSTITUIR = REPLACE(Cliente.EmailAddress,'@', '#'), -- substitui o @ por #
	NOMECOMPLETO = Cliente.FirstName + ' ' + Cliente.LastName, -- junta os nomes
	NOMECOMPLETO2 = CONCAT(Cliente.FirstName, ' ', Cliente.LastName) -- junta os nomes
FROM DimCustomer as Cliente (nolock);

-- REPLICATE (repete uma sequencia de caracteres
SELECT
	Cliente.CustomerKey,
	Cliente.FirstName,
	Cliente.LastName,
	COD_9 = CONCAT(REPLICATE('0', 9),Cliente.CustomerKey),
	PADRAO_CNPJ = CONCAT(REPLICATE('0', 14 - LEN(Cliente.CustomerKey)), Cliente.CustomerKey)
FROM DimCustomer as Cliente (nolock);

-- ABS (numero absoluto)
SELECT
	Desconto = ABS((Vendas.UnitPriceDiscountPct / 100) * Vendas.ExtendedAmount * -1),
	Vendas.*
FROM FactResellerSales as Vendas (nolock)


-- ROUND, FLOOR e CEILING (Arredondar e extrair numero inteiro)
SELECT
	Preco = Vendas.UnitPrice,
	Preco_Arre = ROUND(Vendas.UnitPrice, 2),
	Preco_ArreBaixo = FLOOR(Vendas.UnitPrice),
	Preco_ArreCima = CEILING(Vendas.UnitPrice)
FROM FactResellerSales as Vendas (nolock)