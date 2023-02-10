/* Map field and search index map fields example */

// tag::table[]
CREATE TABLE IF NOT EXISTS cycling.birthday_list (
  cyclist_name text PRIMARY KEY, 
  blist_ map<text, text>
);
// end::table[]
