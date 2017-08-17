#!/usr/bin/env sh

dropdb sqlzoo
createdb sqlzoo
# cat data/create_tables.sql | sqlite3 sqlzoo
psql sqlzoo < data/create_tables.sql
