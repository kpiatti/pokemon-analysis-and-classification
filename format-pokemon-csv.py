# format-pokemon-csv
# performs the necessary formatting of the pokemon.csv file
# so that it can be loaded into MySQL
# Updated 6/28/2021 DVS

import csv

# Open the file as bytes.
# We'll need to remove that Japanese kanji
# for it to load in MySQL

with open("Data\\pokemon.csv", 'rb') as pokemon_file:
    pokemon_data_raw = pokemon_file.read()

# Split the raw data at newlines into a list of rows
# Then remove the header

pokemon_list = pokemon_data_raw.splitlines()
del pokemon_list[0]

# Make two lists: one for the abilities, and
# one for the remaining stats.
# Done this way because the abilities have commas in them
# and are of variable length, so split(b',') won't work directly

pokemon_abilities = []
pokemon_stats = []
pokemon_filtered = []

# Process each row of pokemon data, ending with one list
# of abilities coded as an array
# and one list of everything else

for item in pokemon_list:

    # Split on end bracket to separate abilities from the rest
    pokemon_row = item.split(b']"')

    # Append abilities to list and add ] back in
    # pokemon_abilities.append(pokemon_row[0] + b']"')
    pokemon_abilities = pokemon_row[0].decode() + ']"'

    # Now, split the remaining stats on comma,
    # then delete element 29 (the Japanese name)
    # which is the unreadable part

    #pokemon_stats_raw = pokemon_row[1].split(b',')
    #del pokemon_stats_raw[29]
    #pokemon_stats.append(pokemon_stats_raw)

    #pokemon_stats = pokemon_row[1].split(b',')

    pokemon_stats = pokemon_row[1].decode().split(',')
    del pokemon_stats[29]

    # Join the abilities and stats into a single list

    pokemon_filtered.append(pokemon_abilities + ', '.join(pokemon_stats))

# Dummy statement so debugger stays active

dummy = []