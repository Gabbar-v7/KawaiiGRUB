
# Custom LightDM, GRUB, and Plymouth Theme Setup

Welcome to the ultimate setup script for customizing your **LightDM**, **GRUB**, and **Plymouth** themes! 🎨🚀

This script is designed to make your system look sleek and professional by changing your login screen, bootloader, and boot splash screen all at once.
![screenshot](https://github.com/user-attachments/assets/7455fcd6-3089-4b36-81e5-ddc28a4a5c56)


## Getting Started

### 1. Clone the Repo

Start by cloning the repository to your machine:

```bash
git clone https://github.com/0kraven/Splashify.git
cd Splashify
```

### 2. Prepare Your Files

Make sure you have the following files:

- **Your background image** (for LightDM login screen) — default: `background.png`.
- **Your custom `gtk-dark.css` file** (for a dark GTK theme in LightDM).
- **GRUB theme folder** — if you have your own custom theme, make sure it’s in the same directory.
- **Plymouth theme folder** — if you want to use the Ironman Plymouth theme, the folder needs to be there as well.

### 3. Run the Script

To get started with the customization, simply run:

```bash
chmod +x install.sh
./install.sh
```

This will:
- Install and configure LightDM with your custom background and theme.
- Install and configure GRUB with a custom theme and splash screen.
- Set up Plymouth with the **Ironman** theme (or any theme of your choice).

### 4. Enjoy the Look

Once the script finishes, restart your system and enjoy your newly customized login screen, bootloader, and boot splash screen! ✨

## How Does It Work?

- **LightDM**: 
   The script checks if the background image exists and moves it to the correct directory. Then, it updates the LightDM configuration file to point to the new background. Save new background images in login folder.
   
- **GRUB**: 
   It checks if a GRUB theme folder is present and installs it to `/boot/grub/themes/`. The script also modifies the `grub` configuration to point to your new theme and adds splash options.

- **Plymouth**: 
   The script copies the Plymouth theme folder to the appropriate directory and applies it. This allows you to change the boot splash screen, making the boot process feel a bit more polished.

## Customizing

Feel free to customize the following in the script:
- **LightDM background**: Update the `IMAGE_NAME` variable with your desired image.
- **GTK theme**: Update the `GTK_CSS_FILE` to use your custom `.css` file.
- **GRUB theme**: You can replace the theme folder with your own theme.
- **Plymouth theme**: If you don’t want the Ironman theme, you can replace the `IRONMEN_FOLDER` with any other theme.

### Important Variables in the Script:

- `LIGHTDM_CONF`: Path to the LightDM configuration file.
- `IMAGE_NAME`: Name of the background image.
- `GTK_CSS_FILE`: Path to the custom `gtk.css` file.
- `THEME_NAME`: The name of the GRUB and Plymouth theme.

## Troubleshooting

If you encounter any issues, here are a few tips:

- **Missing `/etc/default/grub` file**:
  If you see an error about the GRUB configuration file being missing, simply reinstall the `grub-common` package:
  
  ```bash
  sudo apt install --reinstall grub-common
  ```

- **Missing image or theme files**:
  Make sure the image and theme files are in the correct directory before running the script.

If something doesn’t work as expected, don’t hesitate to open an issue in the repo. We’ll be happy to help you out!

## Contributions

Contributions are welcome! If you’ve made an improvement, feel free to fork the repo and submit a pull request. Let’s make this script even better!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### Enjoy your custom theme setup! 😎🎨
