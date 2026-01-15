set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24

# --- Aliases ---
alias copy wl-copy
alias paste wl-paste
alias ll 'ls -a'
alias footrc '$EDITOR ~/.config/foot/foot.ini'
alias fishrc '$EDITOR ~/.config/fish/config.fish'
alias tmuxrc '$EDITOR ~/.config/tmux/tmux.conf'
alias nirirc '$EDITOR ~/.config/niri/config.kdl'
alias vimrc '$EDITOR ~/.config/nvim/init.lua'
alias vim nvim
alias wpaper '/home/mortimertz/.config/fish/set-wallpapers.fish'

# --- Vi Mode & Key Bindings ---
fish_vi_key_bindings
# set -g fish_bind_mode default
bind -M insert -m default jk repaint
bind -M default ss 'tmux choose-tree -Zs'
bind -M default sk 'tmux switch-client -n'
bind -M default sj 'tmux switch-client -p'
bind -M default sn 'tmux new-session -d; tmux switch-client -n'
bind -M default xx 'tmux kill-session'
bind -M default gn 'tmux new-window'
bind -M default gk 'tmux next-window'
bind -M default gj 'tmux previous-window'
bind -M default " q" 'tmux kill-window'
bind -M default v 'tmux copy-mode'
set fish_cursor_default block
set fish_cursor_insert line blink

bind -M insert \co forward-word
bind -M insert \cl accept-autosuggestion
if status is-interactive
    if not set -q TMUX; and string match -r -q "(alacritty|kitty|foot)" -- $TERM
        if set -q WAYLAND_DISPLAY; or set -q DISPLAY
            tmux new-session
        end
    end
end
