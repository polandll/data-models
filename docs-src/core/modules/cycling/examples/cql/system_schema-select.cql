CAPTURE 'select_all_from_system_schema_keyspaces.results';
// tag::keyspaces[]
SELECT *
FROM system_schema.keyspaces;
// end::keyspaces[]
CAPTURE OFF;

EXPAND ON;
CAPTURE 'select_all_from_system_schema_tables.results';
// tag::tables[]
SELECT *
FROM system_schema.tables 
WHERE keyspace_name = 'cycling'
  AND table_name = 'cyclist_name';
// end::tables[]
CAPTURE OFF;
EXPAND OFF;

CAPTURE 'select_all_from_system_schema_columns.results';
// tag::columns[]
SELECT *
FROM system_schema.columns 
WHERE keyspace_name = 'cycling'
  AND table_name = 'cyclist_name';
// end::columns[]
CAPTURE OFF;

CAPTURE 'select_id_from_system_schema_tables.results';
// tag::id[]
SELECT id, keyspace_name, table_name
FROM system_schema.tables 
WHERE keyspace_name = 'cycling'
  AND table_name = 'cyclist_name';
// end::id[]
CAPTURE OFF;

CAPTURE 'select_from_system_peers.results';
// tag::peers[]
SELECT peer, data_center, dse_version, graph
FROM system.peers;
// end::peers[]
CAPTURE OFF;

EXPAND ON;
CAPTURE 'select_from_system_functions.results';
// tag::functions[]
SELECT *
FROM system_schema.functions
LIMIT 1;
// end::functions[]
CAPTURE OFF;
EXPAND OFF;

EXPAND ON;
CAPTURE 'select_from_system_aggregates.results';
// tag::aggregates[]
SELECT *
FROM system_schema.aggregates
LIMIT 1;
// end::aggregates[]
CAPTURE OFF;
EXPAND OFF;

EXPAND ON;
CAPTURE 'select_from_system_types.results';
// tag::types[]
SELECT *
FROM system_schema.types
LIMIT 1;
// end::types[]
CAPTURE OFF;
EXPAND OFF;

// tag::tasks[]
SELECT total - progress AS remaining
FROM system_views.sstable_tasks;
// end::tasks[]

// tag::events[]
SELECT *
FROM system_traces.events;
// end::events[]
