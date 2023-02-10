SOURCE 'role-internal.cql';

// tag::all[]
LIST ALL PERMISSIONS;
// end::all[]

CAPTURE 'listallpermissionsofsam.results';
// tag::sam[]
LIST ALL PERMISSIONS OF sam;
// end::sam[]
CAPTURE OFF;

CAPTURE 'list_roles_of_coach.results';
// tag::coach[]
LIST ALL PERMISSIONS OF coach;
// end::coach[]
CAPTURE OFF;

// tag::sandy[]
LIST ALL PERMISSIONS OF sandy;
// end::sandy[]

CAPTURE 'listallpermissionsoncyclistname.results';
// tag::resource[]
LIST ALL PERMISSIONS ON cycling.cyclist_name;
// end::resource[]
CAPTURE OFF;

// tag::authorize[]
LIST AUTHORIZE ON KEYSPACE cycling;
// end::authorize[]

// tag::all_roles[]
LIST ROLES;
// end::all_roles[]

// tag::roles[]
LIST ROLES OF coach;
// end::roles[]

// tag::sandy[]
LIST ROLES OF sandy;
// end::sandy[]
