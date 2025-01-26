#!/bin/bash

# Variables
LIGHTDM_CONF="/etc/lightdm/lightdm-gtk-greeter.conf"
IMAGE_NAME="background.png" # Update if your image name is different
GTK_CSS_FILE="gtk-dark.css" # Update if your custom file name is different
LIGHTDM_BACKGROUND_DIR="/usr/share/backgrounds"
IMAGE_DEST="$LIGHTDM_BACKGROUND_DIR/$IMAGE_NAME"
THEME_DIR="/usr/share/themes/Kali-Dark/gtk-3.0"
GTK_CSS_DEST="$THEME_DIR/gtk-dark.css"

# Check if the current display manager is LightDM
CURRENT_DM=$(cat /etc/X11/default-display-manager 2>/dev/null)

if [[ "$CURRENT_DM" != "/usr/sbin/lightdm" ]]; then
  echo "LightDM is not the current display manager. Switching to LightDM..."
  
  # Set LightDM as the default display manager
  sudo systemctl disable "$(basename "$CURRENT_DM")"
  sudo systemctl enable lightdm
  sudo systemctl set-default graphical.target
fi 
# Check if the image file exists in the current directory
if [[ ! -f "$IMAGE_NAME" ]]; then
  echo "Error: Image file '$IMAGE_NAME' not found in the current directory."
  exit 1
fi

# Create the LightDM background directory if it doesn't exist
if [[ ! -d "$LIGHTDM_BACKGROUND_DIR" ]]; then
  echo "Creating directory for LightDM backgrounds..."
  sudo mkdir -p "$LIGHTDM_BACKGROUND_DIR"
fi

# Move the image to the LightDM directory
echo "coping image to LightDM directory..."
sudo cp "$IMAGE_NAME" "$IMAGE_DEST"

# Check if LightDM configuration file exists
if [[ ! -f "$LIGHTDM_CONF" ]]; then
  echo "Error: LightDM configuration file not found at $LIGHTDM_CONF."
  exit 1
fi

# Update the LightDM configuration file to set the background image
echo "Updating LightDM configuration to set the new background image..."
sudo sed -i "/^background=/c\background=$IMAGE_DEST" "$LIGHTDM_CONF"

# If no background line exists, append it
if ! grep -q "^background=" "$LIGHTDM_CONF"; then
  echo "background=$IMAGE_DEST" | sudo tee -a "$LIGHTDM_CONF" > /dev/null
fi

# Check if the custom dark-gtk.css file exists in the current directory
if [[ ! -f "$GTK_CSS_FILE" ]]; then
  echo "Error: Custom dark-gtk.css file '$GTK_CSS_FILE' not found in the current directory."
  exit 1
fi

# Check if the Kali-Dark theme directory exists
if [[ ! -d "$THEME_DIR" ]]; then
  echo "Error: Kali-Dark theme directory not found at $THEME_DIR."
  exit 1
fi

# Replace the gtk.css file in the Kali-Dark theme folder with the custom one
echo "Replacing the GTK CSS file in the Kali-Dark theme folder..."
sudo cp "$GTK_CSS_FILE" "$GTK_CSS_DEST"

# Restart LightDM to apply changes
echo "Restarting LightDM to apply changes..."
sudo systemctl restart lightdm

echo "Done! LightDM is set with the new background image, and Kali-Dark theme is updated with your custom GTK CSS file."
