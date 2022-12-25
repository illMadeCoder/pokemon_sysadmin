#!/bin/bash

# file paths
. "$(dirname "$0")/../env.sh"

dirs="pokedex import export"

rm -r $game_path/*

for dir in $dirs
do
    mkdir $game_path/$dir
done    
