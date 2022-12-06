#!/bin/bash

#1 day

if [ $1 -lt 1 ]
then
    echo "require argument 1 number of day"
    exit 1
fi

# file paths
day="$(dirname "$0")/../days/$1.json"
pokemon="$(dirname "$0")/../pokemon"
game="$(dirname "$0")/../../game"
import="$game/import"
export="$game/export"

# day jq
pokedex_start=$(jq '.import.pokedex.start' $day)
pokedex_end=$(jq '.import.pokedex.end' $day)
pokedex_version=$(jq '.import.pokedex.version' $day)

# pokemon
pokemon_ids=$(seq $pokedex_start $pokedex_end)

for i in $pokemon_ids
do
    pokemon=$pokemon/$i
    pokemon_name=jq ".name" $pokemon
    pokemon_id=jq ".id" $pokemon
    pokemon_id_name=
    > $import/$i
done
