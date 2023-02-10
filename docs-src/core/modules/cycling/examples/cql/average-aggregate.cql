SOURCE '0_create_keyspace.cql';

// tag::dropagg[]
DROP AGGREGATE IF EXISTS cycling.avgState;
// end::dropagg[]

DROP TABLE IF EXISTS cycling.test_avg;

// tag::state[]
CREATE OR REPLACE FUNCTION cycling.avgState (
  state tuple<int, bigint>,
  val int
) 
  CALLED ON NULL INPUT 
  RETURNS tuple<int, bigint> 
  LANGUAGE java AS 
    $$
      if (val != null) { 
        state.setInt(0, state.getInt(0) + 1); 
        state.setLong(1, state.getLong(1) + val.intValue()); 
      } 
      return state; 
    $$
;
// end::state[]

// tag::test[]
CREATE TABLE IF NOT EXISTS cycling.test_avg (
  id int PRIMARY KEY,
  state frozen<tuple<int, bigint>>,
  val int
);

INSERT INTO cycling.test_avg (
  id, state, val
) VALUES (
  1, (6, 9949), 51
);

INSERT INTO cycling.test_avg (
  id, state, val
) VALUES (
  2, (79, 10000), 9999
);

SELECT state, avgstate(state, val), val
FROM cycling.test_avg;
// end::test[]

// tag::final[]
CREATE OR REPLACE FUNCTION cycling.avgFinal (
  state tuple<int,bigint>
) 
  CALLED ON NULL INPUT 
  RETURNS double 
  LANGUAGE java AS 
    $$
      double r = 0; 
      if (state.getInt(0) == 0) return null; 
      r = state.getLong(1); 
      r /= state.getInt(0); 
      return Double.valueOf(r);
    $$ 
;
// end::final[]

// tag::agg[]
CREATE OR REPLACE AGGREGATE cycling.average (
  int
) 
  SFUNC avgState 
  STYPE tuple<int,bigint> 
  FINALFUNC avgFinal 
  INITCOND (0, 0)
;
// end::agg[]
