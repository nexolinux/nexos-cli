#!/bin/bash

cowsay_feature() {
  if ! command -v cowsay &>/dev/null; then
    echo -e "${YELLOW}cowsay is not installed. Installing...${NC}"
    sudo pacman -S cowsay
  fi

  while true; do
    read -p "$(echo -e ${YELLOW}"Say something (or type 'back' to return to the main menu): "${NC})" cowsay_message

    if [[ "$cowsay_message" == "back" ]]; then
      break
    fi
    if [[ -z "$cowsay_message" ]]; then
      echo -e "${RED}Please type something${NC}"
    else
      cowsay -r "$cowsay_message"
    fi
  done
}
