#!/bin/bash

# bash script arguments
# arg 1: target directory
# arg 2: pokemon id min or single
# arg 3: pokemon id max

if [ $# -lt 2 ]
then
    echo "requires arg 1 target directory and arg 2, 3 pokemon id range."
    exit 1
fi

# filepaths
data_dir="$(dirname "$0")/.."
scripts_dir="$data_dir/scripts"

for i in $(seq $2 $3)
do
    pokemon=$($scripts_dir/get_pokemon.sh $i)
    pokemon_id_name=$(echo $pokemon | jq -r '"\(.id)_\(.name)"')
    echo $pokemon_id_name
    target_file_name="$pokemon_id_name.json"
    echo "$1/$target_file_name"
    echo $pokemon > "$1/$target_file_name"
done
