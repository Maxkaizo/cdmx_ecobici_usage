import dlt
import pandas as pd
import hashlib
import gcsfs
import os

# --- Parámetros de entorno
filename = os.environ["FILENAME"]
creds_path = os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")
gcs_project = "dataeng-448500"
bucket = "dataeng-448500-ecobici-bucket"

# --- Instanciar cliente GCS
fs = gcsfs.GCSFileSystem(project=gcs_project, token=creds_path)

# --- Leer archivo de viajes
gcs_path_rides = f"{bucket}/raw/{filename}"
print(f">> Leyendo viajes desde: {gcs_path_rides}")
with fs.open(gcs_path_rides, 'rb') as f:
    df_rides = pd.read_csv(f)

df_rides.columns = df_rides.columns.str.strip('"')
df_rides.columns = df_rides.columns.str.replace(" ", "_")

# --- Agregar columnas auxiliares
df_rides["source_file"] = filename
df_rides["ingestion_ts"] = pd.Timestamp.utcnow().isoformat()
df_rides["ride_id"] = df_rides.apply(
    lambda row: hashlib.md5(
        f"{row['Bici']}_{row['Fecha_Retiro']}_{row['Hora_Retiro']}_{row['Fecha_Arribo']}_{row['Hora_Arribo']}".encode("utf-8")
    ).hexdigest(),
    axis=1
)

# --- Definir recurso de viajes
@dlt.resource(
    name="stg_rides",
    write_disposition="merge",
    primary_key="ride_id"
)
def rides():
    yield df_rides

# --- Leer catálogo de estaciones
gcs_path_stations = f"{bucket}/stations/stations.csv"
print(f">> Leyendo estaciones desde: {gcs_path_stations}")
with fs.open(gcs_path_stations, 'rb') as f:
    df_stations = pd.read_csv(f)

df_stations["ingestion_ts"] = pd.Timestamp.utcnow().isoformat()

# --- Definir recurso de estaciones
@dlt.resource(
    name="dim_stations",
    write_disposition="replace"
)
def stations():
    yield df_stations

# --- Crear pipeline
pipeline = dlt.pipeline(
    pipeline_name="ecobici_pipeline",
    destination="bigquery",
    dataset_name="dataeng_448500_ecobici_ds"
)

# --- Ejecutar ambos recursos
load_info = pipeline.run([rides, stations])
print("✅ Carga completada")
print(load_info)
