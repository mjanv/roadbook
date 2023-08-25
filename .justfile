set dotenv-load

_default:
	@just --list

# Start the development stack (Livebook + Postgres)
start:
    docker-compose up --detach livebook postgres
    sleep 3
    mix ecto.setup

# Stop the development stack
stop:
    docker-compose down --volumes

# Run the application
app:
    mix phx.server

# Run code quality and unit tests
tests:
    @mix quality
    @mix test

# Build documentation & open it in Firefox
docs:
    mix docs
    firefox doc/index.html

# Run the application stack (App + Livebook + Grafana + Postgres + Prometheus)
docker:
    docker build -t roadbook:latest .
    docker-compose up --detach grafana
    TOKEN=$(bash priv/grafana/create_service_account.sh service_account)
    docker-compose up --detach

# Connect to the local PostGres database
db-local:
    @echo '\033[0;32mYour are connected to the LOCAL database\033[0m'
    PGPASSWORD=postgres psql -d roadbook_dev -h localhost -p 5432 -U postgres

# Connect to the PRODUCTION PostGres database
db-prod:
    @echo '\033[0;31mYour are connected to the PRODUCTION database\033[0m'
    fly postgres connect -a roadbook-db -d roadbook