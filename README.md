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

### zsh

It links the shell startup files managed in this repository:

- `~/.zshrc` → `~/.dotfiles/config/zsh/.zshrc`
- `~/.zprofile` → `~/.dotfiles/config/zsh/.zprofile`

The generated Powerlevel10k appearance file `~/.p10k.zsh` is intentionally left in place and is sourced by `.zshrc`.

### mise

The global mise configuration is linked from:

- `~/.config/mise/config.toml` → `~/.dotfiles/config/mise/config.toml`

It provides the default Node.js version and enables project `.nvmrc` / `.node-version` files for mise.

### Homebrew

`Brewfile` records the Homebrew packages installed on this Mac. To preview or restore the package set, use:

```bash
brew bundle check --file=~/.dotfiles/Brewfile
brew bundle --file=~/.dotfiles/Brewfile
```

If the target files/directories already exist, the installer may rename them to *.bak.<timestamp> before creating symlinks. Preview its actions first with `./install.sh --dry-run`.

The installer intentionally does not modify `~/.gitconfig` or other global Git settings.

## Notes
- This repository is tailored to my environment and may require adjustments on your machine.
- Some apps may require restart/reload to apply changes.

Enjoy!
