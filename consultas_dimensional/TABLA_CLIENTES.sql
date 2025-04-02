--PARA VISUALIZAR LA TABLA DE CLIENTES
SELECT 
    s.CODE,                          -- Código de la venta
    s.Sales_Date,                    -- Fecha de la venta
    s.Customer_ID,                   -- ID del cliente
    cli.CODIGO_POSTAL_LIMPIO,        -- Código postal del cliente
    cli.Edad AS Cliente_Edad,        -- Edad del cliente
    cli.GENERO AS Cliente_Genero,    -- Género del cliente
    cli.Fecha_nacimiento,            -- Fecha de nacimiento del cliente
    cli.RENTA_MEDIA_ESTIMADA,        -- Renta media estimada del cliente
    cli.STATUS_SOCIAL,               -- Status social del cliente
    cli.Poblacion,                   -- Población del cliente
    cli.Provincia,                   -- Provincia del cliente
    cli.A,                           -- Variable A de Mosaic
    cli.B,                           -- Variable B de Mosaic
    cli.C,                           -- Variable C de Mosaic
    cli.D,                           -- Variable D de Mosaic
    cli.E,                           -- Variable E de Mosaic
    cli.F,                           -- Variable F de Mosaic
    cli.G,                           -- Variable G de Mosaic
    cli.H,                           -- Variable H de Mosaic
    cli.I,                           -- Variable I de Mosaic
    cli.J,                           -- Variable J de Mosaic
    cli.K,                           -- Variable K de Mosaic
    cli.U2,                          -- Variable U2 de Mosaic
    cli.Max_Mosaic_G,                -- Max Mosaic G
    cli.Max_Mosaic2,                 -- Max Mosaic 2
    cli.Renta_Media,                 -- Renta media de Mosaic
    cli.F2,                          -- Variable F2 de Mosaic
    cli.Max_Mosaic,                  -- Max Mosaic
    cli.Mosaic_number,               -- Número de Mosaic
    s.Id_Producto,                   -- ID del producto
    s.PVP,                           -- Precio de venta al público
    s.IMPUESTOS,                     -- Impuestos
    s.COSTE_VENTA_NO_IMPUESTOS,      -- Coste de venta sin impuestos
    s.Forma_Pago,                    -- Forma de pago
    s.Motivo_Venta,                  -- Motivo de la venta
    s.TIENDA_ID,                     -- ID de la tienda
    s.Tienda,                        -- Nombre de la tienda
    s.Car_Age,                       -- Edad del coche
    s.QUEJA,                         -- Queja (si existe)
    s.Modelo,                        -- Modelo del producto
    s.DIAS_DESDE_ULTIMA_REVISION,    -- Días desde la última revisión
    s.Fue_Lead,                      -- Indica si fue un lead
    s.Lead_Compra,                   -- Indica si el lead resultó en compra
    s.Lead_Compra_Total,             -- Total de leads que resultaron en compra
    s.KM_Ultima_Revision_Final,      -- KM de la última revisión
    s.Costetransporte,               -- Coste de transporte
    s.GastosMarketing,               -- Gastos de marketing
    s.Margendistribuidor,            -- Margen del distribuidor
    s.Comisión_Marca,                -- Comisión de la marca
    s.Margen_eur_bruto,              -- Margen bruto en euros
    s.Margen_eur,                    -- Margen neto en euros
    CASE 
        WHEN s.DIAS_DESDE_ULTIMA_REVISION IS NULL 
            OR s.DIAS_DESDE_ULTIMA_REVISION > 400 
            THEN 0
        ELSE 1
    END AS churn                     -- Indicador de churn
FROM 
    DATAEX.FACT_SALES s
JOIN 
    DATAEX.DIM_CLIENTE cli ON s.Customer_ID = cli.Customer_ID

--PARA CREAR LA TABLA DE CLIENTES
-- Primero verificamos si la tabla existe y la eliminamos si es necesario
IF OBJECT_ID('TABLA_DE_CLIENTES', 'U') IS NOT NULL
    DROP TABLE TABLA_DE_CLIENTES;

-- Creamos la nueva tabla con los datos seleccionados
SELECT 
    s.CODE,                          -- Código de la venta
    s.Sales_Date,                    -- Fecha de la venta
    s.Customer_ID,                   -- ID del cliente
    cli.CODIGO_POSTAL_LIMPIO,        -- Código postal del cliente
    cli.Edad AS Cliente_Edad,        -- Edad del cliente
    cli.GENERO AS Cliente_Genero,    -- Género del cliente
    cli.Fecha_nacimiento,            -- Fecha de nacimiento del cliente
    cli.RENTA_MEDIA_ESTIMADA,        -- Renta media estimada del cliente
    cli.STATUS_SOCIAL,               -- Status social del cliente
    cli.Poblacion,                   -- Población del cliente
    cli.Provincia,                   -- Provincia del cliente
    cli.A,                           -- Variable A de Mosaic
    cli.B,                           -- Variable B de Mosaic
    cli.C,                           -- Variable C de Mosaic
    cli.D,                           -- Variable D de Mosaic
    cli.E,                           -- Variable E de Mosaic
    cli.F,                           -- Variable F de Mosaic
    cli.G,                           -- Variable G de Mosaic
    cli.H,                           -- Variable H de Mosaic
    cli.I,                           -- Variable I de Mosaic
    cli.J,                           -- Variable J de Mosaic
    cli.K,                           -- Variable K de Mosaic
    cli.U2,                          -- Variable U2 de Mosaic
    cli.Max_Mosaic_G,                -- Max Mosaic G
    cli.Max_Mosaic2,                 -- Max Mosaic 2
    cli.Renta_Media,                 -- Renta media de Mosaic
    cli.F2,                          -- Variable F2 de Mosaic
    cli.Max_Mosaic,                  -- Max Mosaic
    cli.Mosaic_number,               -- Número de Mosaic
    s.Id_Producto,                   -- ID del producto
    s.PVP,                           -- Precio de venta al público
    s.IMPUESTOS,                     -- Impuestos
    s.COSTE_VENTA_NO_IMPUESTOS,      -- Coste de venta sin impuestos
    s.Forma_Pago,                    -- Forma de pago
    s.Motivo_Venta,                  -- Motivo de la venta
    s.TIENDA_ID,                     -- ID de la tienda
    s.Tienda,                        -- Nombre de la tienda
    s.Car_Age,                       -- Edad del coche
    s.QUEJA,                         -- Queja (si existe)
    s.Modelo,                        -- Modelo del producto
    s.DIAS_DESDE_ULTIMA_REVISION,    -- Días desde la última revisión
    s.Fue_Lead,                      -- Indica si fue un lead
    s.Lead_Compra,                   -- Indica si el lead resultó en compra
    s.Lead_Compra_Total,             -- Total de leads que resultaron en compra
    s.KM_Ultima_Revision_Final,      -- KM de la última revisión
    s.Costetransporte,               -- Coste de transporte
    s.GastosMarketing,               -- Gastos de marketing
    s.Margendistribuidor,            -- Margen del distribuidor
    s.Comisión_Marca,                -- Comisión de la marca
    s.Margen_eur_bruto,              -- Margen bruto en euros
    s.Margen_eur,                    -- Margen neto en euros
    CASE 
        WHEN s.DIAS_DESDE_ULTIMA_REVISION IS NULL 
            OR s.DIAS_DESDE_ULTIMA_REVISION > 400 
            THEN 0
        ELSE 1
    END AS churn                     -- Indicador de churn
INTO 
    DATAEX.TABLA_DE_CLIENTES
FROM 
    DATAEX.FACT_SALES s
JOIN 
    DATAEX.DIM_CLIENTE cli ON s.Customer_ID = cli.Customer_ID;


-- Asegurar que la columna 'churn_predicho' existe antes de actualizar
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'FACT_SALES' AND COLUMN_NAME = 'churn_predicho'
)
BEGIN
    ALTER TABLE DATAEX.FACT_SALES ADD churn_predicho FLOAT;
END

-- Actualizar la tabla DATAEX.FACT_SALES calculando el churn predicho
UPDATE fs
SET fs.churn_predicho = (
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'Intercepto') + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_car_age') * fs.Car_Age + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_km_revision') * fs.Km_medio_por_revision + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_revisiones') * fs.Revisiones + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'PVP') * fs.PVP
)
FROM DATAEX.FACT_SALES fs;

-- Asegurar que los valores de churn_predicho estén en el rango [0,1]
UPDATE DATAEX.FACT_SALES
SET churn_predicho = CASE 
    WHEN churn_predicho < 0 THEN 0 
    WHEN churn_predicho > 1 THEN 1 
    ELSE churn_predicho 
END;

-- Consultar FACT_SALES con la nueva columna churn_predicho
SELECT * FROM DATAEX.FACT_SALES;

-- Calcular el CLTV para cada cliente en los primeros 5 años
WITH PromedioMargen AS (
    SELECT AVG(Margen_eur) AS promedio_margen_eur FROM DATAEX.FACT_SALES
),
CLTVCalculado AS (
    SELECT 
        fs.Customer_ID,
        fs.churn_predicho,
        pm.promedio_margen_eur,
        (fs.churn_predicho / POWER(1.07, 1)) * pm.promedio_margen_eur AS cltv_1,
        ((fs.churn_predicho / POWER(1.07, 1)) +
         (fs.churn_predicho / POWER(1.07, 2))) * pm.promedio_margen_eur AS cltv_2,
        ((fs.churn_predicho / POWER(1.07, 1)) +
         (fs.churn_predicho / POWER(1.07, 2)) +
         (fs.churn_predicho / POWER(1.07, 3))) * pm.promedio_margen_eur AS cltv_3,
        ((fs.churn_predicho / POWER(1.07, 1)) +
         (fs.churn_predicho / POWER(1.07, 2)) +
         (fs.churn_predicho / POWER(1.07, 3)) +
         (fs.churn_predicho / POWER(1.07, 4))) * pm.promedio_margen_eur AS cltv_4,
        ((fs.churn_predicho / POWER(1.07, 1)) +
         (fs.churn_predicho / POWER(1.07, 2)) +
         (fs.churn_predicho / POWER(1.07, 3)) +
         (fs.churn_predicho / POWER(1.07, 4)) +
         (fs.churn_predicho / POWER(1.07, 5))) * pm.promedio_margen_eur AS cltv_5
    FROM DATAEX.FACT_SALES fs
    CROSS JOIN PromedioMargen pm
)

SELECT * FROM CLTVCalculado;

-- Visualizar la tabla de clientes con churn y CLTV
SELECT 
    s.CODE, s.Sales_Date, s.Customer_ID, cli.CODIGO_POSTAL_LIMPIO, 
    cli.Edad AS Cliente_Edad, cli.GENERO AS Cliente_Genero, cli.Fecha_nacimiento, 
    cli.RENTA_MEDIA_ESTIMADA, cli.STATUS_SOCIAL, cli.Poblacion, cli.Provincia, 
    cli.A, cli.B, cli.C, cli.D, cli.E, cli.F, cli.G, cli.H, cli.I, cli.J, cli.K, 
    cli.U2, cli.Max_Mosaic_G, cli.Max_Mosaic2, cli.Renta_Media, cli.F2, 
    cli.Max_Mosaic, cli.Mosaic_number, s.Id_Producto, s.PVP, s.IMPUESTOS, 
    s.COSTE_VENTA_NO_IMPUESTOS, s.Forma_Pago, s.Motivo_Venta, s.TIENDA_ID, 
    s.Tienda, s.Car_Age, s.QUEJA, s.Modelo, s.DIAS_DESDE_ULTIMA_REVISION, 
    s.Fue_Lead, s.Lead_Compra, s.Lead_Compra_Total, s.KM_Ultima_Revision_Final, 
    s.Costetransporte, s.GastosMarketing, s.Margendistribuidor, s.Comisión_Marca, 
    s.Margen_eur_bruto, s.Margen_eur, 
    CASE 
        WHEN s.DIAS_DESDE_ULTIMA_REVISION IS NULL OR s.DIAS_DESDE_ULTIMA_REVISION > 400 THEN 0
        ELSE 1
    END AS churn
FROM DATAEX.FACT_SALES s
JOIN DATAEX.DIM_CLIENTE cli ON s.Customer_ID = cli.Customer_ID;
