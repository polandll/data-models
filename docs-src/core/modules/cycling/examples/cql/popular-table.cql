SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.popular;

// tag::create[]
CREATE TABLE IF NOT EXISTS cycling.popular (
  rank int PRIMARY KEY,
  cinfo tuple<text, text, int>
);
// end::create[]

// tag::insert[]
INSERT INTO cycling.popular (
  rank, cinfo
) VALUES (
  1, ('Spain', 'Mikel LANDA', 1137)
);

INSERT INTO cycling.popular (
  rank, cinfo
) VALUES (
  2, ('Netherlands', 'Steven KRUIJSWIJK', 621)
);

INSERT INTO cycling.popular (
  rank, cinfo
) VALUES (
  3, ('USA', 'Matthew BUSCHE', 230)
);

INSERT INTO cycling.popular (
  rank, cinfo
) VALUES (
  4, ('Italy', 'Fabio ARU', 163)
);

INSERT INTO cycling.popular (
  rank, cinfo
) VALUES (
  5, ('Canada', 'Ryder HESJEDAL', 148)
);
// end::insert[]
