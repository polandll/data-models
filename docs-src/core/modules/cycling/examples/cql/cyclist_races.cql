SOURCE '0_create_keyspace.cql';

// tag::drop[]
DROP TABLE IF EXISTS cycling.cyclist_races;
DROP TYPE IF EXISTS cycling.race;
// end::drop[]

/* Find all races for a particular cyclist
 CREATE TYPE - User-Defined Type, races
 CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY */

// tag::udt[]
CREATE TYPE IF NOT EXISTS cycling.race (
  race_title text,
  race_date timestamp,
  race_time time
);
// end::udt[]

// tag::cyclist_races[]
CREATE TABLE IF NOT EXISTS cycling.cyclist_races (
  id UUID PRIMARY KEY,
  lastname text,
  firstname text,
  races list<FROZEN <race>>
);
// end::cyclist_races[]

// tag::insert_udt[]
INSERT INTO cycling.cyclist_races (
  id,
  races
) VALUES (
   5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
   [ { race_title : 'Rabobank 7-Dorpenomloop Aalburg', race_date : '2015-05-09', race_time : '07:00:00' },
     { race_title : 'Ronde van Gelderland', race_date : '2015-04-19', race_time : '08:00:00' } ]
);
// end::insert_udt[]

// tag::time[]
INSERT INTO cycling.cyclist_races (
  id,
  races
) VALUES (
   5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
   [ { race_time : '07:00:00'},
     { race_time : '08:00:00' } ]
);
// end::time[]

// tag::utime[]
UPDATE cycling.cyclist_races
SET races[1] = { race_time : '06:00:00'}
WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2 ;
// end::utime[]

// tag::other[]
INSERT INTO cycling.cyclist_races (
  id, lastname, firstname, races
) VALUES (
  e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN', 'Anna', [
    {
      race_title : 'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date : '2015-05-01', race_time : '08:00:00'
    },
    {
      race_title : 'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich', race_date : '2015-05-02', race_time : '06:00:00'
    },
    {
      race_title : 'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer', race_date : '2015-05-03', race_time : '06:00:00'
    }
  ]
);
// end::other[]

// tag::sall[]
SELECT *
FROM cycling.cyclist_races;
// end::sall[]

// tag::spart[]
SELECT lastname, races
FROM cycling.cyclist_races
WHERE id = e7cd5752-bc0d-4157-a80f-7523add8dbcd;
// end::spart[]
