# Interactive setup only; environment lives in conf.d/env.fish.
if status is-interactive
    set -g fish_greeting

    # Colours from the active theme. theme-set changes the universal $zot_theme,
    # which makes every running fish re-source the new colours.
    function __zot_theme_apply --on-variable zot_theme
        set -l f ~/.config/themes/current/fish.fish
        test -f $f; and source $f
    end
    __zot_theme_apply

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
