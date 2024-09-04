#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# function files
source ./functions/display_slogan.sh
source ./functions/show_menu.sh
source ./functions/random_advice.sh
source ./functions/handle_choice.sh
source ./functions/get_tools.sh
source ./functions/get_resources.sh
source ./functions/cowsay_feature.sh
source ./functions/show_github_links.sh
source ./functions/show_ctf_links.sh
source ./functions/mini_ctf.sh

# Main loop
while true; do
    display_slogan
    show_menu
    read -p "$(echo -e ${YELLOW}"Choose an option: "${NC})" choice
    handle_choice $choice
done
