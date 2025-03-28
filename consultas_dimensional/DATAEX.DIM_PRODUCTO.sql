
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

