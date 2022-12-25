# load this file in to get major project scripts paths
# this is hacky, only supports exactly one level deep
# and does not allow scripts at the scripts root level

# this script path
scripts_path="$(dirname "$0")/.."

# scripts
data_scripts_path="$scripts_path/data_scripts"
http_client="$data_scripts_path/http_client"
pokemon_base_request="$http_client/pokemon_base_request.sh"
pokemon_species_request="$http_client/pokemon_species_request.sh"

# mappers
mappers_path="$data_scripts_path/mappers"
pokemon_to_pokedex_mapper="$mappers_path/pokemon_to_pokedex.jq"

# project root
root_path="$scripts_path/.."

# data
data_path="$root_path/data"
pokedex_data_path="$data_path/pokedex_data"
pokemon_data_path="$data_path/pokemon_data"
days_data_path="$data_path/days_data"
pokedex_version_mapper="$data_path/pokedex_version_mappers"

# game
game_path="$root_path/game"
import_path="$game_path/import"
export_path="$game_path/export"
