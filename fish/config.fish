set -x GTK_USE_PORTAL 0
bind \co forward-word
bind \cl accept-autosuggestion
if status is-interactive
    and not set -q TMUX
    exec tmux
end
