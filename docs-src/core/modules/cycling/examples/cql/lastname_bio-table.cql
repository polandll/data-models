SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.lastname_bio;

// tag::create[]
CREATE TABLE IF NOT EXISTS cycling.lastname_bio (
  lastname varchar PRIMARY KEY,
  bio blob
);
// end::create[]

// tag::insert_initial[]
INSERT INTO cycling.lastname_bio (
  lastname, bio
) VALUES (
  'TSATEVICH', bigintAsBlob(3)
);
// end::insert_initial[]

CAPTURE 'select_initial_from_lastname_bio.results';
// tag::select_initial[]
SELECT *
FROM cycling.lastname_bio;
// end::select_initial[]
CAPTURE OFF;

// tag::alter[]
ALTER TABLE cycling.lastname_bio
ADD id bigint;
// end::alter[]

// tag::insert_additional[]
INSERT INTO cycling.lastname_bio (
  lastname, id
) VALUES (
  'DUVAL', blobAsBigint(0x0000000000000003)
);
// end::insert_additional[]

CAPTURE 'select_all_from_lastname_bio.results';
// tag::select_all[]
SELECT *
FROM cycling.lastname_bio;
// end::select_all[]
CAPTURE OFF;
