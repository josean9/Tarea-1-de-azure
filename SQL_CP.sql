--quiero ver si el pk de la tabla [usecases].DATAEX.[005_cp] es la columna CP o codigopostalid
SELECT [CP], COUNT(*) FROM [usecases].DATAEX.[005_cp] GROUP BY [CP] HAVING COUNT(*) > 1
SELECT [codigopostalid], COUNT(*) FROM [usecases].DATAEX.[005_cp] GROUP BY [codigopostalid] HAVING COUNT(*) > 1

-- Verifica si hay CODIGO_POSTAL en [003_clientes] que no existen en [005_CP]
SELECT c.CODIGO_POSTAL
FROM [DATAEX].[003_clientes] c
LEFT JOIN [DATAEX].[005_CP] cp
ON c.CODIGO_POSTAL = cp.CP
GROUP BY c.CODIGO_POSTAL;

-- Cuenta cuántas veces aparece cada CODIGO_POSTAL en [003_clientes]
SELECT c.CODIGO_POSTAL, COUNT(*) AS Count
FROM [DATAEX].[003_clientes] c
GROUP BY c.CODIGO_POSTAL
ORDER BY Count DESC;