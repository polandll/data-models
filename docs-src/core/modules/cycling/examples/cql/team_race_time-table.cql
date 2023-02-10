SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.team_race_time;

// tag::create[]
CREATE TABLE cycling.team_race_time (
  id text PRIMARY KEY,
  value_double double,
  value_float float
);
// end::create[]

// tag::insert[]
INSERT INTO cycling.team_race_time (
  id, value_float, value_double
) VALUES (
  'Rabobank-Liv Woman Cycling Team', 2.6034345E+38, 2.6034345E+38
);
// end::insert[]

CAPTURE 'select_all_from_team_race_time.results';
// tag::select[]
SELECT *
FROM cycling.team_race_time;
// end::select[]
CAPTURE OFF;
