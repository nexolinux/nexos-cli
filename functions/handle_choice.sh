#!/bin/zsh

handle_choice() {
    case $1 in
    1)
        echo -e "${GREEN}Fetching sessions...${NC}"
        get_tools
        ;;

    2)
        echo -e "${GREEN}Getting you an advice...${NC}"
        random_advice
        ;;
    3)
        echo -e "${GREEN}Fetching resources...${NC}"
        get_resources
        ;;
    4)
        echo -e "${GREEN}Here's something fun: ...${NC}"
        cowsay_feature
        ;;
    5)
        show_github_links
        ;;
    6)
        show_ctf_links
        ;;
    7)
        echo -e "${GREEN}Launching mini CTF...${NC}"
        mini_ctf
        ;;
    0)
        echo -e "${RED}Exiting...${NC}"
        exit 0
        ;;
    *) echo -e "${RED}Invalid option. Please try again.${NC}" ;;
    esac
}
