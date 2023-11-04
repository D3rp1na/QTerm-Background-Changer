#!/bin/bash

# QTerminal Background Changer by D3rp1na
# HUGE, MASSIVE THANKS to Doc0x1 ( https://github.com/doc0x1 ) for help creating this gem!!!
# HUGE shoutout to Team S.T.R.I.K.E ( https://discord.gg/3BcgT8Dy ) and OWLsec ( https://discord.gg/owlsec ) for helping the community!



# Create the "Backgrounds" directory in the user's home directory if it doesn't exist
backgrounds_dir="$HOME/Backgrounds"
if [ ! -d "$backgrounds_dir" ]; then
    mkdir -p "$backgrounds_dir"
    echo "Created the 'Backgrounds' directory in your home folder."
fi

# Path to the QTerminal INI file
qtermini="$HOME/.config/qterminal.org/qterminal.ini"

# Directory containing the background images
image_folder="$backgrounds_dir"

# Check if the QTerminal INI file exists
if [ ! -f "$qtermini" ]; then
    echo "QTerminal INI file not found."
    exit 1
fi

# Check if the image folder exists
if [ ! -d "$image_folder" ]; then
    echo "Image folder not found."
    exit 1
fi

# List all image files in the folder
image_files=("$image_folder"/*)

# Prompt the user to choose a background mode (0 through 4)
echo "Choose a background mode (0: None, 1: Stretch, 2: Zoom, 3: Fit, 4: Center):"
read -r background_mode

# Validate the input and set a default if it's not in the range 0-4
if [[ $background_mode -ge 0 && $background_mode -le 4 ]]; then
    selected_mode="$background_mode"
else
    selected_mode=3  # Default to "Stretch"
fi

# Randomly select an image
random_index=$((RANDOM % ${#image_files[@]}))
selected_image="${image_files[random_index]}"

# Set the selected image and background mode in the QTerminal INI file
if sed -i "s|^TerminalBackgroundImage=.*|TerminalBackgroundImage=\"$selected_image\"|" "$qtermini" &&
   sed -i "s|^TerminalBackgroundMode=.*|TerminalBackgroundMode=$selected_mode|" "$qtermini"; then
    echo "QTerminal background changed to $selected_image with mode $selected_mode"
else
    echo "Failed to change QTerminal background."
fi
