#!/bin/bash

. "$(dirname "$0")/../env.sh"
#pokemon_data_path
#pokemon_to_pokedex_path
#pokemon_to_pokedex_mapper

mkdir -p "$pokedex_data_path"
for pokemon_data_member_path in $pokemon_data_path/*
do
    id=$(basename $pokemon_data_member_path)
    target="$pokedex_data_path/$id"
    mkdir -p $target
    ./map_pokemon_data_to_pokedex_data.sh $pokemon_data_member_path $pokemon_to_pokedex_mapper $target
    cat "$pokemon_data_member_path/sprite.png" | ./graphics/pokedex_icon.sh > "$target/icon"
    cat "$pokemon_data_member_path/sprite.png" | ./graphics/pokedex_portrait.sh > "$target/portrait"
    echo $pokemon_data_member_path
done
