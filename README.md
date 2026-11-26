# zotfiles

Dotfiles for Fedora + Sway, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level folder is a package that mirrors `$HOME`.

## Install

```sh
git clone git@github.com:zeufack/zotfiles.git ~/zotfiles
cd ~/zotfiles
./bootstrap.sh              # packages, fonts, stow, fish as login shell
WITH_COPR=1 ./bootstrap.sh  # also ghostty from COPR
```

Or link single packages: `stow -t ~ sway waybar fish`.

## Packages

| Package    | What                                                                    |
|------------|-------------------------------------------------------------------------|
| `sway`     | Window manager. Layers on Fedora's `/usr/share/sway/config.d` drop-ins |
| `waybar`   | Status bar, based on [athena](https://github.com/haikal-hakim/athena) (MIT) and adapted for sway. Colours come from the active theme |
| `themes`   | Colour themes and `theme-set` (see below). Includes each theme's swaylock config |
| `dunst`    | Notifications                                                           |
| `foot`     | Terminal (fallback when ghostty isn't installed)                        |
| `rofi`     | Launcher (`$mod+d`), window switcher (`$mod+Tab`), clipboard (`$mod+Shift+v`) |
| `fish`     | Shell: env in `conf.d/env.fish`, abbreviations in `config.fish`         |
| `tmux`     | Prefix `C-a`, vi keys                                                   |
| `nvim`     | Lua config with pckr.nvim, LSP via mason                                |
| `i3`, `zsh`| Previous X11 setup, kept for reference                                  |

## Sway keys worth knowing

| Keys                               | Action                                |
|------------------------------------|---------------------------------------|
| `$mod+h/j/k/l`                     | Focus (add Shift to move)             |
| `$mod+b` / `$mod+v`                | Split horizontal / vertical           |
| `$mod+grave`                       | Previous workspace                    |
| `$mod+minus` / `$mod+Shift+minus`  | Show / send to scratchpad             |
| `Print`, `$mod+Print`, `Shift+Print` | Screenshot screen / window / area (add Ctrl to copy) |
| `$mod+Shift+s`                     | Annotate an area with swappy          |
| `$mod+Pause`                       | Passthrough mode (for VMs/remote desktop) |
| `$mod+Escape`                      | Lock (also automatic after 5 min)     |
| `$mod+Shift+t`                     | Pick a theme                          |

Wallpaper: put an image at `~/Pictures/wallpaper.jpg` (or .png/.webp/.jxl) and reload sway.

## Themes

Every app takes its colours from `~/.config/themes/current/`, a link to one of
the themes in `themes/.config/themes/`: Tokyo Night (default), Catppuccin Mocha,
Kanagawa and Rosé Pine.

```sh
theme-set              # rofi picker, also on $mod+Shift+t
theme-set kanagawa     # switch directly
theme-set --list       # theme names; --current prints the active one
```

Switching reloads sway, waybar, tmux and dunst, and recolours running fish shells
and nvim. Open foot windows keep the old colours until reopened.

A theme is a folder with one file per app: `sway.conf`, `waybar.css`,
`rofi.rasi`, `foot.ini`, `dunst.conf`, `swaylock.conf`, `tmux.conf`, `fish.fish`
and `nvim.lua` (the colorscheme name; its plugin must be in `nvim/lua/plugins.lua`).
Copy an existing theme to make a new one. Drop a `wallpaper.jpg` (or .png/.webp/.jxl)
in a theme to ship a wallpaper; `~/Pictures/wallpaper.*` still wins if present.
