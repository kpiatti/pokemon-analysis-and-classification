
import csv

# Import *ability* field and generate a list
# of abilities without extraneous chars

ability_list = []
with open('Data\\pokemon-filtered.dat', 'rt') as f:
    csv_reader = csv.reader(f, delimiter = '|')

    # Process each file row
    for row in csv_reader:
        # Get the *ability* field and remove brackets
        row_strip = row[0].strip("[]")

        # Split the field into single-string elements
        for ability in row_strip.split(","):
            # Remove unneeded chars and append
            ability_strip = ability.strip(" '")
            ability_list.append(ability_strip)

# Make a new list with each unique ability
# list(set(*)) removes dups (set) and returns a list
unique_ability_list = list(set(ability_list))
unique_ability_list.sort()

# Write abilities to disk


dummy = []
