# format-pokemon-csv
# performs the necessary formatting of the pokemon.csv file
# so that it can be loaded into MySQL
# Updated 6/27/2021 DVS

import csv

#pokemon_list = []
""" with open("Data\\pokemon.csv") as csvfile:
    pokemon_reader = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in pokemon_reader:
        pokemon_list.append(row) """

with open("Data\\pokemon.csv", 'rb') as pokemon_file:
    pokemon_data_raw = pokemon_file.read()

pokemon_list = pokemon_data_raw.splitlines()

#for i in range(0,1000,41):
#    print(pokemon_list[i])

dummy = []