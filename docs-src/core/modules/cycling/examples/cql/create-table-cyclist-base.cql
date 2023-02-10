// tag::cyclist_base[]
CREATE TABLE IF NOT EXISTS cycling.cyclist_base (
  cid UUID PRIMARY KEY,
  name text,
  age int,
  birthday date,
  country text
);
// end::cyclist_base[]
