set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24

# --- Aliases ---
alias copy 'wl-copy'
alias paste 'wl-paste'
alias ll 'ls -a'
alias footrc '$EDITOR ~/.config/foot/foot.ini'
alias fishrc '$EDITOR ~/.config/fish/config.fish'
alias tmuxrc '$EDITOR ~/.config/tmux/tmux.conf'
alias nirirc '$EDITOR ~/.config/niri/config.kdl'
alias vimrc '$EDITOR ~/.config/nvim/init.lua'
alias vim 'nvim'
alias wpaper '/home/mortimertz/.config/fish/set-wallpapers.fish'

# --- Vi Mode & Key Bindings ---
fish_vi_key_bindings
bind -M insert -m default jk repaint
set fish_cursor_default block
set fish_cursor_insert line blink

bind -M insert \co forward-word
bind -M insert \cl accept-autosuggestion
if status is-interactive
    if not set -q TMUX; and string match -r -q "(alacritty|kitty|foot)" -- $TERM
        if set -q WAYLAND_DISPLAY; or set -q DISPLAY
            tmux attach 2>/dev/null; or tmux new-session
        end
    end
end
