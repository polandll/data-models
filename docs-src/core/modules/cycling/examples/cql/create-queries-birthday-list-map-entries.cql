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
