SOURCE '0_create_keyspace.cql';

// tag::droptype[]
DROP TYPE IF EXISTS cycling.basic_info;
// end::droptype[]

// tag::basicinfotype[]
CREATE TYPE IF NOT EXISTS cycling.basic_info ( 
  birthday timestamp, 
  nationality text, 
  height text,
  weight text
);
// end::basicinfotype[]

DESC TYPE cycling.basic_info;
