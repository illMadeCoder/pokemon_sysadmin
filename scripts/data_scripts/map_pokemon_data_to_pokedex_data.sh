#!/bin/bash
# $1 : source
# $2 : mapper
# $3 : destination

source=$1
mapper=$2
target=$3

id=$(basename $source)
base_json="$source/base.json"
species_json="$source/species.json"

pokedex_entry_json=$(jq -s --from-file $mapper $base_json $species_json)

#must echo quotes to perserve special chars
echo "$pokedex_entry_json" > "$target/$id.json"
