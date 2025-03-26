import requests
import csv

url = 'https://gbfs.mex.lyftbikes.com/gbfs/en/station_information.json'

response = requests.get(url)
data = response.json()

stations = data['data']['stations']

campos = ['station_id', 'name', 'short_name', 'lat', 'lon', 'capacity', 'is_charging', 'has_kiosk']

with open('stations.csv', 'w', newline='', encoding='utf-8') as archivo_csv:
    writer = csv.DictWriter(archivo_csv, fieldnames=campos)
    writer.writeheader()
    for estacion in stations:
        # Solo incluir los campos seleccionados
        fila = {k: estacion.get(k, '') for k in campos}
        writer.writerow(fila)

print("File created")
