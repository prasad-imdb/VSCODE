-- What it can't do.

create or replace role myrole;

create or replace role myrole2;

grant role myrole to role myrole2;

create or replace user  testuser PASSWORD='abc123';

-- What it can do.

create or replace database mynewdb;

create or replace warehouse mywarehouse;


