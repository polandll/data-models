SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.race_times_summary;

// tag::TABLE[]
CREATE TABLE IF NOT EXISTS cycling.race_times_summary (
  race_date date,
  race_time time,
  PRIMARY KEY (race_date, race_time)
);
// end::TABLE[]

// tag::DATA[]
INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:01:18', '2017-04-14'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:15:20', '2017-04-14'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '11:15:38', '2017-04-14'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '12:15:40', '2017-04-14'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:01:18', '2018-07-26'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:15:20', '2018-07-26'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '11:15:38', '2018-07-26'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '12:15:40', '2018-07-26'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:01:18', '2019-03-21'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '10:15:20', '2019-03-21'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '11:15:38', '2019-03-21'
);

INSERT INTO cycling.race_times_summary (
  race_time, race_date
) VALUES (
  '12:15:40', '2019-03-21'
);
// end::DATA[]

CAPTURE 'select_all_from_race_times_summary.results';
SELECT *
FROM cycling.race_times_summary;
CAPTURE OFF;

CAPTURE 'select_from_race_times_summary_group_by_race_date.results';
// tag::select_race_date_group_by_race_date[]
SELECT race_date, race_time 
FROM cycling.race_times_summary
GROUP BY race_date;
// end::select_race_date_group_by_race_date[]
CAPTURE OFF;

CAPTURE 'select_from_race_times_summary_group_by_floor.results';
// tag::select_race_date_group_by_floor[]
SELECT race_date, FLOOR(race_time, 1h), COUNT(*)
FROM cycling.race_times_summary
GROUP BY race_date, FLOOR(race_time, 1h);
// end::select_race_date_group_by_floor[]
CAPTURE OFF;
