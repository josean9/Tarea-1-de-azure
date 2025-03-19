SELECT 
    s.CODE,                          -- Código de la venta
    s.Sales_Date,                    -- Fecha de la venta
    s.Customer_ID,                   -- ID del cliente
    s.ID_Producto,                   -- ID del producto
    s.PVP,                           -- Precio de venta al público
    s.IMPUESTOS,                     -- Impuestos
    s.COSTE_VENTA_NO_IMPUESTOS,      -- Coste de venta sin impuestos
    fp.FORMA_PAGO AS Forma_Pago,     -- Descripción de la forma de pago
    mv.MOTIVO_VENTA AS Motivo_Venta, -- Descripción del motivo de la venta
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
    DATAEX.[006_producto] p ON s.ID_Producto = p.Id_Producto  -- Join para producto
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
    M.Renta_Media,                -- Renta media del área (de la tabla 019_Mosaic)
    M.Max_Mosaic,                  -- Segmentación socioeconómica (de la tabla 019_Mosaic)
    M.Mosaic_number               -- Número de segmentación (de la tabla 019_Mosaic)
FROM 
    [DATAEX].[003_clientes] C
JOIN 
    [DATAEX].[005_cp] CP 
    ON RIGHT('00000' + CAST(C.CODIGO_POSTAL AS VARCHAR), 5) = CP.codigopostalid
JOIN 
    [DATAEX].[019_Mosaic] M 
    ON CP.codigopostalid = M.CP;


--- Dimension producto DATAEX.DIM_PRODUCTO
SELECT
    p.Id_Producto,         -- ID del producto
    p.Code_,               -- Código del producto
    p.Modelo,              -- Modelo del producto
    p.Kw,                  -- Kilovatios
    p.TIPO_CARROCERIA,     -- Tipo de carrocería
    p.TRANSMISION_ID,      -- Tipo de transmisión
    f.FUEL,                -- Tipo de combustible
    cp.Equipamiento,       -- Equipamiento
    s.PVP,                 -- Precio de venta al público (PVP)
    COUNT(s.ID_Producto) AS Cantidad,  -- Cantidad de productos vendidos
    (s.PVP * COUNT(s.ID_Producto)) AS PVP_Total  -- PVP multiplicado por la cantidad de productos
FROM 
    DATAEX.[006_producto] p
LEFT JOIN 
    DATAEX.[007_costes] c ON p.Modelo = c.Modelo           -- Join para costes
LEFT JOIN 
    DATAEX.[015_fuel] f ON p.Fuel_ID = f.Fuel_ID           -- Join para fuel
LEFT JOIN 
    DATAEX.[014_categoría_producto] cp ON p.CATEGORIA_ID = cp.CATEGORIA_ID  -- Join para equipamiento
LEFT JOIN 
    DATAEX.[001_sales] s ON p.Id_Producto = s.ID_Producto  -- Join para ventas
GROUP BY 
    p.Id_Producto, p.Code_, p.Modelo, p.Kw, p.TIPO_CARROCERIA, p.TRANSMISION_ID, f.FUEL, cp.Equipamiento, s.PVP;
SELECT * FROM [DATAEX].[002_date]


-- Dimension tiempo DATAEX.DIM_TIEMPO
SELECT
    Date,  -- Fecha completa (YYYY-MM-DD)
    Anno,                -- Año
    Mes,                 -- Mes (1-12)
    Mes_Desc,    -- Nombre del mes (Enero, Febrero, etc.)
    Dia,                 -- Día del mes (1-31)
    Diadelasemana,         -- Día de la semana (1=Lunes, 2=Martes, etc.)
    Diadelesemana_desc, -- Nombre del día (Lunes, Martes, etc.)
    week,              -- Semana del año (1-52)
    Festivo,      -- ¿Es festivo? (Sí/No)
    FindeSemana,  -- ¿Es fin de semana? (Sí/No)
    Laboral        -- ¿Es día laboral? (Sí/No)
FROM
    [DATAEX].[002_date];


-- Dimension tienda DATAEX.DIM_LUGAR
SELECT 
    t.TIENDA_ID ,          -- PK de la tienda
    t.TIENDA_DESC ,      -- Descripción de la tienda
    p.PROVINCIA_ID ,    -- FK de la provincia
    p.PROV_DESC ,     -- Descripción de la provincia
    z.ZONA_ID ,              -- FK de la zona
    z.ZONA             -- Descripción de la zona
FROM 
    DATAEX.[011_tienda] t
LEFT JOIN 
    DATAEX.[012_provincia] p ON t.PROVINCIA_ID = p.PROVINCIA_ID  -- Join con provincia
LEFT JOIN 
    DATAEX.[013_zona] z ON t.ZONA_ID = z.ZONA_ID;                -- Join con zona

