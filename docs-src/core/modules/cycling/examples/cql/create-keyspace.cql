// tag::cyclingks[]
CREATE KEYSPACE IF NOT EXISTS cycling
WITH replication = {
  'class' : 'SimpleStrategy',
  'replication_factor' : 1
};
// end::cyclingks[]
