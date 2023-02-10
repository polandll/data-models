// SOURCE 'comments-table.cql'

// tag::removedata[]
TRUNCATE cycling.comments;
// end::removedata[]

// tag::insert_timeuuid[]
INSERT INTO cycling.comments (
  record_id,
  id,
  created_at
) VALUES (
  now(),
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  '2017-02-14 12:43:20-0800'
);
// end::insert_timeuuid[]

// tag::s_insert_timeuuid[]
SELECT record_id
FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
  AND created_at = '2017-02-14 12:43:20-0800';
// end::s_insert_timeuuid[]

/* START-rinsert_timeuuid
 record_id
--------------------------------------
 e81aee50-4670-11e7-9fd7-81d397057b18

 (1 rows)
END-rinsert_timeuuid */
