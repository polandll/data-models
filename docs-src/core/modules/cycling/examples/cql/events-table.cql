SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.events;

// tag::events_table[]
CREATE TABLE IF NOT EXISTS cycling.events (
  year int,
  start_month int,
  start_day int,
  end_month int,
  end_day int,
  race text,
  discipline text,
  location text,
  uci_code text,
  PRIMARY KEY (
    (year, discipline), start_month, start_day, race
  )
);
// end::events_table[]

COPY cycling.events
FROM 'events-data.csv'
WITH HEADER = true
  AND DELIMITER = '|';

// tag::select_with_in_and_equals_allow_filtering[]
SELECT *
FROM cycling.events
WHERE race = 'Superprestige - Hoogstraten -2017'
  AND start_month IN (1, 2)
ALLOW FILTERING;
// end::select_with_in_and_equals_allow_filtering[]

// tag::select_count[]
SELECT start_month, MAX(start_day), COUNT(*)
FROM cycling.events
WHERE year = 2017
  AND discipline = 'Cyclo-cross';
// end::select_count[]

CAPTURE 'select_all_from_events_with_order_by.results';
// tag::select_with_order_by[]
SELECT *
FROM cycling.events
WHERE year = 2017
  AND discipline = 'Cyclo-cross'
  AND start_month = 1
  AND start_day = 1
ORDER BY race;
// end::select_with_order_by[]
CAPTURE OFF;

// tag::select_with_order_multiple_columns[]
SELECT *
FROM cycling.events
WHERE year = 2017
  AND discipline = 'Cyclo-cross'
  AND start_month = 1
ORDER BY start_day, race;
// end::select_with_order_multiple_columns[]

// tag::select_with_where[]
SELECT *
FROM cycling.events
WHERE year = 2017
  AND discipline = 'Cyclo-cross'
  AND start_month = 1
  AND start_day = 1;
// end::select_with_where[]

CAPTURE 'select_from_events_non_existing_year.results';
// tag::select_with_non_existing_year[]
SELECT start_month, MAX(start_day)
FROM cycling.events
WHERE year = 2022
ALLOW FILTERING;
// end::select_with_non_existing_year[]
CAPTURE OFF;
