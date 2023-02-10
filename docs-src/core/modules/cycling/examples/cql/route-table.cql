SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.route;

// tag::create[]
CREATE TABLE IF NOT EXISTS cycling.route (
  race_id int,
  race_name text,
  point_id int,
  lat_long tuple<text, tuple<float, float>>,
  PRIMARY KEY (race_id, point_id)
);
// end::create[]

// tag::insert[]
INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 1, ('Onnens', (46.8444, 6.6667))
);

INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 2, ('Champagne', (46.833, 6.65))
);

INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 3, ('Novalle', (46.833, 6.6))
);

INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 4, ('Vuiteboeuf', (46.8, 6.55))
);

INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 5, ('Baulmes', (46.7833, 6.5333))
);

INSERT INTO cycling.route (
  race_id, race_name, point_id, lat_long
) VALUES (
  500, '47th Tour du Pays de Vaud', 6, ('Les Clées', (46.7222, 6.5222))
);
// end::insert[]

CAPTURE 'select_all_from_route.results';
// tag::select[]
SELECT *
FROM cycling.route;
// end::select[]
CAPTURE OFF;
