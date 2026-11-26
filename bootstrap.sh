#!/usr/bin/env bash
# Fedora Sway setup: install packages and fonts, link the dotfiles with stow,
# and make fish the login shell. Safe to re-run.
#
#   ./bootstrap.sh              # Fedora repos only
#   WITH_COPR=1 ./bootstrap.sh  # also starship + ghostty from COPR
set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(sway waybar themes dunst foot rofi fish tmux nvim)

DNF_PKGS=(
    stow fish tmux neovim
    foot rofi waybar dunst swaylock swayidle
    grim slurp grimshot wl-clipboard cliphist swappy wlsunset
    brightnessctl playerctl pavucontrol blueman xdg-desktop-portal-wlr
    network-manager-applet tuned-ppd Thunar
    fzf zoxide eza bat fd-find ripgrep git-delta lazygit btop fastfetch direnv
    jetbrains-mono-fonts-all
)

echo ">> dnf packages"
sudo dnf install -y "${DNF_PKGS[@]}"

if [[ ${WITH_COPR:-0} == 1 ]]; then
    echo ">> COPR: starship, ghostty"
    sudo dnf copr enable -y atim/starship
    sudo dnf copr enable -y scottames/ghostty
    sudo dnf install -y starship ghostty
fi

# Icons for waybar, eza and nvim (Fedora doesn't package Nerd Fonts)
fontdir="$HOME/.local/share/fonts/NerdFontsSymbolsOnly"
if [[ ! -d $fontdir ]]; then
    echo ">> Nerd Font symbols"
    mkdir -p "$fontdir"
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz \
        | tar -xJ -C "$fontdir"
    fc-cache -f "$fontdir"
fi

echo ">> stow: ${PACKAGES[*]}"
mkdir -p "$HOME/.config" "$HOME/.local/bin"
stow -v -t "$HOME" "${PACKAGES[@]}"

tpm="$HOME/.tmux/plugins/tpm"
if [[ ! -d $tpm ]]; then
    echo ">> tmux plugin manager"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm"
fi
echo ">> tmux plugins"
"$tpm/bin/install_plugins"

if [[ ! -e $HOME/.config/themes/current ]]; then
    echo ">> theme: tokyo-night"
    "$HOME/.local/bin/theme-set" tokyo-night
fi

echo ">> ssh-agent (systemd socket, started at login)"
systemctl --user enable --now ssh-agent.socket
# Cache the key passphrase in the agent on first use, so it's asked once per login
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
if ! grep -qi '^ *AddKeysToAgent' "$HOME/.ssh/config" 2>/dev/null; then
    printf 'Host *\n    AddKeysToAgent yes\n' >> "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

fish_path=$(command -v fish)
if [[ $(getent passwd "$USER" | cut -d: -f7) != "$fish_path" ]]; then
    echo ">> login shell -> $fish_path"
    sudo usermod -s "$fish_path" "$USER"
fi

echo "Done. Reload sway with \$mod+Shift+c, and log out/in for the new shell."
