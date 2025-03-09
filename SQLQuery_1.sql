SELECT * FROM [DATAEX].[001_sales]
SELECT * FROM [DATAEX].[002_date]
SELECT * FROM [DATAEX].[003_clientes]
SELECT * FROM [DATAEX].[004_rev]
SELECT * FROM [usecases].DATAEX.[005_cp]
SELECT * FROM [usecases].DATAEX.[006_producto]
SELECT * FROM [usecases].DATAEX.[007_costes]
SELECT * FROM [usecases].DATAEX.[008_cac]
SELECT * FROM [usecases].DATAEX.[009_motivo_venta]
SELECT * FROM [usecases].DATAEX.[010_forma_pago]
SELECT * FROM [usecases].DATAEX.[011_tienda]
SELECT * FROM [usecases].DATAEX.[014_categoría_producto]
SELECT * FROM [usecases].DATAEX.[017_logist]
SELECT * FROM [usecases].DATAEX.[018_edad]
SELECT * FROM [usecases].DATAEX.[019_Mosaic]
--- quiero ver si en la tabla [usecases].DATAEX.[011_tienda] se repite el campo [TIENDA_ID] para ver si es la pk
SELECT [TIENDA_ID], COUNT(*) FROM [usecases].DATAEX.[001_sales] GROUP BY [TIENDA_ID] HAVING COUNT(*) > 1
---quiero ver cual es la pk de la tabla [usecases].DATAEX.[017_logist]
SELECT [CODE], COUNT(*) FROM [usecases].DATAEX.[017_logist] GROUP BY [CODE] HAVING COUNT(*) > 1
---quiero ver cual es la pk de la tabla [usecases].DATAEX.[004_rev] CODE
SELECT [CODE], COUNT(*) FROM [usecases].DATAEX.[004_rev] GROUP BY [CODE] HAVING COUNT(*) > 1
-- quiero ver si en la tabla [usecases].DATAEX.[003_clientes] se repite el campo [Customer_ID] para ver si es la pk
SELECT [Customer_ID], COUNT(*) FROM [usecases].DATAEX.[003_clientes] GROUP BY [Customer_ID] HAVING COUNT(*) > 1
-- dame el codigo para ver si en la tabla de [usecases].DATAEX.[001_sales] la columna Sales_Date tiene una relacion de varios a 0 con la tabla [usecases].DATAEX.[002_date] con la columna Date
SELECT s.Sales_Date
FROM [usecases].DATAEX.[001_sales] s
LEFT JOIN [usecases].DATAEX.[002_date] d
ON s.Sales_Date = d.Date
WHERE d.Date IS NULL
GROUP BY s.Sales_Date;

SELECT d.CODE
FROM [usecases].DATAEX.[001_sales] d
LEFT JOIN [usecases].DATAEX.[018_edad] e
ON d.CODE = e.CODE
WHERE e.CODE IS NULL
GROUP BY d.CODE;


---verificamos si la pk de la tabla [usecases].DATAEX.[018_edad] es la columna CODE o Car_Age
-- Verifica si la columna CODE tiene valores duplicados
SELECT CODE, COUNT(*)
FROM [usecases].DATAEX.[018_edad]
GROUP BY CODE
HAVING COUNT(*) > 1;

-- Verifica si la columna Car_Age tiene valores duplicados
SELECT Car_Age, COUNT(*)
FROM [usecases].DATAEX.[018_edad]
GROUP BY Car_Age
HAVING COUNT(*) > 1;

---quiero verificar cual es la pk de la tabla [usecases].DATAEX.[010_forma_pago] la columna FORMA_PAGO_ID
SELECT [FORMA_PAGO_ID], COUNT(*) FROM [usecases].DATAEX.[010_forma_pago] GROUP BY [FORMA_PAGO_ID] HAVING COUNT(*) > 1

---quiero ver si la columna Customer_ID de la tabla [usecases].DATAEX.[003_clientes] es una relacion de varios a uno de uno a uno o de cero a varios con la tabla [usecases].DATAEX.[001_sales]
-- Verifica si hay Customer_ID en [001_sales] que no existen en [003_clientes]
SELECT s.Customer_ID
FROM [usecases].DATAEX.[001_sales] s
LEFT JOIN [usecases].DATAEX.[003_clientes] c
ON s.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL
GROUP BY s.Customer_ID;

-- Cuenta cuántas veces aparece cada Customer_ID en [001_sales]
SELECT s.Customer_ID, COUNT(*) AS Sales_Count
FROM [usecases].DATAEX.[001_sales] s
GROUP BY s.Customer_ID
ORDER BY Sales_Count DESC;




-- Verifica si hay Code_ en [001_sales] que no existen en [006_producto]
-- Si esta consulta devuelve resultados, significa que hay códigos en [001_sales] que no existen en [006_producto],
-- indicando una relación de uno a cero.
SELECT s.Code_
FROM [DATAEX].[001_sales] s
LEFT JOIN [usecases].DATAEX.[006_producto] p
ON s.Code_ = p.Code_
WHERE p.Code_ IS NULL
GROUP BY s.Code_;

-- Cuenta cuántas veces aparece cada Code_ en [001_sales]
-- Esta consulta muestra cuántas veces aparece cada Code_ en [001_sales].
-- Si algunos códigos aparecen más de una vez, indica una relación de varios a uno.
SELECT s.Code_, COUNT(*) AS Sales_Count
FROM [DATAEX].[001_sales] s
GROUP BY s.Code_
ORDER BY Sales_Count DESC;



-- Verifica si hay Modelo en [007_costes] que no existen en [001_sales]
-- Si esta consulta devuelve resultados, significa que hay modelos en [007_costes] que no existen en [001_sales],
-- indicando una relación de uno a cero.
SELECT c.Modelo
FROM [usecases].DATAEX.[007_costes] c
LEFT JOIN [DATAEX].[006_producto] s
ON c.Modelo = s.Modelo
WHERE s.Modelo IS NULL
GROUP BY c.Modelo;

-- Cuenta cuántas veces aparece cada Modelo en [001_sales]
-- Esta consulta muestra cuántas veces aparece cada Modelo en [001_sales].
-- Si algunos modelos aparecen más de una vez, indica una relación de varios a uno.
SELECT s.Modelo, COUNT(*) AS Sales_Count
FROM [DATAEX].[006_producto] s
GROUP BY s.Modelo
ORDER BY Sales_Count DESC;



-- Verifica si hay CP en [019_Mosaic] que no existen en [005_cp]
-- Si esta consulta devuelve resultados, significa que hay códigos postales en [019_Mosaic] que no existen en [005_cp],
-- indicando una relación de uno a cero.
SELECT m.CP
FROM [usecases].DATAEX.[019_Mosaic] m
LEFT JOIN [usecases].DATAEX.[005_cp] c
ON m.CP = c.CP
WHERE c.CP IS NULL
GROUP BY m.CP;

-- Cuenta cuántas veces aparece cada CP en [019_Mosaic]
-- Esta consulta muestra cuántas veces aparece cada CP en [019_Mosaic].
-- Si algunos códigos postales aparecen más de una vez, indica una relación de varios a uno.
SELECT m.CP, COUNT(*) AS Count
FROM [usecases].DATAEX.[019_Mosaic] m
GROUP BY m.CP
ORDER BY Count DESC;