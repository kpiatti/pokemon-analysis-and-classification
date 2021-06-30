use pokemon;
load data local infile 'C:\\Users\\dvschwab\\Documents\\Programming\\Python3\\pokemon-analysis-and-classification\\Data\\pokemon-filtered.dat'
into table pokemon_raw_stage
	fields terminated by '|';