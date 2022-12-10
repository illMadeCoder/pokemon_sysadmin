#!/bin/bash

# arg $1 : pokemon_id

if [[ $# -ne 1 ]]
then
    exit 1
fi

curl -s \
     --connect-timeout 5 \
     --max-time 10 \
     --retry 5 \
     --retry-delay 5 \
     --retry-max-time 120 \
     "https://pokeapi.co/api/v2/pokemon/$1"
