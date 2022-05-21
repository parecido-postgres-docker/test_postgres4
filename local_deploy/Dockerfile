# Partimos de una base oficial de postgres version 11 alpine
FROM postgres:11-alpine

# El directorio de trabajo es desde donde se ejecuta el contenedor al iniciarse
WORKDIR /code/

# Copiamos todos los archivos requeridos, scripts y bd a restaurar dentro del contenedor
COPY ./create_db.sh /docker-entrypoint-initdb.d/
COPY ./files/*   /usr/share/postgresql/13/tsearch_data/
ADD ./database/bcksis_analytics1.sql  /code/bcksis_analytics1.sql
COPY .env /code/

# Indicamos que este contenedor se comunica por el puerto 5432/tcp
EXPOSE 5432

