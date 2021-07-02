CREATE TABLE IF NOT EXISTS pokemon_abilities_stage (
	ability_id bigint not null auto_increment unique primary key,
	abilities JSON
)
