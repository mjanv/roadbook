# Create Grafana service account script
#
# Usage:
#
#   bash priv/grafana/create_service_account.sh <name>

ACCOUNT_NAME=$1

echo "Create service account ${ACCOUNT_NAME}."

response=$(curl -X POST --silent \
     -H "Accept: application/json" -H "Content-Type: application/json" \
     -d "{\"name\": \"${ACCOUNT_NAME}\", \"role\": \"Admin\", \"isDisabled\": false}" \
     http://localhost:3000/api/serviceaccounts)

if echo "$response" | grep -q "service account already exists"; then
    echo "Error: Service account with name ${ACCOUNT_NAME} already exists."
    exit 1
fi

ACCOUNT_ID=$(echo "$response" | jq -r '.id')
echo "Service account created with id ${ACCOUNT_ID}."

echo "Create service account token."

response=$(curl -X POST --silent \
     -H "Accept: application/json" -H "Content-Type: application/json" \
     -d "{\"name\": \"${ACCOUNT_NAME}\"}" \
     http://localhost:3000/api/serviceaccounts/${ACCOUNT_ID}/tokens)

ACCOUNT_KEY=$(echo "$response" | jq -r '.key')

echo "Service account token created with value ${ACCOUNT_KEY}."
