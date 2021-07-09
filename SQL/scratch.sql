use pokemon;

truncate stage;
call load_staged_data;
select * from stage;
select * from statistics;
select * from statistics_to_abilities_xwalk;

select english_name, count(english_name) from statistics
group by english_name
order by count(english_name) desc;

select stats.pokemon_id, stats.english_name, pokemon_id_FK, ability_id_FK, ability_id, ability, abilities as stage_abilities
from statistics stats
join statistics_to_abilities_xwalk xwalk on xwalk.pokemon_id_FK = stats.pokemon_id
join abilities abil on abil.ability_id = xwalk.ability_id_FK
join stage on stage.english_name = stats.english_name
order by pokemon_id;