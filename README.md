## ENLACE AL REPOSITORIO -> https://github.com/josean9/Tarea-1-de-azure.git
# Guía de Implementación del Modelo Predictivo

## 📂 Estructura del Proyecto

## 🔄 Flujo de Trabajo

1. **Preparación de Datos**  
   Ejecutar `Codigo_mover_tablas.py` para:
   - Consolidar las 19 tablas en:
     - 1 tabla de hechos (`FACT_SALES`)
     - 4 dimensiones (`CLIENTE`, `PRODUCTO`, `TIEMPO`, `LUGAR`)
   - Tratamiento automático:
     - Eliminar duplicados
     - Sustituir nulos por la mediana
     - Definir PKs/FKs

2. **Modelado Predictivo**  
   Abrir `regresion.ipynb`:
   - Contiene:
     - Regresión lineal para predecir churn
     - Coeficientes interpretables
     - Gráficas de relaciones clave
   - Salida:
     - R² y MSE del modelo
     - Variables más influyentes

3. **Cálculo CLTV**  
   Ejecutar `final.sql` para obtener:
   - Probabilidad de retención (R) por cliente
   - Valor estimado a 5 años (CLTV)
   - Segmentación automática por valor

4. **Documentación de Soporte**

   📄 `Documentacion_Proyecto.pdf`  
   - Explicación técnica del proceso completo  
   - Diagrama del modelo final  
   - Metodología de cálculo  

   📊 `datalake.xlsx`  
   - Listado completo de tablas originales  
   - Estructura básica:  
     * Nombre de tabla  
     * Campos contenidos  
     * Tipo de datos de cada campo  
   - Relaciones clave entre tablas  

   ▶ *Para consultar*:  
   - Usar el PDF para visión general  
   - El Excel para detalles técnicos de campos


## ⏳ Orden Recomendado
    A[1. Codigo_mover_tablas.py] --> B[2. regresion.ipynb]
    B --> C[3. final.sql]
    C --> D[4. Documentación]