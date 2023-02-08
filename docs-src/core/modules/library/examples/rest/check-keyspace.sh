curl --location --request GET 'http://{local-url}{local-port}{local-rest-schemas}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{keyspace}"
}'