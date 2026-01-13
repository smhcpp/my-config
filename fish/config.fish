set -x XCURSOR_THEME Bibata-Modern-Classic
set -x XCURSOR_SIZE 24

alias copy 'wl-copy'
alias paste 'wl-paste'
alias ll  'ls -a'
alias fishconf '$EDITOR ~/.config/fish/config.fish'
alias tmuxconf '$EDITOR ~/.config/tmux/tmux.conf'
alias niriconf '$EDITOR ~/.config/niri/config.kdl'
alias vimconf '$EDITOR ~/.config/nvim/init.lua'
alias vim 'nvim'
alias wpaper '/home/mortimertz/.config/fish/set-wallpapers.fish'

fish_vi_key_bindings
bind -M insert -m default jk repaint
set fish_cursor_default block
set fish_cursor_insert line blink

bind -M insert \co forward-word
bind -M insert \cl accept-autosuggestion

bind -M normal -e s
bind -M normal H screen_to_helix
bind -M normal \eh history_to_helix
bind -M normal \ee edit_cmd_in_helix

bind -M normal gk "tmux next-window"
bind -M normal gj "tmux previous-window"
bind -M normal gn "tmux new-window"
bind -M normal sn 'tmux new-session'
bind -M normal sk 'tmux switch-client -n'
bind -M normal sj 'tmux switch-client -p'
bind -M normal zv 'tmux split-window -v'
bind -M normal zh 'tmux split-window -h'
bind -M normal zj 'tmux select-pane -D'
bind -M normal zk 'tmux select-pane -U'
bind -M normal zh 'tmux select-pane -L'
bind -M normal zl 'tmux select-pane -R'
bind -M normal zz 'tmux select-pane -t :.+'

function screen_to_helix
    set temp_file (mktemp /tmp/terminal_screen_XXXXXX)
    if set -q TMUX
        tmux capture-pane -S -1000 -p >$temp_file
    else
        echo "Not in tmux" >$temp_file
    end
    hx $temp_file
end

function history_to_helix
    set temp_file (mktemp /tmp/fish_history_XXXXXX)
    history --show-time="%Y-%m-%d %H:%M  " | tail -n 1000 >$temp_file
    hx $temp_file
end

function edit_cmd_in_helix
    set temp_file (mktemp /tmp/current_cmd_XXXXXX)
    commandline -b >$temp_file
    hx $temp_file
    if test -s $temp_file
        set saved_cmd (cat $temp_file | string trim)
        commandline -r $saved_cmd
    end
    rm -f $temp_file
end

if status is-interactive
    if not set -q TMUX; and string match -r -q "(xterm|ghostty|kitty|foot|alacritty|wezterm|gnome|st)" -- $TERM
        # if not set -q TMUX
        tmux new-session 2>/dev/null; or tmux attach
    end
end
