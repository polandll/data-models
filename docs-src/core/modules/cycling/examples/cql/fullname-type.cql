SOURCE '0_create_keyspace.cql';

// tag::drop[]
DROP TYPE IF EXISTS cycling.fullname;
// end::drop[]

// Store first and last in the same column using a custom type

// tag::fullname[]
CREATE TYPE IF NOT EXISTS cycling.fullname (
  firstname text,
  lastname text
);
// end::fullname[]

// tag::alt[]
ALTER TYPE cycling.fullname
ADD middlename text;
// end::alt[]

// tag::rename[]
ALTER TYPE cycling.fullname
RENAME middlename TO middle
  AND lastname TO last
  AND firstname TO first;
// end::rename[]

ALTER TYPE cycling.fullname
RENAME middle to middlename
  AND last to lastname
  AND first TO firstname;
