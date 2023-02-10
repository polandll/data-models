// Using search index
CAPTURE 'select_23_from_birthday_list.results';
// tag::select_23[]
SELECT *
FROM cycling.birthday_list
WHERE solr_query = 'blist_age:23';
// end::select_23[]
CAPTURE OFF;

CAPTURE 'select_germany_from_birthday_list.results';
// tag::select_germany[]
SELECT *
FROM cycling.birthday_list
WHERE solr_query = 'blist_nation:GERMANY';
// end::select_germany[]
CAPTURE OFF;
