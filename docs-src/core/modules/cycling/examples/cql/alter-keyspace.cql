// tag::alterks[]
ALTER KEYSPACE cycling
WITH REPLICATION = { 
  'class' : 'NetworkTopologyStrategy',
  'SearchAnalytics' : 1
} 
AND DURABLE_WRITES = false;
// end::alterks[]
