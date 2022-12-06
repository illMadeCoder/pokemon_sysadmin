#!/bin/bash

root="$(dirname "$0")../../game/"
dirs="pokedex import export"

rm -r ${root}*

for dir in $dirs
do
    touch ${root}${dir}
done    
