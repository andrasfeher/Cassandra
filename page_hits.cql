USE mycom;

create table if not exists page_hit_counter_by_url_and_date(
    url text,
    capture_date text,
    hit_counter counter,
    primary key((url,capture_date)) 	
);


insert into page_hit_counter_by_url_and_date ( url, capture_date, capture_time, source_ip)
values ( 'https://msdf.com/index', '2018-04-03', '13:30:54', 	'127.0.0.1');

insert into page_hit_counter_by_url_and_date (url, capture_date, capture_time, source_ip)
values ( 'https://mycom.com/index', '2018-04-04', '13:30:54', '127.0.0.1');

insert into page_hit_counter_by_url_and_date (url, capture_date, capture_time, source_ip)
values ( 'https://mycom.com/index', '2018-04-04', '14:30:54', '127.0.0.1');

insert into page_hit_counter_by_url_and_date (url, capture_date, capture_time, source_ip)
values ( 'https://mycom.com/index', '2018-04-05','14:30:54', '127.0.0.1');

select * from page_hit_counter_by_url_and_date 
where url = 'https://mycom.com/index' 
and capture_date = '2018-04-04'
and capture_time > '14:00:00' and capture_time < '15:00:00';


update page_hit_counter_by_url_and_date
set 
    hit_counter = hit_counter + 1
where 
    url = 'https://mycom.com/index' and
    capture_date = '2018-04-04';

select * from page_hit_counter_by_url_and_date;
