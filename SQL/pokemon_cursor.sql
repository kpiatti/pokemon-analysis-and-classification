use pokemon;
delimiter //
create procedure load_staged_data()
begin

	declare new_pokemon_id bigint;
    declare english_name varchar(50);
    declare abilities varchar(500);

	declare stage_cursor cursor for select english_name, abilities from pokemon_raw_stage;
    
    open stage_cursor;
    
    fetch stage_cursor into english_name, abilities;
    insert into statistics values (english_name);
    set new_pokemon_id = last_insert_id();
	
    insert into statistics_to_abilities_xwalk (pokemon_id_FK, ability_id_FK)
    select new_pokemon_id, ability_id from abilities where instr(@abilities, ability);

	close stage_cursor;
    
end;