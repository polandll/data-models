// Create index on map ENTRIES
// tag::entriesidx[]
CREATE INDEX IF NOT EXISTS blist_idx
ON cycling.birthday_list ( ENTRIES(blist) );
// end::entriesidx[]

// Create index on map VALUES
// tag::mapvaluesidx[]
CREATE INDEX IF NOT EXISTS blist_values_idx
ON cycling.birthday_list ( VALUES(blist) );
// end::mapvaluesidx[]
