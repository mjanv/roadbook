set dotenv-load

start:
    docker-compose up --detach
    sleep 3
    mix ecto.setup

run:
    mix phx.server

docs:
    mix docs
    firefox doc/index.html

db:
    PGPASSWORD=postgres psql -d roadbook_dev -h localhost -p 5432 -U postgres

stop:
    docker-compose down --volumes

prod:
    fly postgres connect -a roadbook-db -d roadbook