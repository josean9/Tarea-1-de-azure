SELECT column_name, data_type
from information_schema.columns
where table_name = '001_sales';
---- ver de que tipo es cada columna
---- al hacer join tienen que coincidir los tipos de datos

SELECT [Id_Producto], 
COUNT([Id_Producto]) as numero_de_productos, 
ROUND(avg([PVP]),2) as precio_medio
FROM [DATAEX].[001_sales]
GROUP BY [Id_Producto]


----Conteo de productos distintivos y no nulos
SELECT [Id_Producto],
COUNT([Id_Producto]) as numero_de_productos,
COUNT(DISTINCT[Id_Producto]) as numero_de_productos_distintos,
ROUND(AVG(CAST([PVP] AS FLOAT)), 2 ) as precio_medio
FROM [DATAEX].[001_sales]
WHERE [Id_Producto] IS NOT NULL
GROUP BY [Id_Producto]



----convertir fecha de formato texto a numero
SELECT 
    Sales_Date,
    CAST(CONVERT(date,Sales_Date,103) AS DATE) as Fecha_Convertida
FROM [DATAEX].[001_sales]

