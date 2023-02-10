// SOURCE 'rank_by_year_and_name-table.cql';

// tag::pplimit[]
SELECT rank, cyclist_name AS name
FROM cycling.rank_by_year_and_name
PER PARTITION LIMIT 2;
// end::pplimit[]

// tag::InRestrictions[]
SELECT rank, cyclist_name as name
FROM cycling.rank_by_year_and_name
WHERE race_name = 'Tour of Japan - Stage 4 - Minami > Shinshu'
  AND race_year IN (2014, 2015);
// end::InRestrictions[]

// tag::filterRegular[]
SELECT rank, cyclist_name AS name
FROM cycling.rank_by_year_and_name
WHERE race_name = 'Tour of Japan - Stage 4 - Minami > Shinshu'
  AND race_year = 2015
  AND rank <= 2;
// end::filterRegular[]

// tag::tokenize[]
SELECT
  race_name AS name,
  race_year AS year
FROM cycling.rank_by_year_and_name
WHERE TOKEN(race_year,race_name) >= 4582455970709790046;
// end::tokenize[]

// tag::sdistinct[]
SELECT
  TOKEN(race_year,race_name) AS tokens,
  race_name AS name,
  race_year AS year
FROM cycling.rank_by_year_and_name
PER PARTITION LIMIT 1;
// end::sdistinct[]

// tag::node_cycling[]
SELECT
  TOKEN(race_year, race_name),
  race_name AS name,
  race_year AS year
FROM cycling.rank_by_year_and_name
WHERE TOKEN(race_year, race_name) >= -3074457345618258603
AND TOKEN(race_year, race_name) <= 3074457345618258602;
// end::node_cycling[]
