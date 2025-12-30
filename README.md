# KC Dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

The repository is structured to mirror the user's home directory (`~`). This allows mapping files to various locations (like `.config/` or `.local/share/`) from a single stow operation.

Example:
- `ghostty/.config/ghostty/config` -> `~/.config/ghostty/config`
- `navi-cheats/.local/share/navi/cheats/` -> `~/.local/share/navi/cheats/`

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/windyd/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Stow all packages:
   ```bash
   stow aerospace ghostty navi navi-cheats nvim opencode zellij
   ```
   Or stow a specific package:
   ```bash
   stow nvim
   ```

## Packages

| Package | Destination |
| :--- | :--- |
| `aerospace` | `~/.config/aerospace/` |
| `ghostty` | `~/.config/ghostty/` |
| `navi` | `~/.config/navi/` |
| `navi-cheats` | `~/.local/share/navi/cheats/` |
| `nvim` | `~/.config/nvim/` |
| `opencode` | `~/.config/opencode/` |
| `zellij` | `~/.config/zellij/` |

## Maintenance

The `.stowrc` file is configured to target the home directory and ignore non-dotfile directories like `util/`.