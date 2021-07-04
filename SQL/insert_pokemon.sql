select abilities into @ability_array from pokemon_raw_stage where pokemon_id = 1;
select 1, ability_id from abilities where instr(@ability_array, ability);
