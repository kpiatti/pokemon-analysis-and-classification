-- Procedure to load pokemon data from the pokemon staging table to the statistics table.
-- Also creates the xwalk entries to map each pokemon to its abilities in the abilities table
-- Relies on pokemon name being unique to insert the correct row from staging
-- DVS 07/6/2021

use pokemon;
delimiter //

create procedure load_staged_data()
begin

	declare new_pokemon_id bigint;
    declare pokemon_name varchar(50);
    declare pokemon_abilities varchar(500);
    declare done int default false;

	-- Cursor selects pokemon by name and retrieves its abilities from stage
    -- Loop reads cursor until empty
    -- Pokemon name is used to restrict insert to that pokemon,
    -- and auto_increment ID is mapped to xwalk with ability ids

	declare stage_cursor cursor for select english_name, abilities from pokemon_raw_stage;
    declare continue handler for not found set done = true;
    
    open stage_cursor;
    
    read_loop: loop
		fetch stage_cursor into pokemon_name, pokemon_abilities;
		if done then 
			leave read_loop;
		end if;
        
        -- Insert next pokemon into statistics table
        -- WHERE clause of SELECT limits insert to just that one pokemon
        -- (which is why english_name MUST be unique)
        
		insert into statistics (english_name, classification, primary_type, hit_points, attack, defense, speed, sp_attack, sp_defense,
		against_bug, against_dark, against_dragon, against_electric, against_fairy, against_fight, against_fire, against_flying, against_ghost,
		against_grass, against_ground, against_ice, against_normal, against_poison, against_psychic, against_rock, against_steel, against_water,
		base_egg_steps, base_happiness, base_total, capture_rate, experience_growth, height_m, weight_kg, percentage_male,
		pokedex_number, generation, is_legendary)
		select english_name, classification, type1, hp, attack, defense, speed, sp_attack, sp_defense, against_bug, against_dark, against_dragon,
		against_electric, against_fairy, against_fight, against_fire, against_flying, against_ghost, against_grass, against_ground, against_ice,
		against_normal, against_poison, against_psychic, against_rock, against_steel, against_water, base_egg_steps, base_happiness, base_total,
		capture_rate, experience_growth, height_m, weight_kg, percentage_male, pokedex_number, generation, is_legendary
		from pokemon_raw_stage
		where english_name = pokemon_name;
    
		-- Get ID of inserted record
        -- Use INSTR() to find each ability in the abilities array from stage,
        -- then insert the pokemon ID and ability_ids into the xwalk.
    
		set new_pokemon_id = last_insert_id();
	
		insert into statistics_to_abilities_xwalk (pokemon_id_FK, ability_id_FK)
		select new_pokemon_id, ability_id from abilities where instr(pokemon_abilities, ability);

	end loop;
    
	close stage_cursor;
    
end;