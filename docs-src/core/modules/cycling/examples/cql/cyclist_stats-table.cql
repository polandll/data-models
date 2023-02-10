// tag::droptable[]
DROP TABLE IF EXISTS cycling.cyclist_stats;
// end::droptable[]

SOURCE 'basic_info-type.cql';

// tag::createtable[]
CREATE TABLE IF NOT EXISTS cycling.cyclist_stats ( 
  id UUID PRIMARY KEY,
  lastname text,
  basics basic_info
);
// end::createtable[]

// tag::insert_FRAME[]
INSERT INTO cycling.cyclist_stats (
  id,
  lastname,
  basics
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  'FRAME',
  { birthday:'1993-06-18', nationality:'New Zealand', weight:null, height:null }
);
// end::insert_FRAME[]

INSERT INTO cycling.cyclist_stats (
  id,
  lastname,
  basics
) VALUES (
  6cbc55e9-1943-47dc-91f2-f8f9e95992eb,
  'VIGANO',
  { birthday:'1984-06-12', nationality:'Italy', weight:'67 kg', height:'1.82 m' }
);

// tag::insert_TIRALONGO[]
INSERT INTO cycling.cyclist_stats (
  id, lastname,
  basics
) VALUES (
  220844bf-4860-49d6-9a4b-6b5d3a79cbfb,
  'TIRALONGO',
  { birthday:'1977-07-08', nationality:'Italy', weight:'63 kg', height:'1.78 m' }
);
// end::insert_TIRALONGO[]

// tag::update[]
UPDATE cycling.cyclist_stats 
SET basics.birthday = '2000-12-12' 
WHERE id = 220844bf-4860-49d6-9a4b-6b5d3a79cbfb;
// end::update[]

CAPTURE 'select_from_cyclist_stats.results';
// tag::select[]
SELECT *
FROM cycling.cyclist_stats
WHERE id = 220844bf-4860-49d6-9a4b-6b5d3a79cbfb;
// end::select[]
CAPTURE OFF;
