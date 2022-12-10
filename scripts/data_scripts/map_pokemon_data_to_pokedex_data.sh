#!/bin/bash

. "$(dirname "$0")/../load_config.sh"
#pokemon_data_path
#pokedex_data_path
#pokemon_to_pokedex_path

for mapper in $pokemon_to_pokedex_path/*.jq
do
    mapper_basename=$(basename -s .jq $mapper)
    
    mkdir -p "$pokedex_data_path/$mapper_basename"

    for pokemon_data_member_path in $pokemon_data_path/*
    do
	base_json="$pokemon_data_member_path/base.json"
	species_json="$pokemon_data_member_path/species.json"

	pokedex_entry_yaml=$(jq -s --from-file $mapper $base_json $species_json | yq -P)

	id=$(yq -r .id $base_json)
	echo $id	
	
	# must echo quotes to perserve special chars
        echo "$pokedex_entry_yaml" \
	     > "$pokedex_data_path/$mapper_basename/$id.yaml" && \
	    echo "$pokedex_data_path/$mapper_basename/$id.yaml"
    done
done
