# --- Vi Mode & Key Bindings ---
fish_vi_key_bindings
bind -M default -e v
# set -g fish_bind_mode default
bind -M insert -m default jk repaint
bind -M default ss 'tmux choose-tree -Zs'
bind -M default sk 'tmux switch-client -n'
bind -M default sj 'tmux switch-client -p'
bind -M default sn 'tmux new-session -d; tmux switch-client -n'
# bind -M default xx 'tmux kill-session'
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
function nxshell
    nix-shell $argv
end
function exshell
    if set -q IN_NIX_SHELL
        echo "Exiting nix-shell..."
        exit
    else
        echo "Not in nix-shell, staying in current shell"
        return 1
    end
end
