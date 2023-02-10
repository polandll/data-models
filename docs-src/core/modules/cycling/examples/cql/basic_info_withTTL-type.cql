SOURCE '0_create_keyspace.cql';

// tag::droptype[]
DROP TYPE IF EXISTS cycling.basic_info_expire;
// end::droptype[]

// tag::basicinfoTTLexpiretype[]
CREATE TYPE IF NOT EXISTS cycling.basic_info_expire (
  birthday timestamp,
  nationality text,
  height text,
  weight text,
  next_race text
);
// end::basicinfoTTLexpiretype[]

// tag::createtable[]
CREATE TABLE IF NOT EXISTS cycling.basic_info_TTL_expire (
  id UUID PRIMARY KEY,
  lastname text,
  basics basic_info_expire
);
// end::createtable[]

// tag::insertTTLexpiretype[]
INSERT INTO cycling.basic_info_TTL_expire (
  id, lastname, basics
) VALUES (
  e7ae5cf3-d358-4d99-b900-85902fda9bb0,
  'FRAME',
  {
    birthday : '1993-06-18',
    nationality : 'New Zealand',
    weight : '175',
    height : '72',
    next_race : 'Amgen Tour of California'
  }
)
USING TIMESTAMP 100 AND TTL 10000;
// end::insertTTLexpiretype[]

// tag::updateTTLexpiretype[]
UPDATE cycling.basic_info_TTL_expire 
USING TTL 100 
SET basics.next_race = 'Tour de France' 
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0;
// end::updateTTLexpiretype[]

// tag::selectTTLexpiretype[]
SELECT *
FROM cycling.basic_info_TTL_expire;
// end::selectTTLexpiretype[]

// tag::selectWritetimeTTLexpiretype[]
SELECT WRITETIME(basics), TTL(basics)
FROM cycling.basic_info_TTL_expire 
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0;
// end::selectWritetimeTTLexpiretype[]
