# remove-kanji
# removes kanji characters from the pokemon data file
# so it will load into MySQL

input_file = "Data\\pokemon.csv"
output_file = "Data\\pokemon-filtered.dat"

def retrieve_rows(input, skip_header = True):
    row_list = input.splitlines()
    if skip_header:
        del row_list[0]
    return row_list

def remove_kanji(input):

    input_filtered = []
    for item in input:

        # Split on end bracket to separate abilities from the rest
        item_row = item.split(b']"')

        # Append abilities to list and add ] back in
        # Split the remaining stats on comma,
        # then delete element 29 (the Japanese name)

        abilities = item_row[0].decode() + ']"'
        stats = item_row[1].decode().split(',')
        del stats[29]

        # Join the abilities and stats into a single list
        # Use pipe delim so stray commas don't lead to issues

        input_filtered.append(abilities + '| '.join(stats))

    return input_filtered

if __name__ == "__main__":

    # Open the file as bytes.

    with open(input_file, 'rb') as pokemon_file:
        pokemon_data_raw = pokemon_file.read()

    # Remove kanjii

    rows = retrieve_rows(pokemon_data_raw)
    filtered_rows = remove_kanji(rows)

    # Write the file back to disk

    with open(output_file, "wt") as pokemon_file_filtered:
        for row in filtered_rows[0:-1]:
            pokemon_file_filtered.write(row + '\n')
        pokemon_file_filtered.write(filtered_rows[-1])