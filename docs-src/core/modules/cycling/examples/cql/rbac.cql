SOURCE 'flog-function.cql';

// when authentication and authorization is enabled

// internal roles used as user accounts
DROP ROLE IF EXISTS sys_admin;
DROP ROLE IF EXISTS team_manager;
DROP ROLE IF EXISTS sandy;
DROP ROLE IF EXISTS role_admin;
CREATE ROLE IF NOT EXISTS sys_admin WITH SUPERUSER = true; // gives role access to everything
CREATE ROLE IF NOT EXISTS team_manager WITH PASSWORD = 'RockIt4Us!';
CREATE ROLE IF NOT EXISTS sandy WITH PASSWORD = 'password' AND LOGIN = true;
CREATE ROLE IF NOT EXISTS role_admin WITH PASSWORD = 'changeme' AND LOGIN = true;

// data resource examples
GRANT MODIFY ON KEYSPACE cycling TO team_manager;
GRANT AUTHORIZE ON ALL KEYSPACES TO sys_admin;

// internal role permission collects as DB object
GRANT sys_admin TO team_manager;
GRANT team_manager TO sandy;
GRANT SELECT ON ALL KEYSPACES TO team_manager;
GRANT EXECUTE ON FUNCTION cycling.fLog(double) TO team_manager;

// removing access 
REVOKE SELECT ON ALL KEYSPACES FROM team_manager;
REVOKE EXECUTE ON FUNCTION cycling.fLog(double) FROM team_manager;
REVOKE sys_admin FROM team_manager;
REVOKE team_manager FROM sandy;

// role management examples
GRANT DESCRIBE, ALTER ON ALL ROLES TO sys_admin;

LIST ROLES;
LIST ROLES OF sandy;
LIST ALL PERMISSIONS OF sandy;
LIST ALL PERMISSIONS ON cycling.cyclist_name OF team_manager;

// tag::CHANGE_PW[]
ALTER ROLE sandy WITH PASSWORD = 'bestTeam';
// end::CHANGE_PW[]

// tag::CHANGE_HASHED_PW[]
ALTER ROLE sandy WITH PASSWORD = '$2a$10$Mvs4GDHlNG8MhYe5SFi7ge1R1SMbScIPVtKReSEKpqwcQOvep0Zqq';
// end::CHANGE_HASHED_PW[]

// tag::ROLE_SU[]
ALTER ROLE sandy SUPERUSER;
// end::ROLE_SU[]
