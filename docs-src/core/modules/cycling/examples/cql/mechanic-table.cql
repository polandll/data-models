SOURCE '0_create_keyspace.cql';

DROP MATERIALIZED VIEW IF EXISTS cycling.mechanic_view;
DROP TABLE IF EXISTS cycling.mechanic;

// tag::mechanic_table[]
CREATE TABLE IF NOT EXISTS cycling.mechanic (
  emp_id int,
  dept_id int,
  name text,
  age int,
  birthdate date,
  PRIMARY KEY (emp_id, dept_id)
);
// end::mechanic_table[]

// tag::data[]
INSERT INTO cycling.mechanic (
  emp_id, dept_id, name, age, birthdate
) VALUES (
  1, 1, 'Fred GREEN', 21, '1992-06-18'
);

INSERT INTO cycling.mechanic (
  emp_id, dept_id, name, age, birthdate
) VALUES (
  2, 1, 'John SMITH', 22, '1993-01-15'
);

INSERT INTO cycling.mechanic (
  emp_id, dept_id, name, age, birthdate
) VALUES (
  3, 2, 'Jane DOE', 23, '1994-02-07'
);

INSERT INTO cycling.mechanic (
  emp_id, dept_id, name, age, birthdate
) VALUES (
  4, 2, 'Jack JONES', 24, '1995-08-19'
);

INSERT INTO cycling.mechanic (
  emp_id, dept_id, name, age, birthdate
) VALUES (
  5, 3, 'Lisa SMITH', 25, '1996-10-04'
);
// end::data[]

CAPTURE 'select_all_from_mechanic.results';
// tag::select_all_from_mechanic[]
SELECT *
FROM cycling.mechanic;
// end::select_all_from_mechanic[]
CAPTURE OFF;

// tag::select_multiple_column_expression[]
SELECT (emp_id + dept_id) / age
FROM cycling.mechanic;

SELECT emp_id + dept_id / age
FROM cycling.mechanic;
// end::select_multiple_column_expression[]

// tag::mechanic_view[]
CREATE MATERIALIZED VIEW IF NOT EXISTS cycling.mechanic_view AS
  SELECT emp_id, dept_id, name, age, birthdate
  FROM cycling.mechanic
  WHERE emp_id IS NOT NULL
    AND dept_id IS NOT NULL
    AND name IS NOT NULL
    AND age IS NOT NULL
    AND birthdate IS NOT NULL
  PRIMARY KEY (age, emp_id, dept_id);
// end::mechanic_view[]

CAPTURE 'select_all_from_mechanic_view.results';
// tag::select_mechanic_view[]
SELECT *
FROM cycling.mechanic_view
WHERE age = 21;
// end::select_mechanic_view[]
CAPTURE OFF;
