# zotfiles

Dotfiles for Fedora + Sway, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level folder is a package that mirrors `$HOME`.

## Install

```sh
git clone git@github.com:zeufack/zotfiles.git ~/zotfiles
cd ~/zotfiles
./bootstrap.sh              # packages, fonts, stow, fish as login shell
WITH_COPR=1 ./bootstrap.sh  # also starship + ghostty from COPR
```

Or link single packages: `stow -t ~ sway waybar fish`.

## Packages

| Package    | What                                                                    |
|------------|-------------------------------------------------------------------------|
| `sway`     | Window manager. Layers on Fedora's `/usr/share/sway/config.d` drop-ins |
| `waybar`   | Status bar, based on [athena](https://github.com/haikal-hakim/athena) (MIT) and adapted for sway. Colours in `tokens/colors.css` |
| `swaylock` | Lock screen (`$mod+Escape`, and automatically after 5 min)              |
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

Wallpaper: put an image at `~/Pictures/wallpaper.jpg` (or .png/.webp/.jxl) and reload sway.

The colour palette (`#1E272B` bg, `#EAD49B` fg, `#78824B` accent) is shared
across sway, rofi, foot, dunst and swaylock. Waybar keeps athena's blue
Material palette for now.
