// SOURCE 'comments-table.cql';

// tag::create[]
CREATE SEARCH INDEX IF NOT EXISTS
ON cycling.comments 
WITH COLUMNS record_id { excluded:true }, * {excluded:false};
// end::create[]

// **CHANGING the CONFIG**

// tag::directoryFactory[]
ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET directoryFactory = 'encrypted';
// end::directoryFactory[]

// tag::active[]
RELOAD SEARCH INDEX
ON cycling.comments;
// end::active[]

// tag::rebuild[]
RELOAD SEARCH INDEX
ON cycling.comments;

REBUILD SEARCH INDEX
ON cycling.comments;
// end::rebuild[]

// tag::cache[]
ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET autoCommitTime = 10000;
// end::cache[]

// tag::requesth[]
ALTER SEARCH INDEX CONFIG
ON cycling.comments 
ADD requestHandler[@name='/elevate',@class='solr.SearchHandler', @startup='lazy'] 
WITH $$ {"defaults":[{"echoParams":"explicit"}],"last-components":["elevator"]} $$;
// end::requesth[]

// Policy to merge large segements due to deletes
// tag::delete[]
ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;

ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;

ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;
// end::delete[]

// tag::commit[]
COMMIT SEARCH INDEX
ON cycling.comments;
// end::commit[]

// **CHANGING the SCHEMA**

// tag::add_string_field[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments 
ADD fields.field[@name='fieldname', @type='StrField', @multiValued = 'false', @indexed='true'];
// end::add_string_field[]

// tag::column_name[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments 
ADD FIELD record_id;
// end::column_name[]

// tag::rename[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments 
SET field[@name='fieldname']@name = 'anotherFieldName';
// end::rename[]

// tag::type[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments 
SET field[@name='fieldname']@type = 'UUIDField';
// end::type[]

// tag::drop_another[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments 
DROP field anotherFieldName;
// end::drop_another[]

// **CHANGING the CONFIG **
// tag::autocommit[]
ALTER SEARCH INDEX CONFIG
ON cycling.comments 
SET autoCommitTime = 1000;
// end::autocommit[]

// tag::add_text_field[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments
SET types.fieldType[@name='TextField']@class='org.apache.solr.schema.TextField';

ALTER SEARCH INDEX SCHEMA
ON cycling.comments
SET fields.field[@name='comment']@type='TextField';
// end::add_text_field[]

// tag::drop_text_field[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments
DROP field comment;

ALTER SEARCH INDEX SCHEMA
ON cycling.comments
DROP types.fieldType[@name='TextField'];
// end::drop_text_field[]

// tag::add_dynamic_text_field[]
ALTER SEARCH INDEX SCHEMA
ON cycling.comments
ADD types.fieldType[@class='org.apache.solr.schema.TextField', @name='TextField']
WITH '{"analyzer":{"class":"org.apache.lucene.analysis.standard.StandardAnalyzer"}}';

ALTER SEARCH INDEX SCHEMA
ON cycling.comments
ADD dynamicField[@name='*fieldname', @type='TextField'];
// end::add_dynamic_text_field[]

RELOAD SEARCH INDEX
ON cycling.comments;

REBUILD SEARCH INDEX
ON cycling.comments;
