// SOURCE 'birthday_list-table.cql';

// tag::index[]
CREATE SEARCH INDEX IF NOT EXISTS
ON cycling.birthday_list
WITH COLUMNS blist_ { excluded:true };
// end::index[]

// tag::desc_active[]
DESC ACTIVE SEARCH INDEX SCHEMA ON cycling.birthday_list;
// end::desc_active[]

// tag::type[]
// Add type
ALTER SEARCH INDEX SCHEMA
ON cycling.birthday_list
ADD types.fieldType[ @class='org.apache.solr.schema.TrieIntField', @name='TrieIntField' ];

// Control the data types of map fields by name
ALTER SEARCH INDEX SCHEMA
ON cycling.birthday_list
ADD fields.field[ @indexed='true', @multiValued='false', @name='blist_age', @type='TrieIntField' ];
// end::type[]

// tag::alter[]
ALTER SEARCH INDEX SCHEMA
ON cycling.birthday_list
ADD fields.field[ @name='blist_nation', @indexed='true', @multiValued='false', @type='StrField' ];
// end::alter[]

// tag::desc_pending[]
DESC PENDING SEARCH INDEX SCHEMA ON cycling.birthday_list;
// end::desc_pending[]

// Make the pending schema active and rebuild the index
// tag::reload[]
RELOAD SEARCH INDEX
ON cycling.birthday_list;
// end::reload[]

// tag::rebuild[]
REBUILD SEARCH INDEX
ON cycling.birthday_list;
// end::rebuild[]
