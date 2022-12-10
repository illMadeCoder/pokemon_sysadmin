#!/bin/bash

. "$(dirname "$0")/load_config.sh"
#pokemon_data_path
#pokedex_data_path
#pokemon_to_pokedex_path

for mapper in $pokemon_to_pokedex_path/*.jq
do
    mapper_basename=$(basename -s .jq $mapper)
    
    mkdir -p "$pokedex_data_path/$mapper_basename"

    for a_pokemon_data_path in $pokemon_data_path/*
    do
	pokemon_json="$a_pokemon_data_path/pokemon.json"
	species_json="$a_pokemon_data_path/species.json"

	pokedex_entry_json=$(jq -s --from-file $mapper $pokemon_json $species_json)
	pokedex_entry_yaml=$(echo $pokedex_entry_json | yq -P)

	id=$(jq -r .id $pokemon_json)
	echo $id
	
	# must echo quotes to perserve special chars
        echo "$pokedex_entry_yaml" \
	     > "$pokedex_data_path/$mapper_basename/$id.yaml" && \
	    echo "$pokedex_data_path/$mapper_basename/$id.yaml"
    done
done
