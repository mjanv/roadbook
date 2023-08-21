set dotenv-load

start:
    docker-compose up --detach
    mix ecto.setup

run:
    mix phx.server

db:
    PGPASSWORD=postgres psql -d postgres -h localhost -p 5432 -U postgres

stop:
    docker-compose down --volumes

prod:
    fly postgres connect -a roadbook-db