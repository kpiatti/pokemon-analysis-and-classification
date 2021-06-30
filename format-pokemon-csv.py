# format-pokemon-csv
# Formats the pokemon.csv file so that it can be loaded into MySQL
# Updated 6/30/2021 DVS

# Open the file as bytes.
# We'll need to remove the Japanese kanji
# for it to load in MySQL

with open("Data\\pokemon.csv", 'rb') as pokemon_file:
    pokemon_data_raw = pokemon_file.read()

# Split the raw data at newlines into a list of rows
# Then remove the header

pokemon_list = pokemon_data_raw.splitlines()
del pokemon_list[0]

# Process each row of pokemon data and delete the problematic text

pokemon_filtered = []
for item in pokemon_list:

    # Split on end bracket to separate abilities from the rest
    pokemon_row = item.split(b']"')

    # Append abilities to list and add ] back in
    pokemon_abilities = pokemon_row[0].decode() + ']"'

    # Split the remaining stats on comma,
    # then delete element 29 (the Japanese name)

    pokemon_stats = pokemon_row[1].decode().split(',')
    del pokemon_stats[29]

    # Join the abilities and stats into a single list
    # Use pipe delim so stray commas don't lead to issues

    pokemon_filtered.append(pokemon_abilities + '| '.join(pokemon_stats))

# Write the file back to disk

with open("Data\\pokemon-filtered.dat", "wt") as pokemon_file_filtered:
    for row in pokemon_filtered:
        pokemon_file_filtered.write(row + '\n')