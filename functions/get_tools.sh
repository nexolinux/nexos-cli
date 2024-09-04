#!/bin/bash

get_tools() {
  while true; do
    PASTEBIN_URL="[REDACTED]"
    pattern='^[0-9]+[[:space:]]*-[[:space:]]*.*[[:space:]]*:.*$'

    pastebin_content=$(curl -s $PASTEBIN_URL)

    if [[ -z "$pastebin_content" ]]; then
      echo -e "${RED}Failed to fetch tools list. Please check your internet connection.${NC}"
      read -p "$(echo -e ${YELLOW}"Press [Enter] to retry or Ctrl+C to quit...${NC}")"
      continue
    fi

    IFS=$'\n' read -r -d '' -a sessions < <(echo "$pastebin_content" | grep -oE "$pattern" || true)

    echo -e "${YELLOW}Available sessions:${NC}"
    for i in "${!sessions[@]}"; do
      session=$(echo "${sessions[$i]}" | sed -E 's/^[0-9]+\s*-\s*//')
      echo -e "${YELLOW} $((i + 1)). $session ${NC}"
    done

    read -p "$(echo -e ${YELLOW}"Choose a session number: "${NC})" session_choice

    if [[ $session_choice -gt 0 && $session_choice -le ${#sessions[@]} ]]; then
      selected_session="${sessions[$((session_choice - 1))]}"
      cleaned_selected_session=$(echo "${sessions[$((session_choice - 1))]}" | sed -E 's/^[0-9]+\s*-\s*//')

      tools=$(echo "$pastebin_content" | awk -v session="$selected_session" '$0 == session {flag=1; next} $0 ~ /^[0-9]+[[:space:]]*-[[:space:]]*.*[[:space:]]*:.*$/ {flag=0} flag')
      printtools=$tools
      tools=$(echo "$tools" | tr '\n' ' ' | sed 's/[^a-zA-Z0-9_-]/ /g' | tr 'A-Z' 'a-z')

      echo -e "${GREEN}Tools used in ${cleaned_selected_session}${NC}"
      echo -e "$printtools"

      read -p "$(echo -e ${YELLOW}"Do you want to install these tools using pacman? [y/N]: "${NC})" install_choice

      if [[ "$install_choice" =~ ^[Yy]$ ]]; then
        printf "$tools" | xargs sudo pacman -Sy --needed --noconfirm
      else
        echo -e "${YELLOW}Installation skipped.${NC}"
      fi
    else
      echo -e "${RED}Invalid session number. Please try again.${NC}"
    fi

    read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
    break
  done
}
