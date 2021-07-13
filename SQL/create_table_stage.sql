-- Initial staging table for pokemon data received in CSV format
-- Loads data as is and acts as source table for normalized production tables

CREATE TABLE IF NOT EXISTS stage (
	pokemon_id bigint not null auto_increment unique primary key,
    abilities varchar(500),
	against_bug float,
	against_dark float,
	against_dragon float,
	against_electric float,
	against_fairy float,
	against_fight float,
	against_fire float,
	against_flying float,
	against_ghost float,
	against_grass float,
	against_ground float,
	against_ice float,
	against_normal float,
	against_poison float,
	against_psychic float,
	against_rock float,
	against_steel float,
	against_water float,
	attack integer,
	base_egg_steps integer,
	base_happiness integer,
	base_total integer,
	capture_rate integer,
	classification varchar(50),
	defense integer,
	experience_growth integer,
	height_m float,
	hp integer,
	english_name varchar(50),
	percentage_male float,
	pokedex_number integer,
	sp_attack integer,
	sp_defense integer,
	speed integer,
	type1 varchar(50),
	type2 varchar(50),
	weight_kg float,
	generation integer,
	is_legendary boolean
)