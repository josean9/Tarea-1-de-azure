---Quiero obtener informacion del datalake.xlsx

SELECT *
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0;Database=Datalake.xlsx;HDR=YES',
    'SELECT * FROM [Sheet1$]'
);