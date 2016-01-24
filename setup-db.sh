createdb hours
createuser hours_user
psql -d hours -a -f tables.sql
