-- Set the TIENDA_ID column in the DIM_LUGAR table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_LUGAR
ALTER COLUMN TIENDA_ID int NOT NULL;

-- Set the Id_Producto column in the DIM_PRODUCTO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_PRODUCTO
ALTER COLUMN Id_Producto nvarchar(255) NOT NULL;

-- Set the CODE column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN CODE nvarchar(255) NOT NULL;

-- Set the Sales_Date column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Sales_Date nvarchar(255) NOT NULL;

-- Set the Customer_ID column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Customer_ID int NOT NULL;

-- Set the Id_Producto column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Id_Producto nvarchar(255) NOT NULL;

-- Set the PVP column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN PVP int NOT NULL;

-- Set the IMPUESTOS column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN IMPUESTOS int NOT NULL;

-- Set the COSTE_VENTA_NO_IMPUESTOS column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN COSTE_VENTA_NO_IMPUESTOS int NOT NULL;

-- Set the Forma_Pago column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Forma_Pago nvarchar(255) NOT NULL;

-- Set the Motivo_Venta column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Motivo_Venta nvarchar(255) NOT NULL;

-- Set the TIENDA_ID column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN TIENDA_ID int NOT NULL;

-- Set the Tienda column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Tienda nvarchar(255) NOT NULL;

-- Set the Modelo column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Modelo nvarchar(255) NOT NULL;

-- Set the Costetransporte column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Costetransporte float NOT NULL;

-- Set the GastosMarketing column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN GastosMarketing float NOT NULL;

-- Set the Margendistribuidor column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Margendistribuidor float NOT NULL;

-- Set the Comisión_Marca column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Comisión_Marca float NOT NULL;

-- Set the Margen_eur_bruto column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Margen_eur_bruto float NOT NULL;

-- Set the Margen_eur column in the FACT_SALES table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.FACT_SALES
ALTER COLUMN Margen_eur float NOT NULL;

-- Ensure no null values exist in any column of the DIM_TIEMPO table.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Date nvarchar(255) NOT NULL;

-- Set the Dia column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Dia int NOT NULL;

-- Set the Mes column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Mes int NOT NULL;

-- Set the Anno column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Anno int NOT NULL;

-- Set the Week column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Week int NOT NULL;

-- Set the InicioMes column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN InicioMes nvarchar(255) NOT NULL;

-- Set the Diadelasemana column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Diadelasemana int NOT NULL;

-- Set the Annomes column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Annomes int NOT NULL;

-- Set the FinMes column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN FinMes nvarchar(255) NOT NULL;

-- Set the Findesemana column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Findesemana nvarchar(255) NOT NULL;

-- Set the Festivo column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Festivo nvarchar(255) NOT NULL;

-- Set the Laboral column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Laboral nvarchar(255) NOT NULL;

-- Set the Diadelesemana_desc column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Diadelesemana_desc nvarchar(255) NOT NULL;

-- Set the Mes_desc column in the DIM_TIEMPO table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_TIEMPO
ALTER COLUMN Mes_desc nvarchar(255) NOT NULL;

-- Set the Customer_ID column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Customer_ID int NOT NULL;

-- Set the CODIGO_POSTAL_LIMPIO column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN CODIGO_POSTAL_LIMPIO nvarchar(255) NOT NULL;

-- Set the Edad column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Edad int NOT NULL;

-- Set the GENERO column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN GENERO nvarchar(255) NOT NULL;

-- Set the Fecha_nacimiento column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Fecha_nacimiento nvarchar(255) NOT NULL;

-- Set the RENTA_MEDIA_ESTIMADA column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN RENTA_MEDIA_ESTIMADA int NOT NULL;

-- Set the STATUS_SOCIAL column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN STATUS_SOCIAL nvarchar(255) NOT NULL;

-- Set the Poblacion column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Poblacion nvarchar(255) NOT NULL;

-- Set the Provincia column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Provincia nvarchar(255) NOT NULL;

-- Set the A column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN A float NOT NULL;

-- Set the B column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN B float NOT NULL;

-- Set the C column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN C float NOT NULL;

-- Set the D column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN D float NOT NULL;

-- Set the E column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN E float NOT NULL;

-- Set the F column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN F float NOT NULL;

-- Set the G column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN G float NOT NULL;

-- Set the H column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN H float NOT NULL;

-- Set the I column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN I float NOT NULL;

-- Set the J column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN J float NOT NULL;

-- Set the K column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN K float NOT NULL;

-- Set the U2 column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN U2 float NOT NULL;

-- Set the Max_Mosaic_G column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Max_Mosaic_G nvarchar(255) NOT NULL;

-- Set the Max_Mosaic2 column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Max_Mosaic2 float NOT NULL;

-- Set the Renta_Media column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Renta_Media float NOT NULL;

-- Set the F2 column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN F2 float NOT NULL;

-- Set the Max_Mosaic column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Max_Mosaic nvarchar(255) NOT NULL;

-- Set the Mosaic_number column in the DIM_CLIENTE table to NOT NULL, meaning it cannot contain null values.
ALTER TABLE DATAEX.DIM_CLIENTE
ALTER COLUMN Mosaic_number float NOT NULL;










