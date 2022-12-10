#!/bin/bash

# file paths
. "$(dirname "$0")/../load_config.sh"

# arguements
# arg 1: day id

if [ $1 -lt 1 ]
then
    echo "require arg 1 number of day"
    exit 1
fi

# day jq
# pokedex_start=$(jq '.import.pokedex.start' $days_path)
# pokedex_end=$(jq '.import.pokedex.end' $days_path)
day_data_path=$days_data_path/$1.yaml
pokedex_ids=$(yq '.import.pokedex.ids' $day_data_path)
pokedex_version=$(yq '.import.pokedex.version' $day_data_path)
pokedex_data_path="$pokedex_data_path/$pokedex_version"

for id in $pokedex_ids
do
    pokedex_data_member="$pokedex_data_path/$id.yaml"
    echo $pokedex_data_member
    echo "$import_path/$id.yaml"
    cp $pokedex_data_member "$import_path/$id.yaml"
done

# pokemon
# pokemon_ids=$(seq $pokedex_start $pokedex_end)

# for i in $pokemon_ids
# do
#     pokemon=$pokemon_cache_path/$i
#     echo $pokemon
#     pokemon_name=$(jq -r ".name" $pokemon)
#     pokemon_id=$(jq ".id" $pokemon)
#     pokemon_id_name="${pokemon_id}_${pokemon_name}"
#     pokemon_id_name
    
# done
