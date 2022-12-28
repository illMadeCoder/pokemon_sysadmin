#!/bin/bash

. "$(dirname "$0")/../env.sh"
#pokemon_data_path
#pokemon_species_request
#pokemon_base_request


# $1 optional destination
# $2 optional pokemon id start
# $3 optional pokemon id end

if [[ $# -gt 0 ]]
then
    destination=$1
else
    destination=$pokemon_data_path
fi

if [ ! -d $1 ]
then
    echo "invalid destination directory $1"
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

echo "destination: $destination"
echo "id_start: $id_start"
echo "id_end: $id_end"

for i in $(seq $id_start $id_end)
do
    echo "$i / $id_end"
    
    # prepare dir
    dir="$destination/$i"
    mkdir -p $dir
    
    # get data to cache
    base=$($pokemon_base_request $i)
    species=$($pokemon_species_request $i)

    #validate data integrity
    base_json_id=$(echo "$base" | jq .id)
    species_json_id=$(echo "$species" | jq .id)    

    #get sprite
    sprite_request=$(echo $base | jq -r .sprites.front_default)
    
    # populate cache
    # put in sub command because mew id 151 is seemingly too big at 500k bytes
    $(echo "$base" > "$dir/base.json")
    $(echo "$species" > "$dir/species.json")
    # defective for mew 151, must perform manually for now
    wget $sprite_request -O "$dir/sprite.png"
done
