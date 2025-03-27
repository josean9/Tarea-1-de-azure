WITH Mediana_KM AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY KM_Ultima_Revision) 
        OVER () AS Mediana_KM
    FROM 
        DATAEX.[004_rev]
    WHERE 
        KM_Ultima_Revision IS NOT NULL AND KM_Ultima_Revision > 0
)
SELECT DISTINCT
    s.CODE,                          -- Código de la venta
    s.Sales_Date,                    -- Fecha de la venta
    s.Customer_ID,                   -- ID del cliente
    RIGHT('00000' + CAST(cli.CODIGO_POSTAL AS VARCHAR), 5) AS CODIGO_POSTAL_LIMPIO, -- Código postal corregido
    cli.Edad AS Cliente_Edad,        -- Edad del cliente
    cli.GENERO AS Cliente_Genero,    -- Género del cliente
    cli.Fecha_nacimiento,            -- Fecha de nacimiento del cliente
    cli.RENTA_MEDIA_ESTIMADA,        -- Renta media estimada del cliente
    cli.STATUS_SOCIAL,               -- Status social del cliente
    cp.Poblacion,                    -- Población (de la tabla 005_cp)
    cp.Provincia,                    -- Provincia (de la tabla 005_cp)
    mosaic.A,                        -- Variable A de Mosaic
    mosaic.B,                        -- Variable B de Mosaic
    mosaic.C,                        -- Variable C de Mosaic
    mosaic.D,                        -- Variable D de Mosaic
    mosaic.E,                        -- Variable E de Mosaic
    mosaic.F,                        -- Variable F de Mosaic
    mosaic.G,                        -- Variable G de Mosaic
    mosaic.H,                        -- Variable H de Mosaic
    mosaic.I,                        -- Variable I de Mosaic
    mosaic.J,                        -- Variable J de Mosaic
    mosaic.K,                        -- Variable K de Mosaic
    mosaic.U2,                       -- Variable U2 de Mosaic
    mosaic.Max_Mosaic_G,             -- Max Mosaic G
    mosaic.Max_Mosaic2,              -- Max Mosaic 2
    mosaic.Renta_Media,              -- Renta media de Mosaic
    mosaic.F2,                       -- Variable F2 de Mosaic
    mosaic.Max_Mosaic,               -- Max Mosaic
    mosaic.Mosaic_number,            -- Número de Mosaic
    s.Id_Producto,                   -- ID del producto
    s.PVP,                           -- Precio de venta al público
    s.IMPUESTOS,                     -- Impuestos
    s.COSTE_VENTA_NO_IMPUESTOS,      -- Coste de venta sin impuestos
    fp.FORMA_PAGO AS Forma_Pago,     -- Descripción de la forma de pago
    mv.MOTIVO_VENTA AS Motivo_Venta, -- Descripción del motivo de la venta
    t.TIENDA_ID,                     -- ID de la tienda
    t.TIENDA_DESC AS Tienda,         -- Descripción de la tienda
    e.Car_Age,                       -- Edad del coche (Car Age)
    cac.QUEJA,                       -- Queja (si existe)
    p.Modelo,                        -- Modelo del producto
    R.DIAS_DESDE_ULTIMA_REVISION,    -- Días desde la última revisión
    
    logist.Fue_Lead,                 -- Indica si fue un lead
    logist.Lead_Compra,              -- Indica si el lead resultó en compra
    logist.Fue_Lead + logist.Lead_Compra AS Lead_Compra_Total, -- Total de leads que resultaron en compra

    
    COALESCE(
        CASE 
            WHEN R.KM_Ultima_Revision = 0 THEN (SELECT DISTINCT Mediana_KM FROM Mediana_KM)
            ELSE R.KM_Ultima_Revision
        END, 
        (SELECT DISTINCT Mediana_KM FROM Mediana_KM)
    ) AS KM_Ultima_Revision_Final,   -- KM de la última revisión (con reemplazo de 0 o NULL)
    
    co.Costetransporte,              -- Coste de transporte
    co.GastosMarketing,              -- Gastos de marketing
    co.Margendistribuidor,           -- Margen del distribuidor
    co.Comisión_Marca,               -- Comisión de la marca (si está disponible)

    -- Cálculo del Margen Bruto
    ROUND(s.PVP * (co.Margen) * 0.01 * (1 - s.IMPUESTOS / 100), 2) AS Margen_eur_bruto,
    
    -- Cálculo del Margen Neto
    ROUND(
        s.PVP * (co.Margen) * 0.01 * (1 - s.IMPUESTOS / 100) 
        - s.COSTE_VENTA_NO_IMPUESTOS 
        - (co.Margendistribuidor * 0.01 + co.GastosMarketing * 0.01 - co.Comisión_Marca * 0.01) * s.PVP * (1 - s.IMPUESTOS / 100) 
        - co.Costetransporte, 
        2
    ) AS Margen_eur -- Agregar la columna 'churn' con la lógica correcta
    
    
FROM 
    DATAEX.[001_sales] s
LEFT JOIN 
    [DATAEX].[003_clientes] cli ON s.Customer_ID = cli.Customer_ID  -- Join con clientes
LEFT JOIN 
    [usecases].DATAEX.[005_cp] cp ON cli.CODIGO_POSTAL = cp.CP  -- Join con códigos postales
LEFT JOIN 
    [DATAEX].[019_Mosaic] mosaic ON TRY_CAST(cp.codigopostalid AS INT) = TRY_CAST(mosaic.CP AS INT)  -- Join con Mosaic
LEFT JOIN 
    [DATAEX].[004_rev] R ON s.CODE = R.CODE  -- Join para revisiones
LEFT JOIN 
    DATAEX.[010_forma_pago] fp ON s.FORMA_PAGO_ID = fp.FORMA_PAGO_ID  -- Join para forma de pago
LEFT JOIN 
    DATAEX.[009_motivo_venta] mv ON s.MOTIVO_VENTA_ID = mv.MOTIVO_VENTA_ID  -- Join para motivo de venta
LEFT JOIN 
    DATAEX.[011_tienda] t ON s.TIENDA_ID = t.TIENDA_ID  -- Join para tienda
LEFT JOIN 
    DATAEX.[018_edad] e ON s.CODE = e.CODE  -- Join para Car_Age
LEFT JOIN 
    DATAEX.[008_cac] cac ON s.CODE = cac.CODE  -- Join para quejas
LEFT JOIN 
    DATAEX.[006_producto] p ON s.Id_Producto = p.Id_Producto  -- Join para producto
LEFT JOIN 
    DATAEX.[007_costes] co ON p.Modelo = co.Modelo  -- Join para costes
LEFT JOIN 
    [usecases].DATAEX.[017_logist] logist ON s.CODE = logist.CODE;  -- Join para Fue_Lead y Lead_Compra































