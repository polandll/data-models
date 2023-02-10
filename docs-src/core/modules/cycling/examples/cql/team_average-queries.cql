SOURCE '0_create_keyspace.cql';
SOURCE 'team_average-table.cql';

CAPTURE 'select_average_from_team_average.results';
// tag::AVG[]
SELECT AVG(cyclist_time_sec) AS Average
FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// end::AVG[]
CAPTURE OFF;

CAPTURE 'select_count_from_team_average.results';
// tag::COUNT[]
SELECT COUNT(cyclist_name) AS Row_Count
FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// end::COUNT[]
CAPTURE OFF;

CAPTURE 'select_min_from_team_average.results';
// tag::MIN[]
SELECT MIN(cyclist_time_sec) AS Fastest
FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// end::MIN[]
CAPTURE OFF;

CAPTURE 'select_max_from_team_average.results';
// tag::MAX[]
SELECT MAX(cyclist_time_sec) AS Slowest
FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// end::MAX[]
CAPTURE OFF;

CAPTURE 'select_sum_from_team_average.results';
// tag::SUM[]
SELECT SUM(cyclist_time_sec) AS Total_Time
FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// end::SUM[]
CAPTURE OFF;
