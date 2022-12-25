#!/bin/bash

# file paths
. "$(dirname "$0")/../env.sh"

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
pokedex_version_mapper="$pokedex_version_mapper/$pokedex_version.jq"

for id in $pokedex_ids
do
    pokedex_data_member="$pokedex_data_path/$id.json"
    name=$(yq .name $pokedex_data_member)
    echo "$(cat $pokedex_data_member | jq --from-file $pokedex_version_mapper | yq -P)" > "$import_path/$name"
done
