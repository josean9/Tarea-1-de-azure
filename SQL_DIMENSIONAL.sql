-- Seleccionar las columnas especificadas de la tabla [001_sales] DATAEX.FACT_SALES
SELECT 
    CODE,                -- Código de la venta
    Sales_Date,          -- Fecha de la venta
    Customer_ID,         -- ID del cliente
    ID_Producto,         -- ID del producto
    PVP,                 -- Precio de venta al público
    FORMA_PAGO_ID,       -- ID de la forma de pago
    MOTIVO_VENTA_ID,     -- ID del motivo de la venta
    TIENDA_ID,           -- ID de la tienda
    code_                -- Código adicional
FROM [DATAEX].[001_sales];

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
    M.Max_Mosaic                  -- Segmentación socioeconómica (de la tabla 019_Mosaic)
FROM 
    [DATAEX].[003_clientes] C
JOIN 
    [DATAEX].[005_cp] CP 
    ON RIGHT('00000' + CAST(C.CODIGO_POSTAL AS VARCHAR), 5) = CP.codigopostalid
JOIN 
    [DATAEX].[019_Mosaic] M 
    ON CP.codigopostalid = M.CP;





CREATE TABLE DATAEX.FACT_SALES (
    CODE INT PRIMARY KEY,                -- Clave primaria
    Sales_Date DATE,                      -- Fecha de venta
    Customer_ID INT,                      -- ID del cliente
    ID_Producto INT,                      -- ID del producto
    PVP DECIMAL(10,2),                    -- Precio de venta
    FORMA_PAGO_ID INT,                    -- ID de forma de pago
    MOTIVO_VENTA_ID INT,                   -- ID de motivo de venta
    TIENDA_ID INT,                         -- ID de la tienda
    code_ NVARCHAR(50)                     -- Código adicional
);




-- Dimension tiempo 
SELECT
    Date DATE PRIMARY KEY,  -- Fecha completa (YYYY-MM-DD)
    Anno INT,                -- Año
    Mes INT,                 -- Mes (1-12)
    Mes_Desc VARCHAR(20),    -- Nombre del mes (Enero, Febrero, etc.)
    Dia INT,                 -- Día del mes (1-31)
    Dia_Semana INT,         -- Día de la semana (1=Lunes, 2=Martes, etc.)
    Dia_Semana_Desc VARCHAR(20), -- Nombre del día (Lunes, Martes, etc.)
    Semana INT,              -- Semana del año (1-52)
    Festivo VARCHAR(3),      -- ¿Es festivo? (Sí/No)
    FindeSemana VARCHAR(3),  -- ¿Es fin de semana? (Sí/No)
    Laboral VARCHAR(3)       -- ¿Es día laboral? (Sí/No)
FROM
    [DATAEX].[002_date];



