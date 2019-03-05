DROP KEYSPACE IF EXISTS mycom;

CREATE KEYSPACE mycom WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE mycom;

CREATE TYPE if not exists user_address_type (
	country text,
	state text,
	city text,
	street text
);

CREATE TYPE if not exists user_full_name_type (
	title text,
	first_name text,
	middle_name text,
	last_name text
);

CREATE table IF NOT EXISTS user (
	user_id uuid primary key,
	username text,
	email text,
	password text,	
	address FROZEN<user_address_type>,
	full_name frozen<user_full_name_type>
);

create materialized view IF NOT EXISTS user_login_by_email as
select user_id, username, password from user
where email is not null and user_id is not null
primary key((email), user_id);

create materialized view IF NOT EXISTS user_login_by_username as
select user_id, username, password from user
where username is not null and user_id is not null
primary key((username), user_id);


create type if not exists sale_product_type(
	product_id uuid,
	short_description text,
	weight int,
	unit text,
	unit_price decimal
);

create table if not exists sale(
	sale_id timeuuid primary key,
	user_id uuid,
	products  list<frozen<sale_product_type>>,
	sale_date timestamp,
	shipment_cost decimal,
	total_amount decimal
);


create type if not exists sale_product_type(
	product_id uuid,
	short_description text,
	weight int,
	unit text,
	unit_price decimal
);

create table if not exists sale(
	sale_id timeuuid primary key,
	user_id uuid,
	products  list<frozen<sale_product_type>>,
	sale_date timestamp,
	shipment_cost decimal,
	total_amount decimal
);

create materialized view IF NOT EXISTS sales_by_user as
select * from sale
where sale_id is not null and user_id is not null
primary key((user_id), sale_id) with clustering order by (sale_id desc);
