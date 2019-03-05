drop keyspace if exists contact_app;

create keyspace contact_app WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

use contact_app;


CREATE TYPE if not exists contact_phones_type (
        home text,
        work text
);


create type if not exists email_address_type (
        email_type text, /* private, work, school ... */
        email_address text
);


create table if not exists contact(
   contact_id int  primary key, /* uuid would be better, but hard to type … */
   name varchar,
   contact_phones frozen<contact_phones_type>,
   addresses map<text,text>,
   relative_contact set<int>,
   emails list<frozen<email_address_type>>,
   last_updated_on timestamp
);

create materialized view if not exists contact_by_name as
select * from contact
where contact_id is not null and name is not null
primary key (name, contact_id);

insert into contact(
        contact_id,
        name,
        contact_phones,
        addresses,
        relative_contact,
        emails,
        last_updated_on
) values (
        1,
        'John Doe',
        {home: '1234-3434', work: '34534-435'},
        {'home': '1081 Bp., Futo utca 47-53', 'work': '1034 Bp. Becsi ut 96b'},
        {2},
        [
                {email_type: 'work', email_address: 'jdoe@obuda.com'},
                {email_type: 'private', email_address: 'jdoe@test.com'}
        ],
        dateOf(now())
);


select * from contact_by_name where name = 'John Doe';
        
