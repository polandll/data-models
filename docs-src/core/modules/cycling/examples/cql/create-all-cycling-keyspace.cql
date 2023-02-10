// tag::single[]
CREATE KEYSPACE cycling
WITH REPLICATION = { 
  'class' : 'SimpleStrategy', 
  'replication_factor' : 1 
};
// end::single[]

// tag::drop[]
DROP KEYSPACE cycling;
// end::drop[]

// tag::network[]
CREATE KEYSPACE cycling 
WITH REPLICATION = { 
  'class' : 'NetworkTopologyStrategy', 
  'datacenter1' : 1
};
// end::network[]

DROP KEYSPACE cycling;

// tag::multi[]
CREATE KEYSPACE "Cycling"
WITH REPLICATION = {
  'class' : 'NetworkTopologyStrategy', 
  'boston'  : 3 , // Datacenter 1 
  'seattle' : 2 , // Datacenter 2
  'tokyo'   : 2   // Datacenter 3
};
// end::multi[]

DROP KEYSPACE cycling;

// tag::durable[]
CREATE KEYSPACE cycling
WITH REPLICATION = { 
  'class' : 'NetworkTopologyStrategy',
  'datacenter1' : 3 
} 
AND DURABLE_WRITES = false;
// end::durable[]
