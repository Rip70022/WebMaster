#!/bin/bash

# Check for Python 3
if ! command -v python3 &> /dev/null
then
    echo -e "\033[0;31mPython 3 is not installed. Installing...\033[0m"
    sudo apt-get install python3 -y
fi

# Check for requests module
if ! python3 -c "import requests" &> /dev/null
then
    echo -e "\033[0;31mRequests module is not installed. Installing...\033[0m"
    pip3 install requests
fi

# Define colors for the banner and prompts
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Print the banner
echo -e "${GREEN}██╗    ██╗███████╗██████╗ ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗"
echo -e "██║    ██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗"
echo -e "██║ █╗ ██║█████╗  ██████╔╝██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝"
echo -e "██║███╗██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗"
echo -e "╚███╔███╔╝███████╗██████╔╝██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║"
echo -e " ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
echo -e "                ${YELLOW}WebMaster by Shadow_Sadist${RESET}"

# Start the main loop
while true; do
    # Read URL input
    read -p "$(echo -e "${BLUE}Enter the URL of the webpage (or type 'exit' to quit):${RESET}") " url
    if [[ "$url" == "exit" ]]; then
        echo -e "${YELLOW}Exiting script. Goodbye!${RESET}"
        exit 0
    fi

    # Prompt for filename
    read -p "$(echo -e "${BLUE}Enter the filename to save the HTML (default: page.html):${RESET}") " filename
    filename=${filename:-page.html}

    # Call the Python script to fetch the HTML
    python3 -c "
import requests
try:
    response = requests.get('$url')
    response.raise_for_status()  # Raise an error for bad responses
    with open('$filename', 'w') as f:
        f.write(response.text)
    print('HTML content saved to', '$filename')
except Exception as e:
    print('Failed to fetch the URL:', e)
"
done
