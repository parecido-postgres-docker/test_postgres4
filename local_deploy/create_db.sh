#!/bin/bash
set -e

POSTGRES="psql --username ${POSTGRES_USER}"

echo "Creating database: ${DB_NAME}"
$POSTGRES << EOSQL
	CREATE DATABASE ${DB_NAME} OWNER ${POSTGRES_USER};
EOSQL

echo "Retrieve users and passwords"
string_usrs="${USRS}"
string_pwds="${PWDS}"

echo "Converting arrays from string with delimiter to arrays"
readarray -d "," -t usrs <<< "$string_usrs"
readarray -d "," -t pwds <<< "$string_pwds"

last=${#usrs[@]}

for (( i=0 ; i<last ; i++ ));
do
export US="${usrs[~i]}"
export PASSWDT="${pwds[~i]}"
echo "----->  $US"
$POSTGRES << EOSQL
    CREATE USER ${US} WITH PASSWORD '${PASSWDT}';
    GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${US};
EOSQL
done

echo "Creating schema..."
psql -d "${DB_NAME}" -a -U"${POSTGRES_USER}" -f /code/bcksis_analytics1.sql


