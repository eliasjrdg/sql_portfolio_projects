/*Quais os Top10 produtos mais vendidos(qtd)? (Nome, Categoria, Quantidade e Valor Total)*/
SELECT
	p.nome AS Produto,
	p.categoria AS Categoria,
	v.quantidade AS Quantidade,
	ROUND((Quantidade * p.preco),2) AS Preco
FROM vendas v
JOIN produtos p 
	ON p.cod_prod = v.cod_prod  
GROUP BY Produto
ORDER BY Quantidade DESC
LIMIT 10;


/*Quais os Top10 produtos menos vendidos(qtd)? (Nome, Categoria, Quantidade e Valor Total)*/
SELECT
	p.nome AS Produto,
	p.categoria AS Categoria,
	v.quantidade AS Quantidade,
	ROUND(SUM(Quantidade * p.preco), 2) AS Preco
FROM vendas v
JOIN produtos p 
	ON p.cod_prod = v.cod_prod  
GROUP BY Produto
ORDER BY Quantidade ASC
LIMIT 10;


/*Quais os Top5 produtos que mais geraram receita? (Nome, Categoria e Valor Total)*/
SELECT
	p.nome AS Produto,
	p.categoria AS Categoria,
	ROUND(SUM(v.quantidade * p.preco), 2) AS Valor_Total
FROM vendas v 
JOIN produtos p 
	ON p.cod_prod = v.cod_prod
GROUP BY Produto
ORDER BY Valor_Total DESC
LIMIT 5;


/*Quais os Top5 Produtos com maior Lucro (Valor Total - Valor de custo total)? (Nome, Categoria, Valor Total, Custo Total e Lucro)*/
SELECT
	p.nome AS Produto,
	p.categoria AS Categoria,
	ROUND((SUM(v.quantidade * p.preco)) - (SUM(v.quantidade * p.custo)), 2) AS Valor_Custo
FROM vendas v 
JOIN produtos p 
	ON p.cod_prod = v.cod_prod
GROUP BY Produto
ORDER BY Valor_Custo DESC
LIMIT 5;


/*Qual o lucro de cada cidade? (Cidade, Estado, Numero de vendas e Lucro)*/
SELECT
	c.cidade AS Cidade,
	c.estado AS Estado,
	SUM(t.quantidade) AS Vendas,
	ROUND(SUM(t.lucro_venda), 2) AS Lucro_Total
FROM cidades c
JOIN
	(SELECT
		vn.cod_cidade AS cod_cid,
		vn.quantidade AS quantidade,
		(vn.quantidade * p.preco) - (vn.quantidade * p.custo) AS lucro_venda
	FROM vendas vn
	JOIN produtos p 
		ON vn.cod_prod = p.cod_prod) t 
ON c.cod_reg = t.cod_cid
GROUP BY Cidade
ORDER BY Lucro_Total DESC;


/*Qual a categoria mais vendida(em quantidade) em cada cidade? (Cidade, Estado, Categoria, Numero de vendas e Valor Total)*/
SELECT
	DISTINCT(c.cidade) AS Cidade,
	c.estado AS Estado,
	t.cat AS Categoria,
	MAX(t.qtd) AS Num_Vendas,
	t.valor_venda AS Valor_Total
FROM cidades c
JOIN
	(SELECT
		vn.cod_cidade AS cod_cid,
		p.categoria AS cat,
		SUM(vn.quantidade) AS qtd,
		SUM(vn.quantidade * p.cod_prod) AS valor_venda
	FROM vendas vn
	JOIN produtos p
		ON vn.cod_prod = p.cod_prod
	GROUP BY cod_cid, cat) t 
ON c.cod_reg = t.cod_cid
GROUP BY Cidade;


/*Qual o produto mais vendido de cada vendedor? (Nome vendadedor, produto, categoria, quantiade de vendas)*/
SELECT
	v.vendedor AS Vendedor,
	t.nome AS Produto,
	t.cat AS Categoria,
	MAX(t.qtd) AS Num_Vendas
FROM vendedor v 
JOIN
	(SELECT
		vn.cod_vendedor AS cod_vend,
		p.nome AS nome,
		p.categoria AS cat,
		SUM(vn.quantidade) AS qtd
	FROM vendas vn
	JOIN produtos p
		ON vn.cod_prod = p.cod_prod
	GROUP BY vn.cod_vendedor, p.nome) t
ON v.cod_vendedor = t.cod_vend
GROUP BY Vendedor;


/*Quais os Top5 vendedores que venderam mais produtos? (Nome e Quantidade de vendas)*/
SELECT
	v.vendedor AS Vendedor,
	SUM(vd.quantidade) AS Quantidade
FROM vendedor v
JOIN vendas vd
ON v.cod_vendedor = vd.cod_vendedor
GROUP BY Vendedor
ORDER BY Quantidade DESC
LIMIT 5;


/*Quais os Top5 vendedores que venderam mais $? (Nome, Quantidade de vendas e Valor de vendas)*/
SELECT 
	v.vendedor AS Nome,
	SUM(t.quantidade) AS Quantidade,
	ROUND(SUM(t.valor_total), 2) AS Valor_Total
FROM vendedor v 
JOIN
	(SELECT
		vn.cod_vendedor AS vendedor,
		vn.quantidade AS quantidade,
		vn.quantidade * p.preco AS valor_total
	FROM vendas vn
	JOIN produtos p 
		ON vn.cod_prod = p.cod_prod) t
ON t.vendedor = v.cod_vendedor
GROUP BY Nome
ORDER BY Valor_Total
LIMIT 5;



