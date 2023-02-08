curl --location --request GET 'https://{{ASTRA_DB_ID}}-{{ASTRA_DB_REGION}}.apps.astra.datastax.com:8180/v2/schemas/namespaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{keyspace}"
}'