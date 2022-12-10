# this script path
scripts_path="$(dirname "$0")"

# scripts
http_client="$scripts_path/http_client"
http_get_base="$http_client/base.sh"
http_get_species="$http_client/species.sh"

# mappers
mappers_path="$scripts_path/mappers"
pokemon_to_pokedex_path="$mappers_path/pokemon_to_pokedex"

# project root
root_path="$scripts_path/.."

# data
data_path="$root_path/data"
pokedex_data_path="$data_path/pokedex_data"
pokemon_data_path="$data_path/pokemon_data"
days_path="$data_path/days"


# game
game_path="$root_path/game"
import_dir="$game_path/import"
export_dir="$game_path/export"


