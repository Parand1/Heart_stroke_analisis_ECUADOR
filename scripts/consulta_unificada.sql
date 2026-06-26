-- Consulta unificada de Egresos Hospitalarios (Cardiología - IAM) 2019-2024
-- Genera el dataset final consolidado para importar a CSV.

WITH datos_unificados AS (
    -- 2024
    SELECT 2024 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'I219'
    
    UNION ALL
    -- 2023
    SELECT 2023 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor_2023`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'I219'
    
    UNION ALL
    -- 2022
    SELECT 2022 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor_2022`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'I219'
    
    UNION ALL
    -- 2021 (Filtro especial por descripción)
    SELECT 2021 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor_2021`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'Infarto agudo del miocardio, sin otra especificación'
    
    UNION ALL
    -- 2020
    SELECT 2020 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor_2020`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'I219'
    
    UNION ALL
    -- 2019
    SELECT 2019 AS anio, cie10_codigo, espegre, sector_normalizado, edad_en_dias, dias_estancia, con_egrpa
    FROM `airy-runway-450418-q9.warehouse.egresosnor_2019`
    WHERE espegre = 'CARDIOLOGIA' AND cie10_codigo = 'I219'
),
metricas AS (
    SELECT
        anio,
        sector_normalizado,
        edad_en_dias,
        dias_estancia,
        con_egrpa,
        PERCENTILE_CONT(edad_en_dias / 365.25, 0.5) OVER (PARTITION BY anio, sector_normalizado) AS median_anios,
        PERCENTILE_CONT(dias_estancia, 0.5) OVER (PARTITION BY anio, sector_normalizado) AS median_dias_estancia
    FROM datos_unificados
)
SELECT
    anio,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25), 2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia), 2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END) * 100, 2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM metricas
GROUP BY
    anio,
    sector_normalizado
ORDER BY 
    anio ASC, 
    total_cases DESC;
