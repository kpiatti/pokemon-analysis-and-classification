use pokemon;
drop procedure load_staged_data;
truncate statistics_to_abilities_xwalk;
drop table statistics_to_abilities_xwalk;
truncate statistics;
call load_staged_data;
select * from statistics;
select * from statistics_to_abilities_xwalk;