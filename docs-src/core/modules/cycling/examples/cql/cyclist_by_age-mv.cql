// Source keyspace, tables, and insert data
SOURCE '0_create_keyspace.cql';
// SOURCE 'cyclist_base-table.cql';
// SOURCE 'cyclist_base_ext-table.cql';

// tag::dropmv[]
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_age;
// end::dropmv[]

// tag::dropOtherMVs[]
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_age;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday_and_age;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_country_and_birthday;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday_and_age19;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_age_birthday_cid;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday_Netherlands;
// end::dropOtherMVs[]

// ORIGINAL MV
// tag::age[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_age AS
  SELECT age, cid, birthday, country, name
  FROM cycling.cyclist_base 
  WHERE age IS NOT NULL
    AND cid IS NOT NULL
  PRIMARY KEY (age, cid)
  WITH CLUSTERING ORDER BY (cid ASC)
  AND caching = {
    'keys' : 'ALL',
    'rows_per_partition' : '100'
  }
  AND comment = 'Based on table cyclist';
// end::age[]

CAPTURE 'select_from_cyclist_by_age_18.results';
// tag::select_from_cyclist_by_age_18[]
SELECT age, name, birthday
FROM cycling.cyclist_by_age
WHERE age = 18;
// end::select_from_cyclist_by_age_18[]
CAPTURE OFF;

// tag::cyclist_by_birthday[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_birthday 
  AS SELECT age, birthday, name, country 
  FROM cycling.cyclist_base
  WHERE birthday IS NOT NULL
    AND cid IS NOT NULL
  PRIMARY KEY (birthday, cid);
// end::cyclist_by_birthday[]

// tag::cyclist_by_country[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_country 
  AS SELECT age, birthday, name, country 
  FROM cycling.cyclist_base
  WHERE country IS NOT NULL
    AND cid IS NOT NULL
  PRIMARY KEY (country, cid);
// end::cyclist_by_country[]

// ADD 2 non-PK columns
// tag::plainMVtwoNonPKcols[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_birthday_and_age AS
  SELECT age, cid, birthday, country, name
  FROM cycling.cyclist_base
  WHERE age IS NOT NULL
    AND birthday IS NOT NULL
    AND cid IS NOT NULL
  PRIMARY KEY (cid, birthday, age);
// end::plainMVtwoNonPKcols[]

// ADD 2 non-PK columns and specify one in the WHERE phrase
// tag::WhereCountryMVtwoNonPKcols[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_country_and_birthday AS
  SELECT age, cid, birthday, country, name
  FROM cycling.cyclist_base
  WHERE birthday IS NOT NULL
    AND cid IS NOT NULL
    AND country = 'Australia'
  PRIMARY KEY (cid, country, birthday);
// end::WhereCountryMVtwoNonPKcols[]

// ADD 2 non-PK columns and specify one in the WHERE phrase
// tag::WhereAgeMVtwoNonPKcols[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_birthday_and_age19 AS
  SELECT age, cid, birthday, country, name
  FROM cycling.cyclist_base
  WHERE birthday IS NOT NULL
    AND cid IS NOT NULL
    AND age = 19
  PRIMARY KEY (cid, birthday, age);
// end::WhereAgeMVtwoNonPKcols[]

// ADD multiple PK columns, but MV has different order for values
// tag::MVmultPKcols[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_age_birthday_cid AS
  SELECT age, cid, birthday, country, name
  FROM cycling.cyclist_base_ext
  WHERE age IS NOT NULL
    AND birthday IS NOT NULL
    AND cid IS NOT NULL
  PRIMARY KEY (age, birthday, cid);
// end::MVmultPKcols[]

// tag::MVNetherlands[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.cyclist_by_birthday_Netherlands 
  AS SELECT age, birthday, name, country 
  FROM cycling.cyclist_base
  WHERE birthday IS NOT NULL
    AND cid IS NOT NULL
    AND country = 'Netherlands'
  PRIMARY KEY (birthday, cid);
// end::MVNetherlands[]

// add a comment to describe the table
// tag::comment[]
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH comment = 'A most excellent and useful view'
AND bloom_filter_fp_chance = 0.02;
// end::comment[]

// alter example
// tag::compression[]
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH compression = { 
  'sstable_compression' : 'DeflateCompressor', 
  'chunk_length_kb' : 64
}
AND compaction = {
  'class' : 'SizeTieredCompactionStrategy', 
  'max_threshold' : 64
};
// end::compression[]

// alter example
// tag::cache[]
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH caching = { 
  'keys' : 'NONE', 
  'rows_per_partition' : '15'
};
// end::cache[]

// tag::test[]
INSERT INTO cycling.cyclist_base (
  cid,name,age,birthday,country
) VALUES ( 
  d1aad83b-be60-47a4-bd6e-069b8da0d97b,
  'Johannes HEIDER', 
  27, 
  '1987-09-04',
  'Germany'
);
// end::test[]

// Add some data to cyclist_base
// tag::cyclist_baseData[]
INSERT INTO cycling.cyclist_base (
  cid,name,age,birthday,country
) VALUES (
  d1aad83b-be60-47a4-bd6e-069b8da0d97b,
  'Johannes HEIDER',
  27,
  '1987-09-04',
  'Germany'
);

INSERT INTO cycling.cyclist_base (
  cid,name,age,birthday,country
) VALUES (
  1c526849-d3a2-42a3-bcf9-7903c80b3d16,
  'Kanden GROVES',
  19,
  '1998-12-23',
  'Australia'
);

INSERT INTO cycling.cyclist_base (
  cid,name,age,birthday,country
) VALUES (
  96c4c40d-58c8-4710-b73f-681e9b1f70ae,
  'Benjamin DYBALL',
  29,
  '1989-04-20',
  'Australia'
);

INSERT INTO cycling.cyclist_base (
  cid,name,age,birthday,country
) VALUES (
  410919ef-bd1b-4efa-8256-b0fd8ab67029,
  'Iskandarbek SHODIEV',
  19,
  '1999-01-04',
  'Uzbekistan'
);
// end::cyclist_baseData[]

// Add some data to cyclist_base_ext
// tag::cyclist_base_extData[]
INSERT INTO cycling.cyclist_base_ext (
  cid,name,age,birthday,country
) VALUES (
  d1aad83b-be60-47a4-bd6e-069b8da0d97b,
  'Johannes HEIDER',
  27,
  '1987-09-04',
  'Germany'
);

INSERT INTO cycling.cyclist_base_ext (
  cid,name,age,birthday,country
) VALUES (
  1c526849-d3a2-42a3-bcf9-7903c80b3d16,
  'Kanden GROVES',
  19,
  '1998-12-23',
  'Australia'
);

INSERT INTO cycling.cyclist_base_ext (
  cid,name,age,birthday,country
) VALUES (
  96c4c40d-58c8-4710-b73f-681e9b1f70ae,
  'Benjamin DYBALL',
  29,
  '1989-04-20',
  'Australia'
);

INSERT INTO cycling.cyclist_base_ext (
  cid,name,age,birthday,country
) VALUES (
  410919ef-bd1b-4efa-8256-b0fd8ab67029,
  'Iskandarbek SHODIEV',
  19,
  '1999-01-04',
  'Uzbekistan'
);
// end::cyclist_base_extData[]

// SELECTS

CAPTURE 'select_cyclist_by_age.results';
// tag::selectMVage[]
SELECT *
FROM cycling.cyclist_by_age;
// end::selectMVage[]
CAPTURE OFF;

CAPTURE 'select_cyclist_by_birthday_and_age.results';
// tag::selectMVBdayAge[]
SELECT *
FROM cycling.cyclist_by_birthday_and_age;
// end::selectMVBdayAge[]
CAPTURE OFF;

CAPTURE 'select_cyclist_by_country_and_birthday.results';
// tag::selectMVCountryBday[]
SELECT *
FROM cycling.cyclist_by_country_and_birthday;
// end::selectMVCountryBday[]
CAPTURE OFF;

// tag::selectMV19BdayAge[]
SELECT *
FROM cycling.cyclist_by_birthday_and_age19;
// end::selectMV19BdayAge[]

// tag::MVAge19BdayCID[]
SELECT *
FROM cycling.cyclist_by_age_birthday_cid
WHERE age = 19;
// end::MVAge19BdayCID[]

// tag::MV19981223CIDAge19Bday[]
SELECT *
FROM cycling.cyclist_by_age_birthday_cid
WHERE age = 19
  AND birthday = '1998-12-23';
// end::MV19981223CIDAge19Bday[]

// THIS QUERY PRODUCES AN INTENTIONAL ERROR
// tag::MVAgeBday19981223CID[]
SELECT *
FROM cycling.cyclist_by_age_birthday_cid
WHERE birthday = '1998-12-23';
// end::MVAgeBday19981223CID[]

CAPTURE 'select_from_cyclist_by_birthday_where_birthday_1987.results';
// tag::select_from_cyclist_by_birthday_where_birthday_1987[]
SELECT age, name, birthday
FROM cycling.cyclist_by_birthday
WHERE birthday = '1987-09-04';
// end::select_from_cyclist_by_birthday_where_birthday_1987[]
CAPTURE OFF;

CAPTURE 'select_from_cyclist_by_country_where_country_netherlands.results';
// tag::select_from_cyclist_by_country_where_country_netherlands[]
SELECT age, name, birthday
FROM cycling.cyclist_by_country
WHERE country = 'Netherlands';
// end::select_from_cyclist_by_country_where_country_netherlands[]
CAPTURE OFF;

CAPTURE 'select_from_cyclist_by_birthday_Netherlands_where_birthday_1997.results';
// tag::select_from_cyclist_by_birthday_Netherlands_where_birthday_1997[]
SELECT age, name, birthday
FROM cycling.cyclist_by_birthday_Netherlands
WHERE birthday = '1997-02-08';
// end::select_from_cyclist_by_birthday_Netherlands_where_birthday_1997[]
CAPTURE OFF;
