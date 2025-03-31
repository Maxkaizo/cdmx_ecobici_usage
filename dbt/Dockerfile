# base image
FROM python:3.10-slim

# avoid buffering
ENV PYTHONUNBUFFERED=1

# install dependencies
RUN pip install --no-cache-dir dbt-bigquery pandas gcsfs

# create working dir
WORKDIR /app

# copy files
COPY . .

