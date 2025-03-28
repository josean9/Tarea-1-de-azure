-- Update the DIAS_DESDE_ULTIMA_REVISION column in the FACT_SALES table to NULL where it contains empty strings.
UPDATE DATAEX.FACT_SALES
SET DIAS_DESDE_ULTIMA_REVISION = NULL
WHERE DIAS_DESDE_ULTIMA_REVISION = '';

-- Remove decimal points from the DIAS_DESDE_ULTIMA_REVISION column and cast it to an integer where it contains decimal values.
UPDATE DATAEX.FACT_SALES
SET DIAS_DESDE_ULTIMA_REVISION = CAST(REPLACE(DIAS_DESDE_ULTIMA_REVISION, '.', '') AS INT)
WHERE DIAS_DESDE_ULTIMA_REVISION LIKE '%.%';

-- Change the DIAS_DESDE_ULTIMA_REVISION column in the FACT_SALES table to an integer type and set it to NOT NULL.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN DIAS_DESDE_ULTIMA_REVISION INT;
