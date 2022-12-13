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

day_data_path=$days_data_path/$1.yaml
pokedex_ids=$(yq '.start.import.pokedex.ids' $day_data_path)
pokedex_version=$(yq '.start.import.pokedex.version' $day_data_path)
pokedex_data_path="$pokedex_data_path/$pokedex_version"

for id in $pokedex_ids
do
    pokedex_data_member="$pokedex_data_path/$id.yaml"
    #todo: remove yq dependency
    name=$(yq .name $pokedex_data_member)
    cp $pokedex_data_member "$import_path/$name"
done
