/* Map entries and regular index map fields example */

// tag::blisttable[]
CREATE TABLE IF NOT EXISTS cycling.birthday_list (
  cyclist_name text PRIMARY KEY, 
  blist map<text, text>
);
// end::blisttable[]
