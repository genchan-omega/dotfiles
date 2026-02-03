# Dotfiles

This repository contains my personal **dotfiles** (configuration files) for macOS/Unix-like environments.

## Disclaimer

Feel free to use, copy, and modify anything in this repository.  
However, **you use it at your own risk** — I provide **no warranty** and take **no responsibility** for any damage, data loss, or misconfiguration caused by using these files.

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

---

## Installation

### 1) Clone this repository

Clone it into `~/.dotfiles` (recommended):

```bash
git clone <YOUR_REPO_URL> ~/.dotfiles
```

### 2) Run the installer

```
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

## What this installer does

Running install.sh will set up symbolic links so that applications can load configs from this repository.

### WezTerm

It will link the entire WezTerm config directory:

- ~/.config/wezterm → ~/.dotfiles/config/wezterm

This means WezTerm will read:

- ~/.config/wezterm/wezterm.lua
- ~/.config/wezterm/monokai-pro.lua
- and other related files/directories (e.g. assets/, local/) from the files stored in this repo.

### AeroSpace

It will link the AeroSpace config file:

- ~/.config/aerospace/aerospace.toml → ~/.dotfiles/config/aerospace/aerospace.toml

## After installation
Once install.sh completes successfully, you should have:

- A fully configured WezTerm setup under ~/.config/wezterm (backed by this repo)

- A configured AeroSpace setup under ~/.config/aerospace/aerospace.toml (backed by this repo)

If the target files/directories already exist, the installer may rename them to *.bak.<timestamp> before creating symlinks.

## Notes
- This repository is tailored to my environment and may require adjustments on your machine.
- Some apps may require restart/reload to apply changes.

Enjoy!
