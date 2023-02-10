// Used for testing tracing and consistency levels

DROP KEYSPACE IF EXISTS cycling_alt;

// tag::create_keyspace[]
CREATE KEYSPACE IF NOT EXISTS cycling_alt 
WITH replication = {
  'class': 'SimpleStrategy', 
  'replication_factor': 3
};
// end::create_keyspace[]

// tag::create_table[]
USE cycling_alt;
CREATE TABLE IF NOT EXISTS cycling_alt.cyclist_name (
  id int PRIMARY KEY,
  lastname text,
  firstname text
);
INSERT INTO cycling_alt.cyclist_name (
  id, lastname, firstname
) VALUES (
  1, 'HOSKINS', 'Melissa'
);
// end::create_table[]

// tag::tracing_on[]
TRACING ON;
CONSISTENCY;
// end::tracing_on[]

CAPTURE 'select_from_cyclist_name_consistency_default.results';
// tag::consistency_default[]
SELECT *
FROM cycling_alt.cyclist_name 
WHERE id = 1;
// end::consistency_default[]
CAPTURE OFF;

CAPTURE 'select_from_cyclist_name_consistency_quorum.results';
// tag::consistency_quorum[]
CONSISTENCY QUORUM;
SELECT *
FROM cycling_alt.cyclist_name 
WHERE id = 1;
// end::consistency_quorum[]
CAPTURE OFF;

CAPTURE 'select_from_cyclist_name_consistency_all.results';
// tag::consistency_all[]
CONSISTENCY ALL;
SELECT *
FROM cycling_alt.cyclist_name 
WHERE id = 1;
// end::consistency_all[]
CAPTURE OFF;

TRACING OFF;
