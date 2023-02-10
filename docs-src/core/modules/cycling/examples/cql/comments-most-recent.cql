// SOURCE 'comments-table.cql';

CAPTURE 'select_mostrecent_from_comments.results';
// tag::select-mostrecent[]
SELECT toDate(created_at) AS Date, comment, commenter
FROM cycling.comments
PER PARTITION LIMIT 1;
// end::select-mostrecent[]
CAPTURE OFF;
