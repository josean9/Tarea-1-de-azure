SELECT * FROM [DATAEX].[FACT_SALES]


SELECT 
    Customer_ID,
    AVG(Margen_eur) AS Margen_Promedio
FROM 
    DATAEX.FACT_SALES
GROUP BY 
    Customer_ID;





WITH Ultima_Compra AS (
    SELECT 
        Customer_ID,
        MAX(TRY_CONVERT(DATE, Sales_Date, 103)) AS Ultima_Fecha_Compra
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
)
SELECT 
    Customer_ID,
    Ultima_Fecha_Compra,
    DATEDIFF(DAY, Ultima_Fecha_Compra, GETDATE()) AS Dias_Desde_Ultima_Compra,
    CASE 
        WHEN DATEDIFF(DAY, Ultima_Fecha_Compra, GETDATE()) <= 800 THEN 1
        ELSE 0
    END AS r
FROM 
    Ultima_Compra;








WITH Margen_Promedio AS (
    SELECT 
        Customer_ID,
        AVG(Margen_eur) AS Margen_Promedio
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Ultima_Compra AS (
    SELECT 
        Customer_ID,
        MAX(TRY_CONVERT(DATE, Sales_Date, 103)) AS Ultima_Fecha_Compra
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Retencion AS (
    SELECT 
        Customer_ID,
        CASE 
            WHEN DATEDIFF(DAY, Ultima_Fecha_Compra, GETDATE()) <= 800 THEN 1  -- Retenido si ha comprado en los últimos 800 días
            ELSE 0  -- No retenido
        END AS r
    FROM 
        Ultima_Compra
)
SELECT 
    m.Customer_ID,
    m.Margen_Promedio,
    r.r,
    CASE 
        WHEN r.r = 1 THEN m.Margen_Promedio * (1 / 0.1)  -- Fórmula del CLTV cuando r = 1
        ELSE 0  -- Si r = 0, el CLTV es 0
    END AS CLTV
FROM 
    Margen_Promedio m
JOIN 
    Retencion r ON m.Customer_ID = r.Customer_ID;