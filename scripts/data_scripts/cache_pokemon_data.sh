#!/bin/bash

. "$(dirname "$0")/../env.sh"
#pokemon_data_path
#pokemon_species_request
#pokemon_base_request


# $1 optional target
# $2 optional pokemon id start
# $3 optional pokemon id end

if [[ $# -gt 0 ]]
then
    target=$1
else
    target=$pokemon_data_path
fi

if [ ! -d $1 ]
then
    echo "invalid target directory $1"
    exit 1
fi

if [[ $# -gt 1 ]]
then
    id_start=$2
else
    id_start=1
fi

if [[ $# -eq 2 ]]
then
    id_end=$2
elif [[ $# -gt 2 ]]
then
    id_end=$3
else
    id_end=151
fi

echo "target: $target"
echo "id_start: $id_start"
echo "id_end: $id_end"

for i in $(seq $id_start $id_end)
do
    echo "$i / $id_end"
    
    # prepare dir
    dir="$target/$i"
    mkdir -p $dir
    
    # get data to cache
    base=$($pokemon_base_request $i)
    species=$($pokemon_species_request $i)

    #validate data integrity
    base_json_id=$(echo "$base" | jq .id)
    species_json_id=$(echo "$species" | jq .id)    

    # get sprite
    sprite_ascii=$(echo $base | jq '.sprites.front_default' | xargs curl | chafa --symbols ascii --scale 4)
    
    # populate cache
    # put in sub command because mew id 151 is seemingly too big at 500k bytes
    $(echo "$base" > "$dir/base.json")
    $(echo "$species" > "$dir/species.json")
    $(echo "$sprite_ascii" > "$dir/sprite.ascii")
done
