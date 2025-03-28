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
