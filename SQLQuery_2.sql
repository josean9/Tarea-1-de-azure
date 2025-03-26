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
        MAX(TRY_CONVERT(DATE, Sales_Date, 103)) AS DIAS_DESDE_ULTIMA_REVISION
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
)
SELECT 
    Customer_ID,
    DIAS_DESDE_ULTIMA_REVISION,
    DATEDIFF(DAY, DIAS_DESDE_ULTIMA_REVISION, GETDATE()) AS DIAS_DESDE_ULTIMA_REVISION,
    CASE 
        WHEN DATEDIFF(DAY, DIAS_DESDE_ULTIMA_REVISION, GETDATE()) <= 800 THEN 1
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
Datos_Revision AS (
    SELECT 
        Customer_ID,
        CASE 
            WHEN MIN(CASE 
                     WHEN DIAS_DESDE_ULTIMA_REVISION = '' THEN NULL
                     WHEN DIAS_DESDE_ULTIMA_REVISION IS NULL THEN NULL
                     ELSE TRY_CAST(DIAS_DESDE_ULTIMA_REVISION AS INT)
                     END) IS NULL THEN 'NO'
            ELSE CAST(MIN(CASE 
                         WHEN DIAS_DESDE_ULTIMA_REVISION = '' THEN NULL
                         WHEN DIAS_DESDE_ULTIMA_REVISION IS NULL THEN NULL
                         ELSE TRY_CAST(DIAS_DESDE_ULTIMA_REVISION AS INT)
                         END) AS VARCHAR(20))
        END AS Dias_Revision_Texto,
        MIN(CASE 
            WHEN DIAS_DESDE_ULTIMA_REVISION = '' THEN NULL
            WHEN DIAS_DESDE_ULTIMA_REVISION IS NULL THEN NULL
            ELSE TRY_CAST(DIAS_DESDE_ULTIMA_REVISION AS INT)
            END) AS Dias_Revision_Numero
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Retencion AS (
    SELECT 
        Customer_ID,
        CASE 
            WHEN Dias_Revision_Texto = 'NO' THEN 0
            WHEN Dias_Revision_Numero IS NULL THEN 0
            WHEN Dias_Revision_Numero > 400 THEN 0
            ELSE 1
        END AS r,
        Dias_Revision_Texto,
        Dias_Revision_Numero
    FROM 
        Datos_Revision
)
SELECT 
    m.Customer_ID,
    m.Margen_Promedio,
    r.Dias_Revision_Texto AS Dias_Ultima_Revision,
    r.r,
    CASE 
        WHEN r.r = 1 THEN ROUND(m.Margen_Promedio * (1/(1 + 0.07)), 2)  -- Fórmula corregida
        ELSE 0
    END AS CLTV
FROM 
    Margen_Promedio m
LEFT JOIN 
    Retencion r ON m.Customer_ID = r.Customer_ID;









    WITH Customer_Data AS (
    SELECT 
        Customer_ID,
        AVG(Margen_eur) AS Margen_Promedio,
        COUNT(*) AS Total_Compras,
        MIN(CASE 
            WHEN DIAS_DESDE_ULTIMA_REVISION = '' THEN NULL
            WHEN DIAS_DESDE_ULTIMA_REVISION IS NULL THEN NULL
            ELSE TRY_CAST(DIAS_DESDE_ULTIMA_REVISION AS INT)
        END) AS Dias_Ultima_Revision
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Customer_Retention AS (
    SELECT
        Customer_ID,
        CASE
            WHEN Dias_Ultima_Revision IS NULL THEN 0
            WHEN Dias_Ultima_Revision > 800 THEN 0.2  -- Tasa de retención baja
            WHEN Dias_Ultima_Revision > 400 THEN 0.5  -- Tasa de retención media
            ELSE 0.8  -- Tasa de retención alta (clientes recientes)
        END AS R_t,
        CASE
            WHEN Dias_Ultima_Revision IS NULL THEN 'NO'
            ELSE CAST(Dias_Ultima_Revision AS VARCHAR(20))
        END AS Dias_Revision_Texto,
        Margen_Promedio,
        Total_Compras
    FROM
        Customer_Data
),
CLTV_Calculation AS (
    SELECT
        Customer_ID,
        Margen_Promedio,
        Dias_Revision_Texto,
        R_t,
        Total_Compras,
        -- Parámetros configurables
        1000 AS Costo_AC,  -- Costo de adquisición del cliente
        0.07 AS i,        -- Tasa de descuento
        5 AS N,           -- Período de proyección (años)
        
        -- Cálculo del CLTV según la fórmula proporcionada
        (
            SELECT SUM(
                (1 * Margen_Promedio * POWER(R_t, t+1)) / POWER(1 + 0.07, t)
            FROM (VALUES (0),(1),(2),(3),(4)) AS Years(t)
        ) - 1000 AS CLTV
    FROM
        Customer_Retention
)
SELECT
    Customer_ID,
    Margen_Promedio,
    Dias_Revision_Texto AS Dias_Ultima_Revision,
    ROUND(R_t, 2) AS Tasa_Retencion,
    Total_Compras,
    ROUND(CLTV, 2) AS CLTV_Calculado
FROM
    CLTV_Calculation
ORDER BY
    CLTV_Calculado DESC;