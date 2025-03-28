SELECT
    fact.PVP,
    AVG(fact.Car_Age) AS avg_car_age,
    AVG(fact.Km_medio_por_revision) AS avg_km_revision,
    AVG(ISNULL(fact.Revisiones, 0)) AS avg_revisiones,

    -- Porcentaje de Churn: Incremento de churn por PVP.
    AVG(CAST(Churn AS FLOAT)) AS churn_percentage

FROM DATAEX.TABLA_DE_CLIENTES fact
GROUP BY fact.PVP;