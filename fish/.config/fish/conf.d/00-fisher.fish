# Fisher plugins (tide, ...) live outside this repo, in ~/.local/share/fisher.
# bootstrap.sh installs them; `fisher install <plugin>` adds more.
set -g fisher_path ~/.local/share/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]
for file in $fisher_path/conf.d/*.fish
    source $file
end
