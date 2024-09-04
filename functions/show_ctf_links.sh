#!/bin/bash

show_ctf_links() {
  echo -e "${GREEN}Fetching current and upcoming CTFs...${NC}"

  # Fetch current CTFs from CTFtime API
  ctf_data=$(curl -s https://ctftime.org/api/v1/events/?limit=6)

  if [[ -z "$ctf_data" ]]; then
    echo -e "${RED}Failed to fetch CTF events. Please check your internet connection.${NC}"
    return
  fi

  echo -e "${GREEN}**********************************${NC}"
  echo -e "${YELLOW}Current and Upcoming CTF Events:${NC}"
  echo -e "${GREEN}**********************************${NC}"

  # Parse  the CTFs using jq
  echo "$ctf_data" | jq -c '.[]' | while IFS= read -r event; do
    title=$(echo "$event" | jq -r '.title')
    start=$(echo "$event" | jq -r '.start')
    finish=$(echo "$event" | jq -r '.finish')
    url=$(echo "$event" | jq -r '.url')

    # Display the results with colors
    echo -e "${GREEN}${title}${NC}"
    echo -e "   Date: ${YELLOW}${start} - ${finish}${NC}"
    echo -e "   Link: ${BLUE}${url}${NC}"
    echo
  done

  echo -e "${GREEN}**********************************${NC}"
  echo -e "${YELLOW}Visit ${BLUE}https://ctftime.org${YELLOW} for more CTFs!${NC}"

  read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
}
