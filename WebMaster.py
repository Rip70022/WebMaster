#!/bin/bash

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Colored banner with additional text
echo -e "${CYAN}"
cat << "EOF"
   ██╗    ██╗███████╗██████╗ ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ 
   ██║    ██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗
   ██║ █╗ ██║█████╗  ██████╔╝██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝
   ██║███╗██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗
   ╚███╔███╔╝███████╗██████╔╝██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║
    ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝                                                                              
EOF
echo -e "${BLUE}     WebMaster by Shadow_Sadist${RESET}"
echo

# Custom prompt with colors
PS1="${RED}┌──${GREEN}[WebMaster]${RESET}\n${BLUE}└─⌈${CYAN}WC${BLUE}⌋ ➤ ${RESET}"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}Python3 is not installed. Installing...${RESET}"
    sudo apt update && sudo apt install -y python3
fi

# Check if the requests module is installed
if ! python3 -c "import requests" &> /dev/null; then
    echo -e "${YELLOW}The 'requests' module is not installed. Installing...${RESET}"
    python3 -m pip install requests
fi

# Prompt for URL and allow exit with 'exit'
while true; do
    echo -ne "${GREEN}Enter the URL of the webpage (or type 'exit' to quit):${RESET} "
    read url
    if [[ "$url" == "exit" ]]; then
        echo -e "${YELLOW}Exiting script. Goodbye!${RESET}"
        exit 0
    fi

    # Prompt for filename
    echo -ne "${GREEN}Enter the filename to save the HTML (default: page.html):${RESET} "
    read filename
    filename=${filename:-page.html}  # Use "page.html" as default if no name is provided

    python3 - <<EOF
import requests

def copy_html(url, filename):
    try:
        response = requests.get(url)
        response.raise_for_status()
        
        with open(filename, "w", encoding="utf-8") as file:
            file.write(response.text)
        
        print("${GREEN}HTML successfully copied to '${filename}'${RESET}")
    
    except requests.exceptions.RequestException as e:
        print("${RED}Error retrieving the page:${RESET}", e)

copy_html("$url", "$filename")
EOF
done
