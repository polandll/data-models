SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.sample_times;

// tag::create_table[]
CREATE TABLE IF NOT EXISTS cycling.sample_times (
  a int,
  b timestamp,
  c timeuuid,
  d bigint,
  PRIMARY KEY (a)
);
// end::create_table[]

// tag::insert[]
INSERT INTO cycling.sample_times (
  a, b, c, d
) VALUES (
  1, toUnixTimestamp(now()), now(), toTimestamp(now())
);

INSERT INTO cycling.sample_times (
  a, b, c, d
) VALUES (
  2, toUnixTimestamp(now()), maxTimeuuid('2013-01-02 00:01+0000'), toTimestamp(now())
);

INSERT INTO cycling.sample_times (
  a, b, c, d
) VALUES (
  3, toUnixTimestamp(now()), maxTimeuuid('2013-01-03 00:03+0000'), toTimestamp(now())
);

INSERT INTO cycling.sample_times (
  a, b, c, d
) VALUES (
  4, toUnixTimestamp(now()), maxTimeuuid('2013-01-04 00:05+0000'), toTimestamp(now())
);
// end::insert[]

CAPTURE 'select_from_sample_times.results';
// tag::select[]
SELECT a, b, toDate(c), toDate(d)
FROM cycling.sample_times
WHERE c > maxTimeuuid('2013-01-01 00:01+0000')
  AND c < minTimeuuid('2013-01-02 10:00+0000')
ALLOW FILTERING;
// end::select[]
CAPTURE OFF;
