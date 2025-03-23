SELECT 
    s.CODE,                          -- Código de la venta
    s.Sales_Date,                    -- Fecha de la venta
    s.Customer_ID,                   -- ID del cliente
    s.Id_Producto,                    -- ID del producto
    s.PVP,                           -- Precio de venta al público
    s.IMPUESTOS,                     -- Impuestos
    s.COSTE_VENTA_NO_IMPUESTOS,      -- Coste de venta sin impuestos
    fp.FORMA_PAGO AS Forma_Pago,     -- Descripción de la forma de pago
    mv.MOTIVO_VENTA AS Motivo_Venta, -- Descripción del motivo de la venta
    t.TIENDA_ID,        -- ID de la tienda
    t.TIENDA_DESC AS Tienda,         -- Descripción de la tienda
    e.Car_Age,                       -- Edad del coche (Car Age)
    c.QUEJA,                         -- Queja (si existe)
    p.Modelo,                        -- Modelo del producto
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
    ) AS Margen_eur

FROM 
    DATAEX.[001_sales] s
LEFT JOIN 
    DATAEX.[010_forma_pago] fp ON s.FORMA_PAGO_ID = fp.FORMA_PAGO_ID  -- Join para forma de pago
LEFT JOIN 
    DATAEX.[009_motivo_venta] mv ON s.MOTIVO_VENTA_ID = mv.MOTIVO_VENTA_ID  -- Join para motivo de venta
LEFT JOIN 
    DATAEX.[011_tienda] t ON s.TIENDA_ID = t.TIENDA_ID  -- Join para tienda
LEFT JOIN 
    DATAEX.[018_edad] e ON s.CODE = e.CODE  -- Join para Car_Age
LEFT JOIN 
    DATAEX.[008_cac] c ON s.CODE = c.CODE  -- Join para quejas
LEFT JOIN 
    DATAEX.[006_producto] p ON s.Id_Producto = p.Id_Producto  -- Join para producto
LEFT JOIN 
    DATAEX.[007_costes] co ON p.Modelo = co.Modelo;  -- Join para costes








-- Dimension cliente DATAEX.DIM_CLIENTE
SELECT 
    C.Customer_ID,                -- ID del cliente
            -- Código postal del cliente (original)
    RIGHT('00000' + CAST(C.CODIGO_POSTAL AS VARCHAR), 5) AS CODIGO_POSTAL_LIMPIO, -- Código postal corregido
    C.Edad,                       -- Edad del cliente
    C.GENERO,                     -- Género del cliente
    C.Fecha_nacimiento,           -- Fecha de nacimiento del cliente
    C.RENTA_MEDIA_ESTIMADA,       -- Renta media estimada del cliente
    C.STATUS_SOCIAL,              -- Status social del cliente
    CP.Poblacion,                 -- Población (de la tabla 005_cp)
    CP.Provincia,                 -- Provincia (de la tabla 005_cp)
    mosaic.A,                             -- Variable A de Mosaic
    mosaic.B,                             -- Variable B de Mosaic
    mosaic.C,                             -- Variable C de Mosaic
    mosaic.D,                             -- Variable D de Mosaic
    mosaic.E,                             -- Variable E de Mosaic
    mosaic.F,                             -- Variable F de Mosaic
    mosaic.G,                             -- Variable G de Mosaic
    mosaic.H,                             -- Variable H de Mosaic
    mosaic.I,                             -- Variable I de Mosaic
    mosaic.J,                             -- Variable J de Mosaic
    mosaic.K,                             -- Variable K de Mosaic
    mosaic.U2,                            -- Variable U2 de Mosaic
    mosaic.Max_Mosaic_G,                  -- Max Mosaic G
    mosaic.Max_Mosaic2,                   -- Max Mosaic 2
    mosaic.Renta_Media,                   -- Renta media de Mosaic
    mosaic.F2,                            -- Variable F2 de Mosaic
    mosaic.Max_Mosaic,                    -- Max Mosaic
    mosaic.Mosaic_number                  -- Número de Mosaic
FROM 
    [DATAEX].[003_clientes] C
LEFT JOIN 
    [usecases].DATAEX.[005_cp] cp ON C.CODIGO_POSTAL = cp.CP 
LEFT JOIN 
    [DATAEX].[019_Mosaic] mosaic 
    ON TRY_CAST(cp.codigopostalid AS INT) = TRY_CAST(mosaic.CP AS INT);  -- Join para Mosaic

--- dame las repeticiones de la columna Id_Producto de la tabla [usecases].DATAEX.[006_producto]
SELECT [Id_Producto], COUNT(*) FROM [usecases].DATAEX.[006_producto] GROUP BY [Id_Producto] HAVING COUNT(*) > 0
--- Dimension producto DATAEX.DIM_PRODUCTO
SELECT
    p.Id_Producto,         -- ID del producto
    p.Code_,               -- Código del producto
    p.Modelo,              -- Modelo del producto
    p.Kw,                  -- Kilovatios
    p.TIPO_CARROCERIA,     -- Tipo de carrocería
    p.TRANSMISION_ID,      -- Tipo de transmisión
    f.FUEL,                -- Tipo de combustible
    cp.Equipamiento       -- Equipamiento
FROM 
    DATAEX.[006_producto] p
LEFT JOIN 
    DATAEX.[007_costes] c ON p.Modelo = c.Modelo           -- Join para costes
LEFT JOIN 
    DATAEX.[015_fuel] f ON p.Fuel_ID = f.Fuel_ID           -- Join para fuel
LEFT JOIN 
    DATAEX.[014_categoría_producto] cp ON p.CATEGORIA_ID = cp.CATEGORIA_ID  -- Join para equipamiento



    -- Dimension tiempo DATAEX.DIM_TIEMPO
    SELECT * FROM [DATAEX].[002_date];



-- Dimension tienda DATAEX.DIM_LUGAR
SELECT 
    t.TIENDA_ID ,          -- PK de la tienda
    t.TIENDA_DESC ,      -- Descripción de la tienda
    p.PROV_DESC ,     -- Descripción de la provincia
    z.ZONA             -- Descripción de la zona
FROM 
    DATAEX.[011_tienda] t
LEFT JOIN 
    DATAEX.[012_provincia] p ON t.PROVINCIA_ID = p.PROVINCIA_ID  -- Join con provincia
LEFT JOIN 
    DATAEX.[013_zona] z ON t.ZONA_ID = z.ZONA_ID;                -- Join con zona