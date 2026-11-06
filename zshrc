# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Completion: tab cycles through candidates with menu selection
autoload -Uz compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
bindkey -M menuselect '\e[Z' reverse-menu-complete

# Up/Down arrow: prefix-based history search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Accept autosuggestion with Tab, fall back to completion if no suggestion
# First tab shows candidates, second tab starts cycling through them
autosuggest-accept-or-complete() {
    if [[ -n "$POSTDISPLAY" ]]; then
        zle autosuggest-accept
    else
        zle expand-or-complete
    fi
}
zle -N autosuggest-accept-or-complete
bindkey '\t' autosuggest-accept-or-complete

# Treat only alphanumerics as word characters (stop at /, -, etc.)
WORDCHARS=''

# Option+Delete to delete previous word
bindkey '\e\x7f' backward-kill-word

# Aliases
alias jj='ssh joon@joonjune.iptime.org'
alias py='python'
alias st=streamlit

alias jn="jupyter notebook"

function gitp() {
    git add "$1"
    git commit -m "update"
    git push
}

alias vd="vimdiff -c 'set diffopt+=iwhite' -c 'syntax on'"
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gc="git commit"
alias gcm"git commit -m"
alias ga="git add"
alias gp="git push"

alias ngrok="/Users/joonsu/Downloads/ngrok"
alias cdconf="cd /Users/joonsu/main/personal/workspace/configurations"

alias adb="/Users/joonsu/Library/Android/sdk/platform-tools/adb"
alias cdblux="cd /Users/joonsu/main/works/blux/workspace"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

eval "$(zoxide init zsh)"

alias ngrok="/opt/homebrew/bin/ngrok"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

alias ls='lsd'
alias ll='ls -alhF'
alias lt='ls --tree'

. "$HOME/.local/bin/env"
eval "$(/opt/homebrew/bin/brew shellenv)"

alias c="claude --allow-dangerously-skip-permissions --remote-control"
alias crf="c --fork-session --resume"
alias ur="uv run python"

# Starship prompt (keep at end)
eval "$(starship init zsh)"

# sentry
fpath=("/Users/joonsu/.local/share/zsh/site-functions" $fpath)

# Blux CLI completion
eval "$(_BX_COMPLETE=zsh_source bx)"

# Blux CLI shared secrets — lazy load on first bx call (not at shell start).
# Skips `bx secrets ...` itself to avoid recursing through the wrapper.
bx() {
  if [[ "$1" != "secrets" && -z "$_BX_SECRETS_LOADED_GUARD" ]]; then
    eval "$(command bx secrets export 2>/dev/null)"
    export _BX_SECRETS_LOADED_GUARD=1
  fi
  command bx "$@"
}

export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"
alias tig="tig --all"
