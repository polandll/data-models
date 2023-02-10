SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.calendar;

// NOT A QUERY, JUST A TABLE FOR QUERIES
// CREATE TABLE WITH LIST FOR UPDATE
// The SELECT statements that use this table can be found below

// tag::listColumn[]
CREATE TABLE IF NOT EXISTS cycling.calendar (
  race_id int,
  race_name text,
  race_start_date timestamp,
  race_end_date timestamp,
  PRIMARY KEY (
    race_id, race_start_date, race_end_date
  )
) WITH CLUSTERING ORDER BY (
  race_start_date DESC, race_end_date DESC
);
// end::listColumn[]

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  100, 'Giro d''Italia', '2015-05-09', '2015-05-31'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  101, 'Criterium du Dauphine', '2015-06-07', '2015-06-14'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  102, 'Tour de Suisse', '2015-06-13', '2015-06-21'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  103, 'Tour de France', '2015-07-04', '2015-07-26'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  100, 'Giro d''Italia', '2014-05-08', '2014-05-30'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  101, 'Criterium du Dauphine', '2014-06-06', '2014-06-13'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  102, 'Tour de Suisse', '2014-06-12', '2014-06-20'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  103, 'Tour de France', '2014-07-03', '2014-07-25'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  100, 'Giro d''Italia', '2013-05-07', '2014-05-29'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  101, 'Criterium du Dauphine', '2013-06-05', '2013-06-12'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  102, 'Tour de Suisse', '2013-06-11', '2013-06-19'
);

INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  103, 'Tour de France', '2013-07-02', '2013-07-24'
);

CAPTURE 'select_all_from_calendar_allow_filtering.results';
// tag::select_start_date[]
SELECT * 
FROM cycling.calendar 
WHERE race_start_date = '2015-06-13' 
ALLOW FILTERING;
// end::select_start_date[]
CAPTURE OFF;

// tag::select_with_in[]
SELECT * 
FROM cycling.calendar 
WHERE race_id IN (101, 102, 103); 
// end::select_with_in[]

CAPTURE 'select_all_from_calendar_with_date_range.results';
// tag::select_with_range[]
SELECT * 
FROM cycling.calendar 
WHERE race_id = 101
  AND race_start_date >= '2014-05-27' 
  AND race_start_date < '2017-06-16';
// end::select_with_range[]
CAPTURE OFF;

// tag::paging_off[]
PAGING OFF;
// end::paging_off[]

CAPTURE 'select_all_from_calendar_with_in_and_order.results';
// tag::select_with_in_and_order[]
SELECT *
FROM cycling.calendar
WHERE race_id IN (100, 101, 102)
ORDER BY race_start_date DESC;
// end::select_with_in_and_order[]
CAPTURE OFF;

CAPTURE 'select_all_from_calendar_with_allow_filtering.results';
// tag::select_with_allow_filtering[]
SELECT * 
FROM cycling.calendar 
WHERE race_name IN ('Giro d''Italia','Tour de Suisse') 
ALLOW FILTERING;
// end::select_with_allow_filtering[]

CAPTURE 'select_all_from_calendar_with_in_and_asc_order.results';
// tag::select_with_in_and_asc_order[]
SELECT *
FROM cycling.calendar
WHERE race_id IN (100, 101, 102)
ORDER BY race_start_date ASC;
// end::select_with_in_and_asc_order[]
CAPTURE OFF;

CAPTURE 'select_all_from_calendar_with_two_ins.results';
// tag::select_with_two_ins[]
SELECT *
FROM cycling.calendar
WHERE race_id IN (100, 101, 102)
  AND (race_start_date, race_end_date)
  IN (('2015-05-09', '2015-05-31'), ('2015-05-06', '2015-05-31'));
// end::select_with_two_ins[]
CAPTURE OFF;

CAPTURE 'select_all_from_calendar_with_in_and_range.results';
// tag::select_with_in_and_range[]
SELECT *
FROM cycling.calendar
WHERE race_id IN (100, 101, 102)
  AND (race_start_date, race_end_date) >= ('2015-05-09', '2015-05-24');
// end::select_with_in_and_range[]
CAPTURE OFF;

// tag::insert_with_TTL[]
INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  200, 'placeholder', '2015-05-27', '2015-05-27'
)
USING TTL 200;
// end::insert_with_TTL[]

CAPTURE 'select_ttl_from_calendar.results';
// tag::select_with_TTL[]
SELECT TTL(race_name)
FROM cycling.calendar
WHERE race_id = 200;
// end::select_with_TTL[]
CAPTURE OFF;

// tag::update_with_TTL[]
UPDATE cycling.calendar 
USING TTL 300 
SET race_name = 'Tour de France - Stage 12' 
WHERE race_id = 200 
  AND race_start_date = '2015-05-27' 
  AND race_end_date = '2015-05-27';
// end::update_with_TTL[]

CAPTURE 'select_ttl_after_update_from_calendar.results';
SELECT TTL(race_name)
FROM cycling.calendar
WHERE race_id = 200;
CAPTURE OFF;

// tag::update_TTL_0[]
UPDATE cycling.calendar 
USING TTL 0
SET race_name = 'Tour de France - Stage 12' 
WHERE race_id = 200 
  AND race_start_date = '2015-05-27' 
  AND race_end_date = '2015-05-27';
// end::update_TTL_0[]

// tag::delete[]
DELETE
FROM cycling.calendar
WHERE race_id = 200;
// end::delete[]

// tag::insert_with_escape_characters[]
INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  201, 'Women''s Tour of New Zealand', '2015-02-18', '2015-02-22'
);
// end::insert_with_escape_characters[]

DELETE
FROM cycling.calendar
WHERE race_id = 201;

// tag::insert_with_dollar_characters[]
INSERT INTO cycling.calendar (
  race_id, race_name, race_start_date, race_end_date
) VALUES (
  201, $$Women's Tour of New Zealand$$, '2015-02-18', '2015-02-22'
);
// end::insert_with_dollar_characters[]

DELETE
FROM cycling.calendar
WHERE race_id = 201;
