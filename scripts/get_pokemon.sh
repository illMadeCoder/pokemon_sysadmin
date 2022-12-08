#!/bin/bash

# load config
. load_config.sh

# bash script arguements
# arg 1 : pokemon_id

if [ $# -ne 1 ]
then
    echo "requires argument pokemon id"
    exit 1
fi

pokemon_id=$1

# endpoints
pokemon_url="$(cat $endpoints_path/pokemon.url)"
pokemon_species_url="$(cat $endpoints_path/pokemon_species.url)"

# pokedex jq
base_pokedex_jq="$pokedex_jqs_path/base_pokedex.jq"    

# retrieve data
pokemon_get_response=$(echo $pokemon_id | xargs -I{id} curl $pokemon_url)
pokemon_species_get_response=$(echo $pokemon_id | xargs -I{id} curl $pokemon_species_url)

# extract filename variables 
pokemon_name=$(echo $pokemon_get_response | jq -r ".name")
pokemon_id=$(echo $pokemon_get_response | jq ".id")
pokemon_id_name="${pokemon_id}_${pokemon_name}"

# format body
echo "[$pokemon_get_response, $pokemon_species_get_response]" \
    | jq -f $base_pokedex_jq


