set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24
set -gx CARGO_NET_GIT_FETCH_WITH_CLI true
# --- Aliases ---
alias copy wl-copy
alias paste wl-paste
alias ll 'ls -a'
alias footrc '$EDITOR ~/.config/foot/foot.ini'
alias fishrc '$EDITOR ~/.config/fish/config.fish'
alias tmuxrc '$EDITOR ~/.config/tmux/tmux.conf'
alias nirirc '$EDITOR ~/.config/niri/config.kdl'
alias vimrc '$EDITOR ~/.config/nvim/init.lua'
alias yazirc '$EDITOR ~/.config/yazi/yazi.toml'
alias vim nvim
alias wpaper '/home/mortimertz/.config/fish/set-wallpapers.fish'

if set -q GHOSTTY_BIN_DIR
    source ~/.config/fish/conf.d/ghostty.fish
else if string match -q "foot*" "$TERM"
    source ~/.config/fish/conf.d/foot.fish
end
if command -v zoxide >/dev/null
    zoxide init fish | source
end
function yz
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
