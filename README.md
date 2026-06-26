#  Evolución del Infarto Agudo de Miocardio (IAM) en Ecuador (2019-2024)

![Estatus](https://img.shields.io/badge/Status-Completado-success)
![Concurso](https://img.shields.io/badge/Concurso-El_Quantificador-blue)
![Python](https://img.shields.io/badge/Python-3.x-yellow)
![BigQuery](https://img.shields.io/badge/Google-BigQuery-blue)

Un análisis de los Egresos Hospitalarios en Ecuador para entender la evolución, volumen y tasas de mortalidad del principal diagnóstico en cardiología: el Infarto Agudo de Miocardio (CIE-10: I219).

---

## Sobre mi y la Inspiración

Soy **Pablo Japón**, Médico con una Maestría en Gerencia Hospitalaria y apasionado por la Ciencia de Datos. 

La inspiración para este proyecto nace de la necesidad de **unir la práctica clínica con la inteligencia de datos**. En mi experiencia, he notado que las decisiones en salud pública y privada a menudo carecen de visibilidad sobre tendencias macro, por lo tanto a mayoría de las veces los encargados de tomar decisiones en salud no lo hacen objetivamente. Quise aplicar mis conocimientos aprovenchando el conurso de El Quiantificador para responder a una pregunta crítica: *¿Cómo ha evolucionado la atención del Infarto Agudo de Miocardio en nuestro sistema de salud en el último lustro?*, y por úlitmo, pero no menos importante, mostrar mis habilidades y la importancia de la ciencia de datos en el sector de la salud.
## Hallazgos del Análisis

A través de la exploración de más de 5 años de datos del INEC, descubrimos lo siguiente:
1. **Diagnóstico Principal:** El CIE-10 más frecuente de egreso hospitalario en la especialidad de CARDIOLOGÍA es el **I219** (Infarto agudo del miocardio, sin otra especificación).
2. **Volumen en Alza:** Desde 2019 hasta 2024, los casos han aumentado significativamente tanto en el sector público como en el privado.
3. **Dominio Privado:** La inmensa mayoría de la carga de pacientes (volumen de casos) se concentra en el sector privado.
4. **Mejora en Resultados:** A pesar del alarmante aumento en el volumen de casos, **la tasa de mortalidad global ha disminuido** de manera constante desde el 2019, lo que sugiere mejoras en los protocolos de respuesta, tecnología médica o acceso a tratamientos oportunos.
5. **Perfil del Paciente:** La edad mediana de presentación ronda los 66 años, con una estancia hospitalaria promedio de 5 días.

---

## Arquitectura de Datos y Metodología

Para procesar el enorme volumen de datos de los Egresos Hospitalarios del INEC (Ecuador), diseñamos el siguiente pipeline:

1. **Ingesta de Datos:** Las bases de datos en bruto (.csv) fueron descargadas directamente desde la página ofical del INEC - Ecuador y se subieron a **Google BigQuery** para su procesamiento masivo.
2. **Normalización (SQL):** Se creó el script `scripts/normalization.sql` para limpiar inconsistencias, estandarizar la edad a días, unificar la clasificación de sectores (Público/Privado), decodificar variables y extraer el código CIE-10 puro.
3. **Análisis Anual Individual (SQL):** En el archivo `scripts/analisis_individual.sql` se desarrollaron las consultas separadas para cada año. Esto permitió explorar inicialmente las bases de datos de forma independiente y calcular métricas base.
4. **Consolidación de Datos (SQL):** A través del script `scripts/consulta_unificada.sql`, tomamos la lógica del análisis individual y la consolidamos mediante para obtener un solo Dataset maestro continuo (`datos_unificados.csv`), agregando la columna del año.
5. **Visualización (Python):** Con los datos unificados, utilizamos `pandas` y `matplotlib` para generar un **Combo Chart de Eje Dual** que contrasta el volumen de casos apilados por sector contra la línea de tendencia de mortalidad.
---
*Desarrollado para la comunidad de El Quantificador* 
