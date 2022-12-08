#!/bin/bash

# arguements
# arg 1: day id

if [ $1 -lt 1 ]
then
    echo "require arg 1 number of day"
    exit 1
fi

# file paths
. load_config

#pokedex jqs
v1_pokedex_jq="$pokedex_jqs_path/v1_pokedex.jq"

# day jq
pokedex_start=$(jq '.import.pokedex.start' $days_path)
pokedex_end=$(jq '.import.pokedex.end' $days_path)
pokedex_version=$(jq '.import.pokedex.version' $days_path)

# pokemon
pokemon_ids=$(seq $pokedex_start $pokedex_end)

for i in $pokemon_ids
do
    pokemon=$pokemon_cache_path/$i
    echo $pokemon
    pokemon_name=$(jq -r ".name" $pokemon)
    pokemon_id=$(jq ".id" $pokemon)
    pokemon_id_name="${pokemon_id}_${pokemon_name}"
    pokemon_id_name
    
done
