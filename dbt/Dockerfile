# Usa una imagen base de Python
FROM python:3.10-slim

# Evita buffering
ENV PYTHONUNBUFFERED=1

# Instala dependencias necesarias
RUN pip install --no-cache-dir dbt-bigquery pandas gcsfs

# Crea carpeta de trabajo
WORKDIR /app

# Copia todo el proyecto al contenedor
COPY . .

# Por ahora, no definimos CMD porque lo ejecutarás tú manualmente
