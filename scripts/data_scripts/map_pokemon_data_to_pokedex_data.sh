#!/bin/bash

. "$(dirname "$0")/../env.sh"
#pokemon_data_path
#pokedex_data_path
#pokemon_to_pokedex_path


mkdir -p "$pokedex_data_path"

for pokemon_data_member_path in $pokemon_data_path/*
do
    base_json="$pokemon_data_member_path/base.json"
    species_json="$pokemon_data_member_path/species.json"

    pokedex_entry_json=$(jq -s --from-file $pokemon_to_pokedex_mapper $base_json $species_json)    
    
    id=$(jq -r .id $base_json)
    echo $id	
    
    # must echo quotes to perserve special chars
    echo "$pokedex_entry_json" \
	 > "$pokedex_data_path/$id.json" && \
	echo "$pokedex_data_path/$id.json"
done
 
