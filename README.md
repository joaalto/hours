# A toy project with Elm

A very simple hour entry app written in Elm. The back-end is a PostgreSQL database with a REST API generated with Postgrest.

## Requirements

- [Elm Platform](http://elm-lang.org/install) version 0.16
- [PostgreSQL](http://www.postgresql.org/download/)
- [Postgrest](http://postgrest.com/install/server/)
- [Node.js](https://nodejs.org/en/) (with ES6 support)

## Setting up the database

```bash
./setup-db.sh
```

## Running the app

```bash
./run.sh
```
This will:

- install JS dependencies and Elm dependencies
- start Postgrest
- start an Express server

Go to [http://localhost:4000](http://localhost:4000)
