// SOURCE 'comments-table.cql'

// tag::removedata[]
TRUNCATE cycling.comments;
// end::removedata[]

/* CURRENT DATE */

// tag::now_date[]
INSERT INTO cycling.comments (
  id,
  created_at
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  toTimeStamp(toDate(now()))
);
// end::now_date[]

// tag::snow_date[]
SELECT created_at
FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
LIMIT 1;
// end::snow_date[]

/* START-rnow_date
created_at
---------------------------------
2017-06-01 00:00:00.000000+0000

(1 rows)
END-rnow_date */

/* CURRENT TIMESTAMP */

// tag::now_timestamp[]
INSERT INTO cycling.comments (
  id,
  created_at
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  toTimeStamp(now())
);
// end::now_timestamp[]

// tag::snow_timestamp[]
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
LIMIT 1;
// end::snow_timestamp[]

/* START-rnow_timestamp
created_at
---------------------------------
2017-06-01 03:28:41.526000+0000

(1 rows)
END-rnow_timestamp */

/* DATE without time or zone */

// tag::string_date_no_tz[]
INSERT INTO cycling.comments (
  id,
  created_at
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  '2017-04-01'
);
// end::string_date_no_tz[]

// tag::sstring_date_no_tz[]
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
  AND created_at = '2017-04-01';
// end::sstring_date_no_tz[]

/* START-rstring_date_no_tz
created_at
---------------------------------
2017-04-01 00:00:00.000000+0000

(1 rows)
END-rstring_date_no_tz */

/* DATE WITH TIMEZONE */

// tag::string_date_tz[]
INSERT INTO cycling.comments (
  id,
  created_at
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  '2017-04-01+0000'
);
// end::string_date_tz[]

// tag::sstring_date_tz[]
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
  AND created_at = '2017-04-01+0000';
// end::sstring_datetz[]

/* START-rstring_date_tz
created_at
---------------------------------
2017-04-01 00:00:00.000000+0000

(1 rows)
END-rstring-date_tz */

/* FULL TIMESTAMP */

// tag::string_ts[]
INSERT INTO cycling.comments (
  id,
  created_at
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  '2017-04-01T11:21:59.001+0000'
);
// end::string_ts[]

// tag::sstring_ts[]
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
  AND created_at = '2017-04-01T11:21:59.001-0800';
// end::sstring_ts[]

/* START-rstring_ts
created_at
---------------------------------
2017-04-01 11:21:59.001000-0800
END-rstring_ts */
