SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_sponsors_expire;

// tag::cyclistsponsorsexpireset[]
CREATE TABLE IF NOT EXISTS cycling.cyclist_sponsors_expire (
  cyclist_name text PRIMARY KEY,
  sponsorship set<text>
);
// end::cyclistsponsorsexpireset[]

// tag::insertTTLexpireset[]
INSERT INTO cycling.cyclist_sponsors_expire (
  cyclist_name, sponsorship
) VALUES (
  'PRIETO, Marcela',
  { 'Castrelli', 'Alfa Romeo' }
) 
USING TIMESTAMP 100
AND TTL 10000;
// end::insertTTLexpireset[]

// tag::updateTTLexpireset[]
UPDATE cycling.cyclist_sponsors_expire 
USING TIMESTAMP 200
AND TTL 20000 
SET sponsorship += { 'Tag Heuer' } 
WHERE cyclist_name = 'PRIETO, Marcela';
// end::updateTTLexpireset[]

// tag::selectTTLexpireset[]
SELECT *
FROM cycling.cyclist_sponsors_expire;
// end::selectTTLexpireset[]
