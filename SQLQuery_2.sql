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









    



SELECT 
    COUNT(*) AS Total_Valores_Nulos_O_Vacios
FROM 
    [DATAEX].[FACT_SALES]
WHERE 
    Car_Age IS NULL OR Car_Age = '';



SELECT * FROM [DATAEX].[FACT_SALES]


WITH Margen_Promedio AS (
    -- Calcula el margen promedio por cliente
    SELECT 
        Customer_ID,
        AVG(Margen_eur) AS Margen_Promedio
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Datos_Revision AS (
    -- Calcula los promedios de PVP, Edad del coche y KM de la última revisión por cliente
    SELECT 
        Customer_ID,
        AVG(PVP) AS Avg_PVP,
        AVG(Car_Age) AS Avg_Edad_Coche,
        AVG(KM_Ultima_Revision_Final) AS Avg_KM_Coche
    FROM 
        DATAEX.FACT_SALES
    GROUP BY 
        Customer_ID
),
Regresion AS (
    -- Calcula la regresión logística para obtener r entre 0 y 1
    SELECT 
        Customer_ID,
        1.0 / (1 + EXP(-1 * (0.5 * Avg_PVP + 0.3 * Avg_Edad_Coche - 0.2 * Avg_KM_Coche))) AS r
    FROM 
        Datos_Revision
),
Sumatorio AS (
    -- Calcula el sumatorio de r^n / (1 + 0.07)^n para n de 1 a 5
    SELECT 
        m.Customer_ID,
        SUM(POWER(r.r, n) / POWER(1 + 0.07, n)) AS Factor_Descuento
    FROM 
        Margen_Promedio m
    JOIN 
        Regresion r ON m.Customer_ID = r.Customer_ID
    CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS Numeros
    GROUP BY 
        m.Customer_ID
)
-- Calcula el CLTV final
SELECT 
    m.Customer_ID,
    m.Margen_Promedio,
    r.r AS Retencion,
    ROUND(m.Margen_Promedio * s.Factor_Descuento, 2) AS CLTV
FROM 
    Margen_Promedio m
LEFT JOIN 
    Regresion r ON m.Customer_ID = r.Customer_ID
LEFT JOIN 
    Sumatorio s ON m.Customer_ID = s.Customer_ID;

























WITH Mediana_Car_Age AS (
    -- Calcula la mediana de la columna Car_Age
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TRY_CAST(Car_Age AS FLOAT)) 
        OVER () AS Mediana
    FROM 
        DATAEX.FACT_SALES
    WHERE 
        Car_Age IS NOT NULL AND Car_Age != ''
),
Fact_Sales_Limpio AS (
    -- Reemplaza valores NULL o vacíos en Car_Age con la mediana calculada
    SELECT 
        Customer_ID,
        PVP,
        COALESCE(NULLIF(Car_Age, ''), (SELECT DISTINCT Mediana FROM Mediana_Car_Age)) AS Car_Age,
        KM_Ultima_Revision_Final,
        Margen_eur
    FROM 
        DATAEX.FACT_SALES
),
Margen_Promedio AS (
    -- Calcula el margen promedio por cliente
    SELECT 
        Customer_ID,
        AVG(Margen_eur) AS Margen_Promedio
    FROM 
        Fact_Sales_Limpio
    GROUP BY 
        Customer_ID
),
Datos_Revision AS (
    -- Calcula los promedios de PVP, Edad del coche y KM de la última revisión por cliente
    SELECT 
        Customer_ID,
        AVG(PVP) AS Avg_PVP,
        AVG(Car_Age) AS Avg_Edad_Coche,
        AVG(KM_Ultima_Revision_Final) AS Avg_KM_Coche
    FROM 
        Fact_Sales_Limpio
    GROUP BY 
        Customer_ID
),
Regresion AS (
    -- Calcula la regresión logística para obtener r entre 0 y 1
    SELECT 
        Customer_ID,
        1.0 / (1 + EXP(-1 * (0.5 * Avg_PVP + 0.3 * Avg_Edad_Coche - 0.2 * Avg_KM_Coche))) AS r
    FROM 
        Datos_Revision
),
Sumatorio AS (
    -- Calcula el sumatorio de r^n / (1 + 0.07)^n para n de 1 a 5
    SELECT 
        m.Customer_ID,
        SUM(POWER(r.r, n) / POWER(1 + 0.07, n)) AS Factor_Descuento
    FROM 
        Margen_Promedio m
    JOIN 
        Regresion r ON m.Customer_ID = r.Customer_ID
    CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS Numeros
    GROUP BY 
        m.Customer_ID
)
-- Calcula el CLTV final
SELECT 
    m.Customer_ID,
    m.Margen_Promedio,
    r.r AS Retencion,
    ROUND(m.Margen_Promedio * s.Factor_Descuento, 2) AS CLTV
FROM 
    Margen_Promedio m
LEFT JOIN 
    Regresion r ON m.Customer_ID = r.Customer_ID
LEFT JOIN 
    Sumatorio s ON m.Customer_ID = s.Customer_ID;