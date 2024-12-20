# ╒════════════════════════════════════════════════════════════╕
# │                        ~/.zshrc                            │
# ╘════════════════════════════════════════════════════════════╛

# ╒════════════════════════════════════════════════════════════╕
# │                          GENERAL                           │
# ╘════════════════════════════════════════════════════════════╛
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export BROWSER="brave"
export MANPAGER="nvim +Man!"
export GREP_OPTIONS="--color=auto"

# History
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=200000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# ╒════════════════════════════════════════════════════════════╕
# │                           THEME                            │
# ╘════════════════════════════════════════════════════════════╛
ZSH_THEME="dst"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
export BAT_STYLE="plain"
export BAT_THEME="Solarized (dark)"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ╒════════════════════════════════════════════════════════════╕
# │                          PLUGINS                           │
# ╘════════════════════════════════════════════════════════════╛
plugins=(zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete zsh-autopair)

# OMZ
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 13

# ╒════════════════════════════════════════════════════════════╕
# │                           FZF                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(fzf --zsh)"

# Theme
export FZF_DEFAULT_OPTS='
    --color fg:-1,bg:-1,hl:#268bd2,fg+:#eee8d5,bg+:#073642,hl+:#268bd2
    --color info:#b58900,prompt:#b58900,pointer:#fdf6e3,marker:#fdf6e3,spinner:#b58900
'

# Search
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Preview
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_OPTS="--bind 'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Custom
_fzf_compgen_path() {  fd --hidden --exclude .git . "$1"}

_fzf_compgen_dir() {  fd --type=d --hidden --exclude .git . "$1"}

# Fzf-Git
if [ -f ~/scripts/fzf-git.sh ]; then
  source ~/scripts/fzf-git.sh
fi

# ╒════════════════════════════════════════════════════════════╕
# │                        Zoxide                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(zoxide init zsh)"

# ╒════════════════════════════════════════════════════════════╕
# │                        Aliases                             │
# ╘════════════════════════════════════════════════════════════╛
alias cat='bat'
alias rm='trash-put'
alias cd='z'

alias yt="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=1080]+bestaudio/best'"
alias yt720="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=720]+bestaudio/best'"
alias yt480="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=480]+bestaudio/best'"
alias yt360="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=360]+bestaudio/best'"
alias yt144="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=144]+bestaudio/best'"
alias ytm="yt-dlp -o '~/Music/%(title)s.%(ext)s' -f bestaudio"

alias ls="EXA_ICON_SPACING=2 eza --color=always --group-directories-first --long --git --icons=always --no-user --no-permissions --no-time"
alias tree='EXA_ICON_SPACING=2 eza --tree --level=2 --color=always --group-directories-first --icons'
alias dots="eza -a | grep -E '^\.'"

# ╒════════════════════════════════════════════════════════════╕
# │                         Conda                              │
# ╘════════════════════════════════════════════════════════════╛
__conda_setup="$('/home/emir/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/emir/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/emir/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/emir/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# ╒════════════════════════════════════════════════════════════╕
# │                          Yazi                              │
# ╘════════════════════════════════════════════════════════════╛
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
