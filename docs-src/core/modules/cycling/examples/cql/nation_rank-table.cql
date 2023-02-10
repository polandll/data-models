SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.nation_rank;
DROP INDEX IF EXISTS cycling.nation_rank;

// tag::create[]
CREATE TABLE IF NOT EXISTS cycling.nation_rank (
  nation text PRIMARY KEY,
  info tuple<int, text, int>
);
// end::create[]

// tag::index[]
CREATE INDEX IF NOT EXISTS ON
cycling.nation_rank (info);
// end::index[]

// tag::insert[]
INSERT INTO cycling.nation_rank (
  nation, info
) VALUES (
  'Spain', (1, 'Alejandro VALVERDE', 9054)
);

INSERT INTO cycling.nation_rank (
  nation, info
) VALUES (
  'France', (2, 'Sylvain CHAVANEL', 6339)
);

INSERT INTO cycling.nation_rank (
  nation, info
) VALUES (
  'Belgium', (3, 'Phillippe GILBERT', 6222)
);

INSERT INTO cycling.nation_rank (
  nation, info
) VALUES (
  'Italy', (4, 'Davide REBELLINI', 6090)
);
// end::insert[]

CAPTURE 'select_all_from_nation_rank.results';
// tag::select[]
SELECT *
FROM cycling.nation_rank;
// end::select[]
CAPTURE OFF;

CAPTURE 'select_from_nation_rank_filter.results';
// tag::select_filter[]
SELECT *
FROM cycling.nation_rank
WHERE info = (3, 'Phillippe GILBERT', 6222);
// end::select_filter[]
CAPTURE OFF;
