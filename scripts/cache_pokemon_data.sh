#!/bin/bash

. "$(dirname "$0")/load_config.sh"
#pokemon_data_path
#http_get_species
#http_get_pokemon


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
    pokemon=$($http_get_pokemon $i)
    species=$($http_get_species $i)

    #validate data integrity
    pokemon_json_id=$(echo "$pokemon" | jq .id)
    species_json_id=$(echo "$species" | jq .id)
    
    if [[ $pokemon_json_id -ne $i ]]
    then
	echo "failed to get $i pokemon"
	echo "one retry"
	sleep 5
	pokemon=$($http_get_pokemon $i)
	pokemon_json_id=$(echo "$pokemon" | jq .id)
	if [[ $pokemon_json_id -ne $i ]]
	then
	    echo "retry failed"
	    exit 1
	fi
    fi

    if [[ $species_json_id -ne $i ]]
    then
	echo "failed to get $i species"
	
	echo "one retry"
	sleep 5
	species=$($http_get_species $i)
	species_json_id=$(echo "$species" | jq .id)
	if [[ $species_json_id -ne $i ]]
	then
	    echo "retry failed"
	    exit 1
	fi	
    fi
        
    # populate cache
    # put in sub command because mew id 151 is seemingly too big at 500k bytes
    $(echo "$pokemon" > "$dir/pokemon.json")
    $(echo "$species" > "$dir/species.json")    
done
