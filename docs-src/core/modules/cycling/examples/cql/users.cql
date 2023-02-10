// tag::createUserWithPasswd[]
CREATE USER spillman WITH PASSWORD 'Niner27';
// end::createUserWithPasswd[]

// tag::createUserWithHashedPasswd[]
CREATE USER jane 
  WITH HASHED PASSWORD = '$2a$10$xsAJKfU.ZUzcuM9REniQoO8jUzBx0B.ChEl5w86TFcOv5ZhARo/uq';
// end::createUserWithHashedPasswd[]

// tag::createUserNoPasswd[]
CREATE USER tony NOSUPERUSER;
// end::createUserNoPasswd[]

// tag::createUserSU[]
CREATE USER akers WITH PASSWORD 'Niner2' SUPERUSER;
// end::createUserSU[]

// tag::createUserNoSU[]
CREATE USER akers WITH PASSWORD 'Niner75' NOSUPERUSER;
// end::createUserNoSU[]

// tag::createUserIfNotExists[]
CREATE USER bonnie IF NOT EXISTS WITH PASSWORD 'heydo';
// end::createUserIfNotExists[]
