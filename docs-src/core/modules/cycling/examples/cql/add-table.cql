SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling."add";

// tag::create[]
CREATE TABLE cycling."add" (a int PRIMARY KEY);
// end::create[]
