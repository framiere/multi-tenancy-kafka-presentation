#/bin/env bash

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

i3-msg 'split h'

alacritty msg create-window --working-directory $script_dir/multitenant-gateway -e ./run_for.sh francois

alacritty msg create-window --working-directory $script_dir/multitenant-gateway -e ./run_for.sh florent
