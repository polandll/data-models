curl --location \
--request GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?page-size=5' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
