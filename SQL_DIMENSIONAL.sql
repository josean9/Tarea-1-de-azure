-- Seleccionar las columnas especificadas de la tabla [001_sales]
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