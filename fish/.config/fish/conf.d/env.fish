# Environment and PATH (ported from zsh/.zshrc). Runs for every fish, including
# non-interactive ones. fish_add_path -g skips folders that don't exist and keeps
# PATH out of fish_variables.

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'

fish_add_path -g ~/.local/bin ~/bin ~/.cargo/bin ~/go/bin /usr/local/go/bin \
    ~/.bun/bin ~/.yarn/bin ~/.config/yarn/global/node_modules/.bin \
    ~/.opencode/bin /usr/lib/dart/bin /opt/apache-maven-3.8.5/bin /opt/allure-2.10.0/bin

# Java: JAVA_HOME is the JDK root (zsh pointed it at bin/, which breaks Maven/Gradle)
for jdk in /usr/lib/jvm/jdk-17 /usr/lib/jvm/java-21-openjdk /usr/lib/jvm/java-17-openjdk /usr/lib/jvm/java
    if test -d $jdk
        set -gx JAVA_HOME $jdk
        fish_add_path -g $JAVA_HOME/bin
        break
    end
end

# Android SDK (React Native)
if test -d ~/Android/Sdk
    set -gx ANDROID_HOME ~/Android/Sdk
    set -gx ANDROID_SDK_ROOT $ANDROID_HOME
    fish_add_path -g -a $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools
end

set -gx BUN_INSTALL ~/.bun
set -gx PNPM_HOME ~/.local/share/pnpm
fish_add_path -g $PNPM_HOME

# Google Cloud SDK ships a fish snippet
test -f ~/google-cloud-sdk/path.fish.inc; and source ~/google-cloud-sdk/path.fish.inc

# Node: nvm is bash-only. Use Fedora's nodejs, or `fisher install jorgebucaran/nvm.fish`.

# ssh-agent (systemd socket) for shells outside sway, e.g. a TTY login.
# Inside sway it's already set by ~/.config/environment.d/50-ssh-agent.conf.
if not set -q SSH_AUTH_SOCK; and test -S $XDG_RUNTIME_DIR/ssh-agent.socket
    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
end
