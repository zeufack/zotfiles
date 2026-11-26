# zotfiles

Dotfiles for Fedora + Sway, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level folder is a package that mirrors `$HOME`.

## Install

```sh
git clone git@github.com:zeufack/zotfiles.git ~/zotfiles
cd ~/zotfiles
./bootstrap.sh              # everything below
WITH_COPR=1 ./bootstrap.sh  # also ghostty + yazi from COPR
```

`bootstrap.sh` is safe to re-run. It:

- installs the dnf packages (sway tools, CLI tools, fonts) and the Nerd Font symbols
- stows every package below
- installs tmux plugins (TPM) and fish plugins (fisher, tide) and sets up the tide prompt
- sets the theme to Tokyo Night if none is set yet
- enables the ssh-agent and kanshi user services
- sets GTK apps to dark mode, and fish as the login shell

Or link single packages: `stow -t ~ sway waybar fish`.

## Packages

| Package    | What                                                                    |
|------------|-------------------------------------------------------------------------|
| `sway`     | Window manager. Layers on Fedora's `/usr/share/sway/config.d` drop-ins; also `power-menu`, `sway-record` and `sway-term` in `~/.local/bin` |
| `waybar`   | Status bar, based on [athena](https://github.com/haikal-hakim/athena) (MIT) and adapted for sway |
| `themes`   | Colour themes and `theme-set` (see [Themes](#themes))                   |
| `dunst`    | Notifications, including the volume/brightness level bars             |
| `foot`     | Terminal (used when ghostty isn't installed)                            |
| `rofi`     | Launcher, window switcher, clipboard history, theme picker              |
| `fish`     | Shell, with the [tide](https://github.com/IlanCosman/tide) prompt (see [Shell](#shell)) |
| `tmux`     | Prefix `C-a`, vi keys, powerline status bar (see [tmux](#tmux))         |
| `nvim`     | Lua config with pckr.nvim, LSP via mason; colorscheme follows the theme |
| `wlogout`  | Power menu: one row of lock, hibernate, logout, shutdown, suspend, reboot |
| `zathura`  | PDF viewer (vim keys, `Ctrl+r` for dark pages)                          |
| `kanshi`   | Monitor profiles (see [Monitors](#monitors))                            |
| `i3`, `zsh`| Previous X11 setup, kept for reference (not stowed)                     |

## Sway

### Keys

| Keys                               | Action                                |
|------------------------------------|---------------------------------------|
| `$mod+Return`                      | Terminal (ghostty, else foot)         |
| `$mod+d` / `$mod+Tab`              | App launcher / window switcher        |
| `$mod+Shift+v`                     | Clipboard history                     |
| `$mod+h/j/k/l` (or arrows)         | Focus (add Shift to move)             |
| `$mod+1`…`$mod+0`                  | Workspace (add Shift to move the window there) |
| `$mod+[` / `$mod+]` / `$mod+grave` | Previous / next / last-used workspace |
| `$mod+b` / `$mod+v`                | Split horizontal / vertical           |
| `$mod+s` / `$mod+w` / `$mod+e`     | Stacking / tabbed / toggle split layout |
| `$mod+f` / `$mod+Shift+space`      | Fullscreen / floating                 |
| `$mod+r`                           | Resize mode (h/j/k/l, Escape to leave) |
| `$mod+minus` / `$mod+Shift+minus`  | Show / send to scratchpad             |
| `Print`, `$mod+Print`, `Shift+Print` | Screenshot screen / window / area (add Ctrl to copy) |
| `$mod+Shift+s`                     | Annotate an area with swappy          |
| `$mod+Shift+r`                     | Record an area or window (Escape: whole screen); press again to stop. Saved to `~/Videos` |
| `$mod+Shift+t`                     | Pick a theme                          |
| `$mod+Shift+e`                     | Power menu (press again to close)     |
| `$mod+Escape`                      | Lock                                  |
| `$mod+Shift+c`                     | Reload sway                           |
| `$mod+Pause`                       | Passthrough mode (for VMs/remote desktop) |

Volume, brightness and media keys come from Fedora's drop-ins and show a level bar.

### Workspaces

Apps open on their own workspace (`config.d/50-rules-apps.conf`):

| Workspace | Apps |
|-----------|------|
| 1 Terminals | ghostty |
| 2 Vscode    | VS Code |
| 3 Firefox   | Firefox |
| 4 Obsidian  | Obsidian, Pomatez |
| 5 VLC       | VLC |
| 6 Chrome    | Google Chrome |

Dialogs, Bluetooth/network settings, the calculator and swappy float.
Picture-in-picture videos float and stay on every workspace.

### Running in the background

| What | Details |
|------|---------|
| Idle lock | Locks after 5 min idle, screens off 1 min later, and before sleep (`config.d/90-swayidle.conf`). Not while something is fullscreen |
| Night light | wlsunset, warm from 20:00 to 07:00 (`config.d/95-autostart-user.conf`) |
| Clipboard history | cliphist, for `$mod+Shift+v` |
| USB drives | udiskie mounts them automatically and shows a tray icon |
| Passwords | gnome-keyring, unlocked by the login screen (VS Code, Chrome, git) |
| SSH keys | ssh-agent (systemd), shared with every app via `~/.config/environment.d/`. Run `ssh-add` once per login, or let the first `ssh`/`git push` ask (`AddKeysToAgent yes`) |
| Monitors | kanshi (see [Monitors](#monitors)) |
| Fingerprint | Unlocks the lock screen (press Enter, then touch the sensor) and `sudo`. Enroll with `fprintd-enroll`; the login screen still asks for the password, which also unlocks the keyring |

### Input and look

Keyboard: US and French AZERTY, switched with `Alt+Shift` or by clicking the
layout label in waybar; repeat after 300 ms at 40/s. Touchpad: tap to click,
natural scrolling, disabled while typing. Font: JetBrains Mono, with Nerd Font
symbols for icons. 6px gaps, 2px borders, focus follows the mouse.

Wallpaper: put an image at `~/Pictures/wallpaper.jpg` (or .png/.webp/.jxl) and
reload sway. Without one, the theme's wallpaper (if any) or Fedora's default is used.

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
(including the tide prompt) and nvim. The power menu, PDF viewer and lock screen
pick it up the next time they open. Open foot windows keep the old colours until
reopened.

A theme is a folder with one file per app: `sway.conf`, `waybar.css` (also used by
the power menu), `rofi.rasi`, `foot.ini`, `dunst.conf`, `swaylock.conf`,
`tmux.conf`, `fish.fish`, `tide.fish`, `zathurarc` and `nvim.lua` (the colorscheme
name; its plugin must be in `nvim/lua/plugins.lua`). Copy an existing theme to
make a new one. Drop a `wallpaper.jpg` (or .png/.webp/.jxl) in a theme to ship a
wallpaper; `~/Pictures/wallpaper.*` still wins if present.

## Shell

fish, with the environment and PATH in `conf.d/env.fish`.

- **Prompt:** tide, Rainbow style on two lines (OS, folder, git, then language
  versions and time on the right). Change the layout with `tide configure`;
  colours come from the theme. Fisher plugins live in `~/.local/share/fisher`,
  and `fish_plugins` lists them.
- **Tools:** zoxide (`z <dir>`), fzf (`Ctrl+r` history, `Ctrl+t` files,
  `Alt+c` folders), direnv, eza for `ls`/`ll`/`lt`, and `mkcd` to make a folder
  and enter it.
- **Abbreviations** (expand on space):

| Abbr | Expands to | Abbr | Expands to |
|------|------------|------|------------|
| `v`  | `nvim`     | `gd` | `git diff` |
| `g`  | `git`      | `glo`| `git log --oneline --graph -20` |
| `gs` | `git status -sb` | `lg` | `lazygit` |
| `ga` | `git add`  | `dc` | `docker compose` |
| `gc` | `git commit` | `k` | `kubectl` |
| `gp` | `git push` | `t`  | `tmux new -A -s main` |
| `gl` | `git pull` |      |            |

## tmux

Prefix `C-a`. The status bar shows the session, windows, time and host as
powerline segments in the theme's colours.

| Keys | Action |
|------|--------|
| `prefix \|` / `prefix -` | Split side by side / top and bottom (in the current folder) |
| `prefix h/j/k/l` | Move between panes |
| `C-h/j/k/l` | Move between panes and nvim splits (vim-tmux-navigator) |
| `M-H` / `M-L` | Previous / next window |
| `prefix e` | Editor layout: nvim on top, shell below |
| `prefix f` | tmux-fzf (sessions, windows, panes, commands) |
| `prefix \` | tmux-menus |
| `prefix r` | Reload the config |

Copy mode uses vi keys: `v` to select, `y` to copy.

## Monitors

kanshi picks a layout from what's plugged in (`kanshi/.config/kanshi/config`):

- **Laptop only:** the built-in screen (`eDP-1`) at scale 1.
- **Any external monitor:** both screens on. The monitor uses its preferred
  resolution and sits centred above the laptop (`place-above` works out the
  positions from both screens' sizes).

To pin a specific monitor, replace `output *` with its make/model/serial from
`swaymsg -t get_outputs` and add a mode or scale, then run `kanshictl reload`.
