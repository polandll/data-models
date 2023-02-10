SOURCE '0_create_keyspace.cql';

DROP FUNCTION IF EXISTS cycling.left;

// tag::left[]
CREATE OR REPLACE FUNCTION cycling.left (
  column text, num int
) 
  RETURNS NULL ON NULL INPUT 
  RETURNS text 
  LANGUAGE javascript AS 
    $$
      column.substring(0, num)
    $$
;
// end::left[]
