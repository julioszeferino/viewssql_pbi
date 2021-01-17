-- CRIAR TABELA

CREATE TABLE Z_PARAMS (
	Parametro varchar(500),
	Valor varchar(2000),
	DataCriacao varchar(8),
	DataInutilizacao varchar(8)
)

-- INSERIR DADOS NA TABELA

INSERT INTO Z_PARAMS VALUES (
	'Logomarca',
	'https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg',
	'20200329',
	''
)


-- VISUALIZAR TABELA

SELECT * FROM Z_PARAMS
