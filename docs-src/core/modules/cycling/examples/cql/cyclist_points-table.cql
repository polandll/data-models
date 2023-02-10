SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_points;

// tag::cpoints[]
CREATE TABLE IF NOT EXISTS cycling.cyclist_points (
  id UUID, 
  race_points int, 
  firstname text, 
  lastname text, 
  race_title text, 
  PRIMARY KEY (id, race_points)
);
// end::cpoints[]

// Insert data
INSERT INTO cycling.cyclist_points (
  id,race_points,firstname,lastname,race_title
) VALUES (
  e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 6, 'Giorgia', 'BRONZINI', 'Trofeo Alfredo Binda - Commune di Cittiglio'
);

INSERT INTO cycling.cyclist_points (
  id,race_points,firstname,lastname,race_title
) VALUES (
  e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 75, 'Giorgia', 'BRONZINI', 'Act van Westerveld'
);

INSERT INTO cycling.cyclist_points (
  id,race_points,firstname,lastname,race_title
) VALUES (
  e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 120, 'Giorgia', 'BRONZINI', 'Tour of Chongming Island World Cup'
);

// Calculate sum of total points for a cyclist
// tag::simplesumpoints[]
SELECT SUM(race_points)
FROM cycling.cyclist_points
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// end::simplesumpoints[]

// Filter and SUM on a clustering column using an AND relation
CAPTURE 'select_sum_race_points_from_cyclist_points.results';
// tag::filtersumpoints[]
SELECT SUM(race_points) 
FROM cycling.cyclist_points 
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac
  AND race_points > 7;
// end::filtersumpoints[]
CAPTURE OFF;

// Filter for MAX points
CAPTURE 'select_max_race_points_from_cyclist_points.results';
// tag::filtermaxpts[]
SELECT MAX(race_points) 
FROM cycling.cyclist_points
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// end::filtermaxpts[]
CAPTURE OFF;

// Filter for MIN points
CAPTURE 'select_min_race_points_from_cyclist_points.results';
// tag::filterminpts[]
SELECT MIN(race_points) 
FROM cycling.cyclist_points
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// end::filterminpts[]
CAPTURE OFF;

// Filter for AVG points
CAPTURE 'select_avg_race_points_from_cyclist_points.results';
// tag::filteravgpts[]
SELECT AVG(race_points) 
FROM cycling.cyclist_points
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// end::filteravgpts[]
CAPTURE OFF;

// Get WRITETIME for a column
// tag::writetime[]
SELECT WRITETIME (firstname)
FROM cycling.cyclist_points
WHERE id = e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// end::writetime[]
