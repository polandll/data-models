SOURCE '0_create_keyspace.cql';

// tag::dropflog[]
DROP FUNCTION IF EXISTS cycling.fLog;
// end::dropflog[]

// tag::flog[]
CREATE OR REPLACE FUNCTION cycling.fLog (
  input double
) 
  CALLED ON NULL INPUT 
  RETURNS double 
  LANGUAGE java AS 
    $$
      return Double.valueOf(Math.log(input.doubleValue()));
    $$ 
;
// end::flog[]
