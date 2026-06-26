--CONSULTA IAM CON MORTALIDAD 2024
WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'I219'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

--CONSULTA IAM CON MORTALIDAD 2023

WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor_2023`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'I219'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

--CONSULTA IAM CON MORTALIDAD 2022
WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor_2022`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'I219'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

--CONSULTA IAM CON MORTALIDAD 2021
WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor_2021`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'Infarto agudo del miocardio, sin otra especificación'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

--CONSULTA IAM CON MORTALIDAD 2020
WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor_2020`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'I219'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

--CONSULTA IAM CON MORTALIDAD 2019
WITH datos AS (
    SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    edad_en_dias,
    dias_estancia,
    con_egrpa,
    PERCENTILE_CONT(edad_en_dias / 365.25, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_anios,
    PERCENTILE_CONT(dias_estancia, 0.5)OVER (PARTITION BY cie10_codigo, cau_cie10, espegre, sector_normalizado) AS median_dias_estancia

    FROM `warehouse.egresosnor_2019`
    WHERE espegre = 'CARDIOLOGIA'
      AND cie10_codigo = 'I219'
)

SELECT
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado,
    ROUND(AVG(edad_en_dias / 365.25),2) AS edad_promedio_anios,
    MAX(median_anios) AS median_anios,
    ROUND(AVG(dias_estancia),2) AS estancia_promedio,
    MAX(median_dias_estancia) AS median_dias_estancia,
    ROUND(AVG(CASE WHEN con_egrpa LIKE 'Fallecido%' THEN 1.0 ELSE 0.0 END)*100,2) AS tasa_mortalidad,
    COUNT(*) AS total_cases
FROM datos
GROUP BY
    cie10_codigo,
    cau_cie10,
    espegre,
    sector_normalizado
ORDER BY total_cases DESC;

