#!/bin/bash

#1 day

if [ $1 -lt 1 ]
then
    echo "require argument 1 number of day"
    exit 1
fi

# file paths
day_dir="$(dirname "$0")/../days/$1.json"
pokemon_dir="$(dirname "$0")/../pokemon"
game_dir="$(dirname "$0")/../../game"
import_dir="$game_dir/import"
export_dir="$game_dir/export"
jq_dir="$(dirname "$0")/../jqs"

#pokedex jqs
v1_pokedex_jq="$jq_dir/v1_pokedex.jq"

# day jq
pokedex_start=$(jq '.import.pokedex.start' $day_dir)
pokedex_end=$(jq '.import.pokedex.end' $day_dir)
pokedex_version=$(jq '.import.pokedex.version' $day_dir)

# pokemon
pokemon_ids=$(seq $pokedex_start $pokedex_end)

for i in $pokemon_ids
do
    pokemon=$pokemon_dir/$i
    echo $pokemon
    pokemon_name=$(jq -r ".name" $pokemon)
    pokemon_id=$(jq ".id" $pokemon)
    pokemon_id_name="${pokemon_id}_${pokemon_name}"
    pokemon_id_name
    
done
