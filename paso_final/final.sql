-- Asegurarse de que la columna 'churn_predicho' existe antes de intentar actualizar
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'FACT_SALES' AND COLUMN_NAME = 'churn_predicho'
)
BEGIN
    -- Si la columna no existe, la agregamos
    ALTER TABLE DATAEX.FACT_SALES
    ADD churn_predicho FLOAT;
END

-- Ahora, actualizar la tabla DATAEX.FACT_SALES calculando el churn predicho (r)
UPDATE fs
SET fs.churn_predicho = (
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'Intercepto') + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_car_age') * fs.Car_Age + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_km_revision') * fs.Km_medio_por_revision + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'avg_revisiones') * fs.Revisiones + 
    (SELECT Coeficiente FROM dbo.churn_coef WHERE Variable = 'PVP') * fs.PVP
)
FROM DATAEX.FACT_SALES fs;

UPDATE DATAEX.FACT_SALES
SET churn_predicho = 
    CASE 
        WHEN churn_predicho < 0 THEN 0 
        WHEN churn_predicho > 1 THEN 1 
        ELSE churn_predicho 
    END;


-- Consultar la tabla DATAEX.FACT_SALES para ver la nueva columna churn_predicho
SELECT * FROM DATAEX.FACT_SALES;


-- Calcular el promedio de Margen_eur
WITH PromedioMargen AS (
    SELECT 
        AVG(Margen_eur) AS promedio_margen_eur
    FROM 
        DATAEX.FACT_SALES
),
-- Calcular el CLTV basado en la fórmula
CLTVCalculado AS (
    SELECT 
        fs.Customer_ID,
        fs.churn_predicho,
        pm.promedio_margen_eur,
        
        -- Aplicar la fórmula para calcular el CLTV
        pm.promedio_margen_eur * (
            (fs.churn_predicho / POWER((1 + 0.07), 1)) + 
            (fs.churn_predicho / POWER((1 + 0.07), 2)) + 
            (fs.churn_predicho / POWER((1 + 0.07), 3)) + 
            (fs.churn_predicho / POWER((1 + 0.07), 4)) + 
            (fs.churn_predicho / POWER((1 + 0.07), 5))
        ) AS cltv
    FROM 
        DATAEX.FACT_SALES fs
    CROSS JOIN 
        PromedioMargen pm
)

-- Selección final con el CLTV calculado
SELECT 
    Customer_ID,
    churn_predicho,
    cltv
FROM 
    CLTVCalculado;
