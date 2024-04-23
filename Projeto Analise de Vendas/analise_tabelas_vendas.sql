/*Cidades*/
SELECT * FROM cidades;
/*1 - Quantas cidades a empresa atende?*/
SELECT COUNT(DISTINCT cidade) AS Cidades
FROM cidades;

/*2 - Quantos estados a empresa atende?*/
SELECT COUNT(DISTINCT estado) AS Estados
FROM cidades;

/*3 - Quantas cidades de cada estado a empresa atende?*/
SELECT
	estado AS Estado,
	COUNT(DISTINCT cidade) AS Cidades
FROM cidades
GROUP BY Estado;


/*-------------------------------------------------------------------*/


/*Produtos*/
SELECT * FROM produtos;
/*3 - Quantos produtos a empresa vende*/
SELECT DISTINCT nome AS Produtos
FROM produtos;

UPDATE produtos
SET nome = TRIM(nome);

SELECT COUNT(DISTINCT nome) AS Produtos
FROM produtos;

/*4 - Quantas categorias de produtos a empresa vende?*/
SELECT COUNT(DISTINCT categoria) AS Categorias
FROM produtos;

SELECT DISTINCT categoria AS Categorias
FROM produtos;

/*5 - Liste todos os fornecedores?*/
SELECT DISTINCT fornecedor AS Fornecedores
FROM produtos;

SELECT COUNT(DISTINCT fornecedor) AS Fornecedores
FROM produtos;

/*6 - Quais os Top10 produtos com maior custo (Nome, Fornecedor e Custo)*/
SELECT
	nome,
	fornecedor,
	CAST(REPLACE(CAST(custo AS VARCHAR), ',' , '.') AS NUMERIC) AS custo
FROM produtos
ORDER BY custo DESC
LIMIT 10;

UPDATE produtos
SET custo = CAST(REPLACE(CAST(custo AS VARCHAR), ',' , '.') AS NUMERIC);

SELECT
	nome,
	fornecedor,
	custo
FROM produtos
ORDER BY custo DESC
LIMIT 10;

/*7 - Quais os Top10 produtos com maior preco (Nome, Categoria, Fornecedor e Preco*/
SELECT
	nome,
	categoria,
	fornecedor,
	CAST(REPLACE(CAST(preco AS VARCHAR), ',' , '.') AS NUMERIC) AS preco
FROM produtos
ORDER BY preco DESC
LIMIT 10;

UPDATE produtos
SET preco = CAST(REPLACE(CAST(preco AS VARCHAR), ',' , '.') AS NUMERIC);

SELECT
	nome,
	fornecedor,
	preco
FROM produtos
ORDER BY preco DESC
LIMIT 10;

/*8 - Quantos produtos cada fornecedor fornece?*/
SELECT
	DISTINCT fornecedor AS Fornecedores,
	COUNT(DISTINCT nome) AS Produtos
FROM produtos
GROUP BY Fornecedores
ORDER BY Produtos DESC;


/*-------------------------------------------------------------------*/


/*Vendedor*/
SELECT * FROM vendedor
/*9 - Quantos vendedores a empresa tem?*/
SELECT COUNT(DISTINCT vendedor) AS Vendedores
FROM vendedor;

/*10 - Qual a média salarial dos vendedores?*/
SELECT ROUND(AVG(salario), 2) AS Media_Salarial
FROM vendedor;

/*11 - Quantos vendedores recebem os mesmos salarios?*/
SELECT
	salario AS Salario,
	COUNT(DISTINCT vendedor) AS Vendedores
FROM vendedor
GROUP BY Salario;
	
	
	
	
	
	