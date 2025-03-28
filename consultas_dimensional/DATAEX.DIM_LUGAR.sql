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