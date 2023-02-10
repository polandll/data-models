// tag::alterUserWithPasswd[]
ALTER USER moss WITH PASSWORD 'bestReceiver';
// end::alterUserWithPasswd[]

// tag::alterUserWithHashedPasswd[]
ALTER USER moss WITH HASHED PASSWORD '$2a$10$xsAJKfU.ZUzcuM9REniQoO8jUzBx0B.ChEl5w86TFcOv5ZhARo/uq';
// end::alterUserWithHashedPasswd[]

// tag::alterUserToSU[]
ALTER USER moss SUPERUSER;
// end::alterUserToSU[]
