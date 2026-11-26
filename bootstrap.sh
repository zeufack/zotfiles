#!/usr/bin/env bash
# Fedora Sway setup: install packages and fonts, link the dotfiles with stow,
# and make fish the login shell. Safe to re-run.
#
#   ./bootstrap.sh              # Fedora repos only
#   WITH_COPR=1 ./bootstrap.sh  # also ghostty + yazi from COPR
set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(sway waybar themes dunst foot rofi fish tmux nvim wlogout zathura kanshi)

DNF_PKGS=(
    stow fish tmux neovim
    foot rofi waybar dunst swaylock swayidle
    grim slurp grimshot wl-clipboard cliphist swappy wlsunset
    brightnessctl playerctl pavucontrol blueman xdg-desktop-portal-wlr
    network-manager-applet tuned-ppd Thunar
    wlogout udiskie gnome-keyring wf-recorder kanshi jq
    zathura zathura-pdf-mupdf
    fzf zoxide eza bat fd-find ripgrep git-delta lazygit btop fastfetch direnv
    jetbrains-mono-fonts-all
)

echo ">> dnf packages"
sudo dnf install -y "${DNF_PKGS[@]}"

if [[ ${WITH_COPR:-0} == 1 ]]; then
    echo ">> COPR: ghostty, yazi"
    sudo dnf copr enable -y scottames/ghostty
    sudo dnf copr enable -y lihaohong/yazi
    sudo dnf install -y ghostty yazi
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

echo ">> fish plugins: fisher, tide (from fish/.config/fish/fish_plugins)"
if ! fish -c 'functions -q fisher'; then
    fish -c 'curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'
fi
if ! fish -c 'set -q tide_left_prompt_items'; then
    # Rainbow two-line prompt, close to powerlevel10k's default; rerun `tide configure` to change
    fish -c 'tide configure --auto --style=Rainbow --prompt_colors="True color" \
        --show_time="24-hour format" --rainbow_prompt_separators=Angled \
        --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat \
        --powerline_prompt_style="Two lines, character" --prompt_connection=Disconnected \
        --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons="Many icons" --transient=No'
    "$HOME/.local/bin/theme-set" "$(basename "$(readlink "$HOME/.config/themes/current" 2>/dev/null || echo tokyo-night)")"
fi

if [[ ! -e $HOME/.config/themes/current ]]; then
    echo ">> theme: tokyo-night"
    "$HOME/.local/bin/theme-set" tokyo-night
fi

echo ">> kanshi (monitor profiles, starts with the sway session)"
systemctl --user enable kanshi.service

echo ">> GTK: dark mode"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

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
