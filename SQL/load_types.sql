use pokemon;
truncate species;
load data local infile 'C:\\Users\\dvschwab\\Documents\\Programming\\Python3\\pokemon-analysis-and-classification\\Data\\pokemon_types.dat'
into table species
(species_type);