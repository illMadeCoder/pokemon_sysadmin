#!/bin/bash

# bash script arguements
# arg 1 : pokemon_id

if [ $# -ne 1 ]
then
    echo "requires argument pokemon id"
    exit 1
fi

pokemon_id=$1

# paths
data_dir="$(dirname "$0")/.."
endpoints_dir="$data_dir/endpoints"
pokedex_jq_dir="$data_dir/pokedex_jqs"

# endpoints
pokemon_url="$(cat $endpoints_dir/pokemon.url)"
pokemon_species_url="$(cat $endpoints_dir/pokemon_species.url)"

# pokedex jq
base_pokedex_jq="$pokedex_jq_dir/base_pokedex.jq"    

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


