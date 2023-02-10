SOURCE 'role-internal.cql';

// tag::data[]
REVOKE SELECT, MODIFY
ON KEYSPACE cycling 
FROM coach;
// end::data[]

// tag::alter[]
REVOKE ALTER
ON KEYSPACE cycling 
FROM coach;
// end::alter[]
