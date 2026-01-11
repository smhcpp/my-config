set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24
bind \co forward-word
bind \cl accept-autosuggestion
if status is-interactive
    and not set -q TMUX
    and [ "$TERM" = "foot" ]
    tmux attach-session -t default; or tmux new-session -s default
    bind -e \es # Alt+s (Stop it from adding sudo)
    bind -e \ew # Alt+w
    bind -e \et # Alt+t
    bind -e \ex # Alt+x
    bind -e \eq # Alt+q
    bind -e \ej # Alt+j
    bind -e \ek # Alt+k
    bind -e \el # Alt+l
    bind -e \eh # Alt+h
    bind -e \ea # Alt+a
    bind -e \ed # Alt+d
    bind -e \ee # Alt+e
end
