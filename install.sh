#!/bin/bash

# Colors for hacker vibes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# Banner
echo -e "${CYAN}############################################################"
echo -e "${GREEN}###              SPLASHIFY THEME INSTALLER              ###"
echo -e "${CYAN}############################################################"
echo -e "${WHITE}        Setting up LightDM, GRUB, and Plymouth themes...      "
echo -e "${CYAN}############################################################"


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
if [[ ! -f "login/$IMAGE_NAME" ]]; then
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
sudo cp "login/$IMAGE_NAME" "$IMAGE_DEST"

# Check if LightDM configuration file exists
if [[ ! -f "$LIGHTDM_CONF" ]]; then
  echo "Error: LightDM configuration file not found at $LIGHTDM_CONF."
  exit 1
fi

# Update the LightDM configuration file to set the background image
echo "Updating LightDM configuration..."
sudo sed -i "/^background =/c\background = $IMAGE_DEST" "$LIGHTDM_CONF"

# If no background line exists, append it
if ! grep -q "^background=" "$LIGHTDM_CONF"; then
  echo "background=$IMAGE_DEST" | sudo tee -a "$LIGHTDM_CONF" > /dev/null
fi

sudo sed -i "/^theme-name =/c\\theme-name = Kali-Dark" "$LIGHTDM_CONF"

# Check if the custom dark-gtk.css file exists in the current directory
if [[ ! -f "login/$GTK_CSS_FILE" ]]; then
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
sudo cp "login/$GTK_CSS_FILE" "$GTK_CSS_DEST"


echo -e "${GREEN}Done! LightDM is set with the new background image, and Kali-Dark theme is updated with your custom GTK CSS file.${NC}"


# Variables for Plymouth theme
IRONMEN_FOLDER="Ironman"  # Folder name
PLYMOUTH_THEMES_DIR="/usr/share/plymouth/themes"
THEME_NAME="Ironman"  # Name of the theme you want to set

# Check if the Ironmen folder exists in the current directory
if [[ ! -d "$IRONMEN_FOLDER" ]]; then
  echo -e "${RED}Error: Folder '$IRONMEN_FOLDER' not found in the current directory.${NC}"
  exit 1
fi

# Copy the Ironmen folder to the Plymouth themes directory
echo -e "${GREEN}Copying Ironmen folder to $PLYMOUTH_THEMES_DIR...${NC}"
sudo cp -r "$IRONMEN_FOLDER" "$PLYMOUTH_THEMES_DIR"

# Check if the copy was successful
if [[ $? -eq 0 ]]; then
  echo -e "${GREEN}Successfully copied the Ironmen folder to $PLYMOUTH_THEMES_DIR.${NC}"
else
  echo -e "${RED}Error: Failed to copy the Ironmen folder.${NC}"
  exit 1
fi

# Set the default Plymouth theme to Ironmen
echo -e "${CYAN}Setting Plymouth default theme to $THEME_NAME...${NC}"
sudo plymouth-set-default-theme "$THEME_NAME"

# Update initramfs to apply the new theme
echo -e "${YELLOW}Updating initramfs to apply the new theme...${NC}"
sudo update-initramfs -u

echo -e "${GREEN}Done! Plymouth theme set to '$THEME_NAME'.${NC}"


echo -e "${CYAN}Please enter your sudo password to install the theme:${NC}"
sudo -v

# Variables
THEME_NAME="kawaii-grub-theme"
THEME_DIR="/boot/grub/themes"
THEME_PATH="$THEME_DIR/$THEME_NAME/theme.txt"
GRUB_CONFIG="/etc/default/grub.d/kali-themes.cfg"
GRUB_THEME_PATH="/boot/grub/themes/$THEME_NAME/theme.txt"

# Check if the theme directory exists in /boot/grub/themes
if [ -d "$THEME_DIR/$THEME_NAME" ]; then
  echo "Theme folder '$THEME_NAME' already exists in $THEME_DIR."
  echo "Deleting the existing theme folder..."
  sudo rm -rf "$THEME_DIR/$THEME_NAME"
  echo "Existing theme folder deleted."
fi

# Check if the theme folder exists locally
if [ ! -d "$THEME_NAME" ]; then
  echo "Error: Theme folder '$THEME_NAME' not found locally. Make sure the folder is in the current directory."
  exit 1
fi

# Copy the theme folder to /boot/grub/themes
echo "Copying theme to $THEME_DIR..."
sudo mkdir -p "$THEME_DIR"
sudo cp -r "$THEME_NAME" "$THEME_DIR/"
echo "Theme copied successfully."

# Edit the theme.txt file to set the GRUB_GFXMODE and GRUB_THEME
echo "Updating theme.txt file to set GRUB_GFXMODE and GRUB_THEME..."
sudo sed -i '/^GRUB_THEME=/c\GRUB_THEME="'$GRUB_THEME_PATH'"' "$GRUB_THEME_PATH"

# Enable plymouth in GRUB_CMDLINE_LINUX_DEFAULT if not already done
if ! grep -q "splash" "$GRUB_CONFIG"; then
  echo "Adding splash option to GRUB_CMDLINE_LINUX_DEFAULT..."
  sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/s/"\(.*\)"/"\1 splash"/' "$GRUB_CONFIG"
fi
GRUB_CONFIG="/etc/default/grub"
echo "GRUB_THEME=\"$THEME_PATH\"" | sudo tee -a "$GRUB_CONFIG"


# Update the GRUB configuration in /etc/default/grub.d/kali-themes.cfg
echo "Updating GRUB configuration to use the new theme..."
sudo sed -i "/^GRUB_THEME=/d" "/etc/default/grub.d/kali-themes.cfg" # Remove any existing GRUB_THEME entry
echo "GRUB_THEME=\"$THEME_PATH\"" | sudo tee -a "/etc/default/grub.d/kali-themes.cfg"
sudo cp /home/blackrose/Desktop/Splashify/kawaii-grub-theme/anime_girl.png /usr/share/images/desktop-base/desktop-grub.png


# Update GRUB


echo "Updating GRUB..."
sudo update-grub



