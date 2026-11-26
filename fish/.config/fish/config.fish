# Interactive setup only; environment lives in conf.d/env.fish.
if status is-interactive
    set -g fish_greeting

    # Shared Tokyo Night palette (same as foot, sway, tmux, waybar)
    set -g fish_color_normal C0CAF5
    set -g fish_color_command 7AA2F7
    set -g fish_color_keyword 9D7CD8
    set -g fish_color_quote 9ECE6A
    set -g fish_color_redirection 73DACA
    set -g fish_color_end 9D7CD8
    set -g fish_color_error F7768E
    set -g fish_color_param C0CAF5
    set -g fish_color_option A9B1D6
    set -g fish_color_comment 565F89
    set -g fish_color_operator 89DDFF
    set -g fish_color_escape 73DACA
    set -g fish_color_autosuggestion 565F89
    set -g fish_color_valid_path --underline
    set -g fish_color_selection --background=292E42
    set -g fish_color_search_match --background=292E42
    set -g fish_color_cancel F7768E
    set -g fish_pager_color_prefix C0CAF5 --bold
    set -g fish_pager_color_completion A9B1D6
    set -g fish_pager_color_description 737AA2
    set -g fish_pager_color_progress 1A1B26 --background=7AA2F7
    set -g fish_pager_color_selected_background --background=292E42

    # Hook in tools only when they're installed
    type -q starship; and starship init fish | source
    type -q zoxide; and zoxide init fish | source
    type -q fzf; and fzf --fish | source
    type -q direnv; and direnv hook fish | source

    # Abbreviations expand when you press space, so history shows the full command
    abbr -a v nvim
    abbr -a g git
    abbr -a gs git status -sb
    abbr -a ga git add
    abbr -a gc git commit
    abbr -a gp git push
    abbr -a gl git pull
    abbr -a gd git diff
    abbr -a glo git log --oneline --graph -20
    abbr -a lg lazygit
    abbr -a dc docker compose
    abbr -a k kubectl
    abbr -a t tmux new -A -s main

    alias python python3
    if type -q eza
        alias ls 'eza --group-directories-first --icons=auto'
        alias ll 'eza -la --git --group-directories-first --icons=auto'
        alias lt 'eza --tree --level=2 --icons=auto'
    end
end
