-- Primero añadir la columna churn si no existe
IF NOT EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = 'DATAEX' 
    AND TABLE_NAME = 'FACT_SALES' 
    AND COLUMN_NAME = 'churn'
)
BEGIN
    ALTER TABLE DATAEX.FACT_SALES ADD churn INT NULL;
    PRINT 'Columna churn añadida a DATAEX.FACT_SALES';
END
ELSE
BEGIN
    PRINT 'La columna churn ya existe en DATAEX.FACT_SALES';
END
GO

-- Actualizar los valores de churn según la lógica requerida
UPDATE DATAEX.FACT_SALES 
SET churn = CASE 
    WHEN DIAS_DESDE_ULTIMA_REVISION IS NULL THEN 0
    WHEN DIAS_DESDE_ULTIMA_REVISION > 400 THEN 0
    ELSE 1
END;
GO