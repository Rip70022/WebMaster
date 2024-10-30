#!/bin/bash

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

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

# Run the Python script to display the banner and handle HTML copying
python3 - <<EOF
import requests
import sys

# Color codes for terminal output
RED = '\033[1;31m'
GREEN = '\033[1;32m'
BLUE = '\033[1;34m'
CYAN = '\033[1;36m'
YELLOW = '\033[1;33m'
RESET = '\033[0m'

# Function to display the banner
def display_banner():
    print(f"{CYAN}")
    print("██╗    ██╗███████╗██████╗ ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ")
    print("██║    ██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗")
    print("██║ █╗ ██║█████╗  ██████╔╝██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝")
    print("██║███╗██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗")
    print("╚███╔███╔╝███████╗██████╔╝██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║")
    print(" ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝")
    print(f"{BLUE}                WebMaster by Shadow_Sadist{RESET}")
    print()

# Function to copy HTML from a given URL
def copy_html(url, filename):
    try:
        response = requests.get(url)
        response.raise_for_status()
        
        with open(filename, "w", encoding="utf-8") as file:
            file.write(response.text)
        
        print(f"{GREEN}HTML successfully copied to '{filename}'{RESET}")
    
    except requests.exceptions.RequestException as e:
        print(f"{RED}Error retrieving the page:{RESET}", e)

# Display the banner
display_banner()

# Custom prompt
while True:
    url = input(f"{GREEN}Enter the URL of the webpage (or type 'exit' to quit):{RESET} ")
    if url.lower() == "exit":
        print(f"{YELLOW}Exiting script. Goodbye!{RESET}")
        sys.exit(0)

    filename = input(f"{GREEN}Enter the filename to save the HTML (default: page.html):{RESET} ")
    filename = filename if filename else "page.html"  # Use "page.html" as default if no name is provided

    copy_html(url, filename)
EOF
