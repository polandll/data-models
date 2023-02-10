// Requires authentication and authorization enabled using auth and role mgmt internal schemes

SOURCE '0_create_keyspace.cql';
// SOURCE 'cyclist_category-table.cql';
SOURCE 'flog-function.cql';

DROP ROLE IF EXISTS sys_admin;
DROP ROLE IF EXISTS martin;
DROP ROLE IF EXISTS sandy;
DROP ROLE IF EXISTS sam;
DROP ROLE IF EXISTS cycling_admin;
DROP ROLE IF EXISTS team_manager;
DROP ROLE IF EXISTS role_admin;
DROP ROLE IF EXISTS coach;

// tag::superuser[]
CREATE ROLE IF NOT EXISTS sys_admin 
WITH LOGIN = true
  AND PASSWORD = 'changeme' 
  AND SUPERUSER = true;
// end::superuser[]

// internal roles used as user accounts

// tag::user[]
CREATE ROLE IF NOT EXISTS martin 
WITH PASSWORD = 'password' 
  AND LOGIN = true;
// end::user[]

CREATE ROLE IF NOT EXISTS sandy
WITH PASSWORD = 'password'
  AND LOGIN = true;

CREATE ROLE IF NOT EXISTS sam
WITH PASSWORD = 'password'
  AND LOGIN = true;

// tag::permissionrole[]
CREATE ROLE IF NOT EXISTS cycling_admin;
// end::permissionrole[]

// tag::droprole[]
DROP ROLE IF EXISTS team_manager;
// end::droprole[]

CREATE ROLE IF NOT EXISTS team_manager;

CREATE ROLE IF NOT EXISTS role_admin;

// tag::coach[]
CREATE ROLE IF NOT EXISTS coach 
WITH PASSWORD = 'All4One2day!' 
  AND LOGIN = true;
// end::coach[]

// tag::hashed_coach[]
CREATE ROLE IF NOT EXISTS coach 
WITH HASHED PASSWORD = '$2a$10$8ht4.R2aar38wyXdJxHzj.Ww8xDL5wBYGt1SJ2l46N34MBjLSyD.e' 
  AND LOGIN = true;
// end::hashed_coach[]

// tag::cyclingadmin[]
CREATE ROLE IF NOT EXISTS cycling_admin;
// end::cyclingadmin[]

REVOKE AUTHORIZE
ON KEYSPACE cycling
FROM cycling_admin;

// tag::allauthks[]
GRANT AUTHORIZE
ON KEYSPACE cycling
TO cycling_admin;
// end::allauthks[]

// tag::caALL[]
GRANT ALL PERMISSIONS
ON KEYSPACE cycling
TO cycling_admin;
// end::caALL[]

// tag::roletorole[]
GRANT cycling_admin
TO coach;
// end::roletorole[]

REVOKE AUTHORIZE FOR SELECT, TRUNCATE, UPDATE
ON KEYSPACE cycling
FROM sam;

// tag::authdata[]
GRANT AUTHORIZE FOR SELECT, TRUNCATE, UPDATE
ON KEYSPACE cycling
TO sam;
// end::authdata[]

// tag::ap[]
GRANT ALL PERMISSIONS
ON KEYSPACE cycling
TO cycling_admin;
// end::ap[]

REVOKE SELECT, TRUNCATE, UPDATE
ON KEYSPACE cycling
FROM coach;

// tag::data[]
GRANT SELECT, TRUNCATE, UPDATE
ON KEYSPACE cycling
TO coach;
// end::data[]

REVOKE ALTER
ON KEYSPACE cycling
FROM coach;

// tag::alter[]
GRANT ALTER
ON KEYSPACE cycling
TO coach;
// end::alter[]

REVOKE SELECT
ON 'Sprint' ROWS IN cycling.cyclist_category
FROM martin;

// tag::rows[]
GRANT SELECT
ON 'Sprint' ROWS IN cycling.cyclist_category
TO martin;
// end::rows[]

// THIS GENERATES A WARNING
// tag::restrict[]
RESTRICT TRUNCATE, UPDATE, SELECT
ON KEYSPACE cycling
TO role_admin;
// end::restrict[]

// tag::dbadmin[]
CREATE ROLE IF NOT EXISTS db_admin 
WITH superuser = true
  AND login = true 
  AND password = 'anypasswordwilldo';
// end::dbadmin[]

// THIS GENERATES A WARNING
// tag::rdbadmin[]
RESTRICT TRUNCATE, UPDATE, SELECT
ON KEYSPACE cycling
TO db_admin;
// end::rdbadmin[]

// internal only give permissions from one role to another
GRANT cycling_admin TO martin;
GRANT team_manager TO sandy;
GRANT EXECUTE ON FUNCTION cycling.fLog(double) TO team_manager;

GRANT SELECT ON ALL KEYSPACES TO team_manager;
GRANT sys_admin TO team_manager;

// removing access 
REVOKE SELECT ON ALL KEYSPACES FROM team_manager;
REVOKE EXECUTE ON FUNCTION cycling.fLog(double) FROM team_manager;
REVOKE sys_admin FROM team_manager;
REVOKE team_manager FROM sandy;

REVOKE DESCRIBE, ALTER ON ALL ROLES FROM sys_admin;

// role management examples
GRANT DESCRIBE, ALTER ON ALL ROLES TO sys_admin;

// tag::CHANGE_PW[]
ALTER ROLE sandy
WITH PASSWORD = 'bestTeam';
// end::CHANGE_PW[]

// tag::CHANGE_HASHED_PW[]
ALTER ROLE sandy
WITH HASHED PASSWORD = '$2a$10$Mvs4GDHlNG8MhYe5SFi7ge1R1SMbScIPVtKReSEKpqwcQOvep0Zqq';
// end::CHANGE_HASHED_PW[]
