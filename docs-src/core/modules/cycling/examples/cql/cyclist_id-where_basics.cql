SOURCE 'cyclist_id-table.cql';

// tag::basicwhere[]
SELECT
  firstname AS first,
  lastname AS last
FROM cycling.cyclist_id
WHERE lastname = 'COSTA'
  AND firstname = 'Adrien';
// end::basicwhere[]
