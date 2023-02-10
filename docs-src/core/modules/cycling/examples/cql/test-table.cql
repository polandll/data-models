SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.test;

// tag::create[]
CREATE TABLE cycling.test (
  Foo int PRIMARY KEY,
  "Bar" int
);
// end::create[]
