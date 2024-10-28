import pandas as pd
import os

# Cargar datos desde el archivo CSV
file_path = 'C:/Users/Bjsan/Downloads/sales_data.csv'
df = pd.read_csv(file_path, encoding='ISO-8859-1')

# Eliminar filas donde la columna 'state' esté vacía
df_filtered = df.dropna(subset=['STATE'])

# Convertir DataFrame a XML
xml_data = df_filtered.to_xml(root_name='sales_data', row_name='record', index=False)

# Guardar el archivo XML en una carpeta diferente
output_dir = 'C:/Users/Bjsan/OneDrive/Escritorio/4semestre/BDA/BDA/Practica6'
os.makedirs(output_dir, exist_ok=True)
output_path = os.path.join(output_dir, 'sales_data.xml')
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(xml_data)

print(f"Archivo XML guardado en {output_path}")
