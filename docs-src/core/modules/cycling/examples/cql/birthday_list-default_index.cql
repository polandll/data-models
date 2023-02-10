SOURCE 'birthday_list-table.cql';

// For different key-value pairs that you want specify a data types
// tag::index-control-types[]
CREATE SEARCH INDEX IF NOT EXISTS
ON cycling.birthday_list;
// end::index-control-types[]

// Return all fields that were indexed on a key
SELECT *
FROM cycling.birthday_list
WHERE solr_query = 'blist_age:*';

// Regular queries
SELECT *
FROM cycling.birthday_list
WHERE blist_ [ 'blist_age' ] = '23';

SELECT *
FROM cycling.birthday_list
WHERE blist_ [ 'blist_nation' ] = 'GERMANY';

SELECT *
FROM cycling.birthday_list
WHERE blist_ [ 'bday' ] = '27/07/1992'
ALLOW FILTERING;

// Using search index
SELECT *
FROM cycling.birthday_list
WHERE solr_query = 'blist_age:23';

SELECT *
FROM cycling.birthday_list
WHERE solr_query = 'blist_nation:GERMANY';
