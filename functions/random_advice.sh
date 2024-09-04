#!/bin/bash

random_advice() {
    while true; do
        pastebin_url="[REDACTED]"

        response=$(curl -s "$pastebin_url")

        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to retrieve advices. Please check your network connection or try again later.${NC}"
            read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
            break
        fi

        IFS=$'\n' read -r -d '' -a security_advice <<<"$response"

        advice_index=$((RANDOM % ${#security_advice[@]}))
        echo -e "${GREEN}${security_advice[$advice_index]}${NC}"

        read -p "$(echo -e ${YELLOW}"Press [Enter] to go back to the main menu...${NC}")"
        break
    done
}
