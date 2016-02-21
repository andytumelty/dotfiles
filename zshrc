#'[ -z `ps -o command= -p $PPID | grep tmux` ] && $HOME/.bin/tat

setopt promptsubst
export PS1='%{$fg[blue]%}%m:%c%{$reset_color%} %# '

# load our own completion functions
# fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
# for function in ~/.zsh/functions/*; do
#   source $function
# done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Enable comments
setopt interactivecomments

bindkey -e
# vi mode
# bindkey -v
# bindkey "^F" vi-cmd-mode
# bindkey jj vi-cmd-mode

# additions from http://dougblack.io/words/zsh-vi-mode.html
# function zle-line-init zle-keymap-select {
#     VNORM="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
#     VMAIN="%{$fg_bold[blue]%} [% INSERT]% %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VNORM}/(main|viins)/$VMAIN}"
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select
# export KEYTIMEOUT=1

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
