#!/bin/bash

# Check for Python 3
if ! command -v python3 &> /dev/null
then
    echo "Python 3 is not installed. Installing..."
    sudo apt-get install python3 -y
fi

# Check for requests module
if ! python3 -c "import requests" &> /dev/null
then
    echo "Requests module is not installed. Installing..."
    pip3 install requests
fi

# Define colors for the banner
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

# Print the banner
echo -e "${GREEN}██╗    ██╗███████╗██████╗ ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗"
echo -e "██║    ██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗"
echo -e "██║ █╗ ██║█████╗  ██████╔╝██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝"
echo -e "██║███╗██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗"
echo -e "╚███╔███╔╝███████╗██████╔╝██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║"
echo -e " ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
echo -e "                WebMaster by Shadow_Sadist${RESET}"

# Start the main loop
while true; do
    # Read URL input
    try {
        read -p "$(echo -e "${GREEN}Enter the URL of the webpage (or type 'exit' to quit):${RESET}") " url
        if [[ "$url" == "exit" ]]; then
            echo -e "${YELLOW}Exiting script. Goodbye!${RESET}"
            exit 0
        fi
    } catch {
        echo -e "${RED}No input received. Exiting script.${RESET}"
        exit 1
    }

    # Prompt for filename
    read -p "$(echo -e "${GREEN}Enter the filename to save the HTML (default: page.html):${RESET}") " filename
    filename=${filename:-page.html}

    # Call the Python script to fetch the HTML
    python3 -c "
import requests
try:
    response = requests.get('$url')
    with open('$filename', 'w') as f:
        f.write(response.text)
    print('HTML content saved to', '$filename')
except Exception as e:
    print('Failed to fetch the URL:', e)
"
done
