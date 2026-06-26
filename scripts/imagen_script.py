import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 1. Cargar los datos
# Leer el archivo CSV datos_unificados que se obtuvo al ejecutar el script sql (consulta_unificada)
df = pd.read_csv('data/datos_unificados.csv')

# 2. Preparar los datos para las barras apiladas (Casos por sector), hago una pivot table para tener los años como filas (índice) y los sectores como columnas
casos_por_sector = df.pivot(index='anio', columns='sector_normalizado', values='total_cases')

# 3. Preparar los datos para la línea (Mortalidad General por Año)
# Como la mortalidad del CSV está separada por sector, calculamos la tasa global ponderada por año
df['casos_fallecidos'] = df['total_cases'] * (df['tasa_mortalidad'] / 100)
mortalidad_anual = df.groupby('anio')[['casos_fallecidos', 'total_cases']].sum()
mortalidad_anual['tasa_mortalidad_global'] = (mortalidad_anual['casos_fallecidos'] / mortalidad_anual['total_cases']) * 100

# 4. Creo el objeto fig y el eje principal (ax1) para las barras
fig, ax1 = plt.subplots(figsize=(12, 7))

# Paleta de colores
colores_sectores = {'Privado': '#2C3E50', 'Público': '#3498DB'} 
colores_lista = [colores_sectores.get(x, '#95A5A6') for x in casos_por_sector.columns]

# Dibujo las barras apiladas
casos_por_sector.plot(kind='bar', stacked=True, ax=ax1, color=colores_lista, edgecolor='white')

# Agrego etiquetas de datos a las barras
for p in ax1.patches:
    height = p.get_height()
    if height > 0:
        x_center = p.get_x() + p.get_width() / 2
        y_bottom = p.get_y()
        ax1.annotate(f"{int(height)}",
                     (x_center, y_bottom),
                     xytext=(0, 5),
                     textcoords="offset points",
                     ha='center', va='bottom',
                     color='white', fontweight='bold')

# 5. Configuración del eje principal (Barras / Volumen)
ax1.set_xlabel('Año de Egreso', fontsize=12, fontweight='bold')
ax1.set_ylabel('Volumen Total de Casos', fontsize=12, fontweight='bold')
ax1.tick_params(axis='x', rotation=0) 
ax1.legend(title='Sector', loc='upper left')
ax1.grid(axis='y', linestyle='--', alpha=0.3)

# 6. Creación de el eje secundario para la línea de mortalidad
ax2 = ax1.twinx() 

# Dibujo la línea de tendencia de mortalidad
ax2.plot(
    range(len(mortalidad_anual)), 
    mortalidad_anual['tasa_mortalidad_global'], 
    color='#E74C3C', 
    marker='o',
    linewidth=3, 
    markersize=8, 
    label='Mortalidad Global (%)'
)

# Agregar etiquetas de datos a los puntos de la línea
x_vals = range(len(mortalidad_anual))
y_vals = mortalidad_anual['tasa_mortalidad_global']
for i, y in enumerate(y_vals):
    ax2.annotate(f"{y:.1f}%", 
                 (x_vals[i], y), 
                 textcoords="offset points", 
                 xytext=(0,10), 
                 ha='center', 
                 fontsize=10, 
                 fontweight='bold',
                 color='#E74C3C')

# 7. Configuración del eje secundario (Línea / Tasas)
ax2.set_ylabel('Tasa de Mortalidad (%)', fontsize=12, fontweight='bold', color='#E74C3C')
ax2.tick_params(axis='y', labelcolor='#E74C3C')
ax2.set_ylim(0, mortalidad_anual['tasa_mortalidad_global'].max() * 1.5)

# 8. Títulos y notas
plt.title('Evolución de Egresos Hospitalarios por Infarto Agudo de Miocardio (I219) en Ecuador (2019-2024)\nVolumen vs. Mortalidad', fontsize=16, fontweight='bold', pad=20)

# Extracción de promedios globales demográficos para la nota al pie
edad_promedio_total = df['edad_promedio_anios'].mean()
estancia_promedio_total = df['estancia_promedio'].mean()
nota = f"Nota: La edad promedio del paciente egresado es de {edad_promedio_total:.0f} años, con una estancia hospitalaria de {estancia_promedio_total:.1f} días. Fuente: INEC - Ecuador"

# Añadimos la nota en la parte baja del gráfico
plt.figtext(0.5, 0.01, nota, wrap=True, horizontalalignment='center', fontsize=10, style='italic', color='gray')

# Ajuste del lienzo para que la nota y el título no se corten
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Guardado de imagen en .png
plt.savefig('evolucion_IAM_ecuador.png', dpi=300, bbox_inches='tight')

plt.show()


