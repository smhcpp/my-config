set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24
bind \co forward-word
bind \cl accept-autosuggestion
if status is-interactive
    for key in s w t x q j k l h a d e
        bind -e \e$key
    end
    if not set -q TMUX
        tmux new-session 2>/dev/null; or tmux attach
    end
end
