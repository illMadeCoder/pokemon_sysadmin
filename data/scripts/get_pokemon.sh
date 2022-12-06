#!/bin/bash

#1 target directory
#2 pokemon id min or single
#3 pokemon id max

pokemon_get="$(dirname "$0")/../urls/pokemon.url"

if [ $# -lt 2 ]
then
    echo "requires arg 1 target directory and arg 2 3 pokemon ids"
    exit 1
fi    

for i in $(seq $2 $3);
do    
    echo $i | xargs -I{id} curl $(cat $pokemon_get) > $1/$i;
done
