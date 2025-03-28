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
