mkdir pokedex && for i in {1..151}; do echo $i | xargs -I{id} curl $(cat pokemon.url) | jq -f 1_pokedex.jq > pokedex/$i; done
