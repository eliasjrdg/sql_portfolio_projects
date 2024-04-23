/*Data Cleansing*/
SELECT DISTINCT "Purchase Address" 
FROM merged_sales_data;

SELECT *, COUNT(*)
FROM merged_sales_data
GROUP BY "Order ID" 
ORDER BY "Order ID" DESC;

DELETE
FROM merged_sales_data
WHERE "Order ID"  = ''
	  OR "Product"  = ''
	  OR "Quantity Ordered"  = ''
	  OR "Price Each" = ''
	  OR "Order Date" = ''
	  OR "Purchase Address" = '';
	  
DELETE
FROM merged_sales_data
WHERE "Order ID" = 'Order ID';

/*---------------------------------------------------------------------*/

/*Qual o valor médio dos pedidos?*/
SELECT
	ROUND(AVG("Quantity Ordered" * "Price Each"), 2) AS "AVG_Price"
FROM merged_sales_data



/*Qual o melhor mês para vendas?*/
SELECT
	SUBSTR("Order Date", 1, 2) AS "Month",
	ROUND(SUM("Quantity Ordered" * "Price Each"), 2) AS "Total"
FROM merged_sales_data
GROUP BY "Month"
ORDER BY "Total" DESC;



/*Quais os top 10 produtos mais vendidos?*/
SELECT "Product",
		SUM("Quantity Ordered") AS "Total_Quantity",
		"Price Each",
		ROUND(SUM("Quantity Ordered" * "Price Each"), 2) AS "Total_Reveneue"
FROM merged_sales_data
GROUP BY "Product"
ORDER BY "Total_Quantity" DESC
LIMIT 10;



/*Qual o melhor horário para as vendas?*/
SELECT
	SUBSTR("Order Date", -5, 2) AS "Hour",
	ROUND(SUM("Quantity Ordered" * "Price Each"), 2) AS "Total"
FROM merged_sales_data
GROUP BY "Hour"
ORDER BY "Total" DESC;



/*Qual o estado trouxe a maior receita?*/
SELECT
	SUBSTRING("Purchase Address" , -8, 2) AS "State",
	ROUND(SUM ("Quantity Ordered" * "Price Each"), 2) AS "Total_Reveneue"
FROM merged_sales_data
GROUP BY "State"
ORDER BY "Total_Reveneue" DESC;



/*Quais cidades possuem o maior número de pedidos?*/
SELECT
	SUBSTRING("Purchase Address" , CHARINDEX(',', "Purchase Address")+2) AS "City",
	COUNT("Order ID") AS "Total_Orders"
FROM merged_sales_data
GROUP BY "City"
ORDER BY "Total_Orders" DESC;


