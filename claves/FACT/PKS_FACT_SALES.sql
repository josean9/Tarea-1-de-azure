---Ponemos para que date sea la pk de la tabla dim tiempo
ALTER TABLE DATAEX.DIM_TIEMPO
ADD CONSTRAINT PK_DIM_TIEMPO PRIMARY KEY (Date);

---Ponemos para que date sea la pk de la tabla dim tiempo
ALTER TABLE DATAEX.DIM_PRODUCTO
ADD CONSTRAINT PK_DIM_PRODUCTO PRIMARY KEY (Id_Producto);

---Ponemos para que date sea la pk de la tabla dim tiempo
ALTER TABLE DATAEX.DIM_LUGAR
ADD CONSTRAINT PK_DIM_LUGAR PRIMARY KEY (TIENDA_ID);

-- Establecer Customer_ID como clave foránea que referencia DIM_CLIENTE
ALTER TABLE DATAEX.DIM_CLIENTE
ADD CONSTRAINT PK_Customer_ID PRIMARY KEY (Customer_ID)

-- Establecer CODE como clave primaria
ALTER TABLE DATAEX.FACT_SALES
ADD CONSTRAINT PK_DATAEXFACT_SALES PRIMARY KEY (CODE);

-- Establecer Customer_ID como clave foránea que referencia DIM_CLIENTE
ALTER TABLE DATAEX.FACT_SALES
ADD CONSTRAINT FK_Customer_ID
FOREIGN KEY (Customer_ID) REFERENCES DATAEX.DIM_CLIENTE(Customer_ID);

-- Establecer Id_Producto como clave foránea que referencia DIM_PRODUCTO
ALTER TABLE DATAEX.FACT_SALES
ADD CONSTRAINT FK_Id_Producto
FOREIGN KEY (Id_Producto) REFERENCES DATAEX.DIM_PRODUCTO(Id_Producto);

-- Establecer Sales_Date como clave foránea que referencia DIM_TIEMPO
ALTER TABLE DATAEX.FACT_SALES
ADD CONSTRAINT FK_DATE
FOREIGN KEY (Sales_Date) REFERENCES DATAEX.DIM_TIEMPO(Date);

-- Establecer TIENDA_ID como clave foránea que referencia DIM_LUGAR
ALTER TABLE DATAEX.FACT_SALES
ADD CONSTRAINT FK_TIENDA_ID
FOREIGN KEY (TIENDA_ID) REFERENCES DATAEX.DIM_LUGAR(TIENDA_ID);