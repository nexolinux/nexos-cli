#!/bin/bash

function mini_ctf {
  while true; do
    paste_url="[REDACTED]"

    challenge_url=$(curl -s "$paste_url")
    if [[ -z "$challenge_url" ]]; then
      echo -e "${RED}Failed to fetch challenge link.Please check your internet connection.${NC}"
      read -p "$(echo -e ${YELLOW}"Press [Enter] to retry or Ctrl+C to quit...${NC}")"
      continue
    fi

    echo -e "${BLUE}Welcome to the Mini CTF Challenge!${RESET}"
    echo -e "${GREEN}Download the challenge file from the following link:${RESET}"
    echo -e "${YELLOW}${challenge_url}${RESET}"
    echo ""
    echo -e "${GREEN}Instructions:${RESET}"
    echo -e "${YELLOW}1.${RESET} Download the challenge file from the provided link."
    echo -e "${YELLOW}2.${RESET} Unzip the file and follow the instructions inside."
    echo -e "${YELLOW}3.${RESET} Solve the challenge and find the flag or answer."
    echo -e "${YELLOW}4.${RESET} Good luck!"
    read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
    break
  done
}
