#!/bin/bash

# load config
. load_config.sh

# bash script arguments
# arg 1: target directory
# arg 2: pokemon id min or single
# arg 3: pokemon id max

if [ $# -lt 2 ]
then
    echo "requires arg 1 target directory and arg 2, 3 pokemon id range."
    exit 1
fi

for i in $(seq $2 $3)
do
    pokemon=$($scripts_path/get_pokemon.sh $i)
    pokemon_id_name=$(echo $pokemon | jq -r '"\(.id)_\(.name)"')
    target_file_name="$pokemon_id_name.json"
    echo $pokemon > "$1/$target_file_name"
done
