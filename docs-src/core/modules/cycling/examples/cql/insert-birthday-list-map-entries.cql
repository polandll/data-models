// tag::insertentries[]
INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Allan DAVIS', { 'age':'35', 'bday':'27/07/1980', 'nation':'AUSTRALIA' }
);

INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Claudio VANDELLI', { 'age':'54', 'bday':'27/07/1961', 'nation':'ITALY' }
);

INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Laurence BOURQUE', { 'age':'23', 'bday':'27/07/1992', 'nation':'CANADA' }
);

INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Claudio HEINEN', { 'age':'23', 'bday':'27/07/1992', 'nation':'GERMANY' }
);

INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Luc HAGENAARS', { 'age':'28', 'bday':'27/07/1987', 'nation':'NETHERLANDS' }
);

INSERT INTO cycling.birthday_list (
  cyclist_name, blist
) VALUES (
  'Toine POELS', { 'age':'52', 'bday':'27/07/1963', 'nation':'NETHERLANDS' }
);
// end::insertentries[]

// Query entries - find cyclist same age
CAPTURE 'select_from_birthday_list_where_age_23.results';
// tag::ageentryquery[]
SELECT *
FROM cycling.birthday_list
WHERE blist[ 'age' ] = '23';
// end::ageentryquery[]
CAPTURE OFF;

// Query entries - find cyclist same nation map entry
CAPTURE 'select_from_birthday_list_where_nation_netherlands.results';
// tag::nationentryquery[]
SELECT *
FROM cycling.birthday_list
WHERE blist[ 'nation' ] = 'NETHERLANDS';
// end::nationentryquery[]
CAPTURE OFF;

// Query entries - find cyclist same nation with map VALUES CONTAINS
CAPTURE 'select_from_birthday_list_where_nation_netherlands_2.results';
// tag::nationvaluesquery[]
SELECT *
FROM cycling.birthday_list
WHERE blist CONTAINS 'NETHERLANDS';
// end::nationvaluesquery[]
CAPTURE OFF;

// tag::dropentriesindex[]
DROP INDEX IF EXISTS cycling.blist_idx;
// end::dropentriesindex[]
