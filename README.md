# Kawaii GRUB Theme

This theme brings a touch of elegance and charm to your GRUB bootloader with vibrant colors, clean design, and a kawaii-inspired aesthetic.

<div align="center">
<img src="assets/screenshot.jpg" alt="Kawaii GRUB Theme">
</div>

## Features

- **Bold Fonts**: Uses unique bold fonts to enhance the theme's visual appeal.
- **Minimalistic Design**: Focuses on simplicity with a kawaii-inspired aesthetic.
- **Easy to Install**: Follow the installation steps to quickly apply the theme to your GRUB.
- **High Customizability**: Modify colors, fonts, and more to make it your own.

## Installation

### Prerequisites

- Ensure you have `grub2` installed on your system.
- A basic understanding of the Linux terminal.

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Gabbar-v7/KawaiiGRUB.git
   ```

2. **Navigate to the Theme Directory**:
   ```bash
   cd KawaiiGRUB
   ```

### Install Via Script

3. **Run install.sh**:
   ```bash
   ./install.sh
   ```

### Manual Installation

#### For Debian-based Systems (e.g., Ubuntu, Debian)

3. **Copy the Theme to GRUB's Themes Directory**:

   ```bash
   sudo cp -r kawaii-grub-theme /boot/grub/themes/
   ```

4. **Set the Theme in GRUB Configuration**:
   Open your GRUB configuration file (usually located at `/etc/default/grub`) and add the following line:

   ```plaintext
   GRUB_THEME="/boot/grub/themes/kawaii-grub-theme/theme.txt"
   ```

5. **Update GRUB**:
   Apply the changes by updating GRUB.

   ```bash
   sudo update-grub
   ```

6. **Reboot**:
   Restart your system to see the new theme in action!

#### For Arch-based Systems (e.g., Arch Linux, Manjaro)

3. **Copy the Theme to GRUB's Themes Directory**:

   ```bash
   sudo cp -r kawaii-grub-theme /boot/grub/themes/
   ```

4. **Set the Theme in GRUB Configuration**:
   Open your GRUB configuration file (usually located at `/etc/default/grub`) and add the following line:

   ```plaintext
   GRUB_THEME="/boot/grub/themes/kawaii-grub-theme/theme.txt"
   ```

5. **Update GRUB**:
   Apply the changes by updating GRUB.

   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

6. **Reboot**:
   Restart your system to see the new theme in action!

## Changing Fonts

1. Locate the `theme.txt` file inside the theme directory.
2. Change the `item_font` parameter to use your preferred font file, e.g., `item_font = "roboto_bold_25.pf2"`.

## Customization

To customize the theme, open the `theme.txt` file in the theme directory. Here, you can modify:

- **Font**: Change the font setting.
- **Background**: Set your preferred background image. Replace `background.png`
- **Colors**: Adjust colors for selected/unselected menu items and more.

## Troubleshooting

### General Issues

- **Incorrect Paths**: If you encounter issues during boot, ensure that the paths in `GRUB_THEME` and other settings are correct. Double-check the location of the theme directory and the `theme.txt` file.
- **Custom Fonts**: If you want to use custom fonts, ensure they are in the correct `.pf2` format. Use `grub-mkfont` to convert TTF/OTF fonts:
  ```bash
  grub-mkfont -s 25 -o custom_font_25.pf2 font.ttf
  ```
- **Secure Boot**: Issues with applying fonts or themes may arise due to Secure Boot. Try disabling Secure Boot in your BIOS/UEFI settings.

### Debian-based Systems

- **GRUB Update Fails**: If `sudo update-grub` fails, ensure that the `GRUB_THEME` path is correct and that the theme files are properly copied to `/boot/grub/themes/`.
- **Missing GRUB Directory**: If the `/boot/grub/themes/` directory does not exist, create it manually:
  ```bash
  sudo mkdir -p /boot/grub/themes/
  ```

### Arch-based Systems

- **GRUB Configuration Not Applied**: If the theme does not appear after updating GRUB, ensure that the `GRUB_THEME` line is correctly added to `/etc/default/grub` and that the `grub-mkconfig` command is executed successfully.
- **Missing GRUB Directory**: If the `/boot/grub/themes/` directory does not exist, create it manually:
  ```bash
  sudo mkdir -p /boot/grub/themes/
  ```
- **GRUB Installation**: Ensure GRUB is properly installed on your system. If not, install it using:
  ```bash
  sudo pacman -S grub
  ```

## Contributing

Contributions are welcome! If you’d like to improve this theme, feel free to submit a pull request or open an issue with suggestions.

## License

This project is licensed under the MIT License. See [LICENSE](/LICENSE) for details.

---

Enjoy the **Kawaii GRUB** and happy booting!
