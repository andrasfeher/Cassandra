use contact_app;

create table if not exists contact_counter(
	count_id text primary key, /* needs pk */
	cnt counter
);

update contact_counter 
set cnt = cnt + 1 
where count_id = 'contact_number';

select cnt from contact_counter where count_id = 'contact_number';
