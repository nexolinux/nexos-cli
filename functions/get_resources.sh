#!/bin/bash

PASTEBIN_URL="[REDACTED]"

get_resources() {
  while true; do

    pastebin_content=$(curl -s $PASTEBIN_URL)

    if [[ -z "$pastebin_content" ]]; then
      echo -e "${RED}Failed to fetch resources. lease check your network connection or try again later.${NC}"
      read -p "$(echo -e ${YELLOW}"Press [Enter] to retry or Ctrl+C to quit...${NC}")"
      continue
    fi

    read -p "$(echo -e ${YELLOW}"Enter the subject you want resources for (e.g., bash, javascript, linux): "${NC})" subject

    subject=$(echo "$subject" | tr '[:upper:]' '[:lower:]')

    resources=$(echo "$pastebin_content" | awk -v search="$subject" '
            BEGIN { IGNORECASE=1 }
            $0 ~ search && $0 ~ /:\r/ {
                found=1
            }
            found && $0 ~ /:\r/ && $0 !~ search {
              found=0
              exit
            }
            found && $0 !~ /^$/ {
              print
            }
        ')

    if [[ -z "$resources" ]]; then
      echo -e "${RED}No resources found for the subject '${subject}'. Please try again.${NC}"
    else
      echo -e "${GREEN}Resources for ${subject}:${NC}"
      echo "$resources"
    fi

    read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
    break
  done
}
