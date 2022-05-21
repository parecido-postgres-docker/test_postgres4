

* Diferentes roles

```bash
root@ubuntu-test:~/Juan/1/local_deploy# docker-compose exec postgres psql -U sis_bigdata -a sis_analytics -W
Password:
psql (11.16)
Type "help" for help.

sis_analytics=# SELECT * FROM tipo_acceso;
 id_tipo_acceso | descripcion | nivel  |      fecha_registro       | estado | id_usuario_sis
----------------+-------------+--------+---------------------------+--------+----------------
              1 | VISTA       | R      | 2019-02-20 14:27:22.86045 |      1 |              1
              2 | MÍNIMO      | CR     | 2019-02-20 14:27:22.86045 |      1 |              1
              3 | ESTANDAR    | CRUD   | 2019-02-20 14:27:22.86045 |      1 |              1
              4 | TOTAL       | CRUDWL | 2019-02-20 14:27:22.86045 |      1 |              1
(4 rows)

sis_analytics=# \q
root@ubuntu-test:~/Juan/1/local_deploy#
root@ubuntu-test:~/Juan/1/local_deploy#
root@ubuntu-test:~/Juan/1/local_deploy# docker-compose exec postgres psql -U equintero -a sis_analytics -W
Password:
psql (11.16)
Type "help" for help.

sis_analytics=> SELECT * FROM tipo_acceso;
ERROR:  permission denied for table tipo_acceso
sis_analytics=> \q
root@ubuntu-test:~/Juan/1/local_deploy#
```

## Run

* Crear el build, usando docker-compose, las variables de entorno no están hard-coding entonces se las pasamos como argumentos cuando ejecutamos el commando build

```bash
docker-compose build --build-arg POSTGRES_USER="sis_bigdata" --build-arg POSTGRES_PASSWORD="F4llst4ck2020*" --build-arg DB_NAME="sis_analytics" --build-arg PGPORT="5432" --build-arg USRS="acastro,arruiz,equintero,jtraslavina,nasarmiento,pruebas,sis_analytics" --build-arg PWDS="acastro,arruiz,equintero,jtraslavina,nasarmiento,pruebas,sis_analytics"
```

* Preparar para subir a docker hub

* hacemos un tag para subir

```bash
docker tag local_deploy_postgres:latest sisedgar/midocker:1.1
```

* nos logueamos

```bash
docker login -u sisedgar
```

* subimos la imagen

```bash
docker push sisedgar/midocker:1.1
```

