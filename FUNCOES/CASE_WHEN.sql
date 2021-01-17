-- CONDICIONAIS
SELECT 
	Colab.EmployeeKey,
	Colab.FirstName,
	Colab.Gender,
	A =
		CASE
			WHEN Colab.Gender = 'M' THEN 'Masculino'
			WHEN Colab.Gender = 'F' THEN 'Feminino'
			ELSE 'Outros' --Se eu deixo sem else, tras nulo se nao encontrar
		END
FROM DimEmployee Colab (nolock)