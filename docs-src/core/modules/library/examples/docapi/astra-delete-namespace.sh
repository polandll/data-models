curl --location --request DEL 'https://{{ASTRA_DB_ID}}-{{ASTRA_DB_REGION}}.apps.astra.datastax.com{base_doc_schema}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{namespace}"
}'
