SOURCE '0_create_keyspace.cql';

// Composite partition key example without a clustering column

DROP TABLE IF EXISTS cycling.cyclist_id;

// create table without age as clustering column
CREATE TABLE IF NOT EXISTS cycling.cyclist_id (
  lastname text,
  firstname text,
  age int,
  id uuid,
  PRIMARY KEY ((lastname, firstname))
);
    
// insert data    
INSERT INTO cycling.cyclist_id (
  lastname, firstname, age, id
) VALUES (
  'EENKHOORN', 'Pascal', 18, ffdfa2a7-5fc6-49a7-bfdc-3fcdcfdd7156
);

INSERT INTO cycling.cyclist_id (
  lastname, firstname, age, id
) VALUES (
  'WELTEN', 'Bram', 18, 18f471bf-f631-4bc4-a9a2-d6f6cf5ea503
);

INSERT INTO cycling.cyclist_id (
  lastname, firstname, age, id
) VALUES (
  'COSTA', 'Adrien', 17, 15a116fc-b833-4da6-ab9a-4a7775752836
);

// attempt to delete data using IF EXISTS, applied false because Bram Jones does not exist
CAPTURE 'cyclist_id_delete_if_exists.results';
// tag::deleteifexists[]
DELETE id FROM cycling.cyclist_id 
WHERE lastname = 'JONES'
  AND firstname = 'Bram' 
IF EXISTS;
// end::deleteifexists[]
CAPTURE OFF;

// delete data using an IF, age does not match so applied is false
CAPTURE 'cyclist_id_delete_if.results';
// tag::deletedataif[]
DELETE id FROM cycling.cyclist_id 
WHERE lastname = 'WELTEN'
  AND firstname = 'Bram' 
IF age = 20;
// end::deletedataif[]
CAPTURE OFF;
