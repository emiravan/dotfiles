# ╒════════════════════════════════════════════════════════════╕
# │                        ~/.zshrc                            │
# ╘════════════════════════════════════════════════════════════╛

# ╒════════════════════════════════════════════════════════════╕
# │                          GENERAL                           │
# ╘════════════════════════════════════════════════════════════╛
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export GREP_OPTIONS="--color=auto"
export PATH=/opt/homebrew/bin:$PATH

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=9999
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# ╒════════════════════════════════════════════════════════════╕
# │                           APPEARANCE                       │
# ╘════════════════════════════════════════════════════════════╛
ZSH_THEME="dst"
export BAT_STYLE="plain"
export BAT_THEME="Monokai Extended"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ╒════════════════════════════════════════════════════════════╕
# │                          PLUGINS                           │
# ╘════════════════════════════════════════════════════════════╛
plugins=(zsh-syntax-highlighting zsh-autosuggestions vi-mode web-search)

# Optimize autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_USE_ASYNC=1

# OMZ
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# ╒════════════════════════════════════════════════════════════╕
# │                           FZF                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(fzf --zsh)"

# Theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#383830,bg:#272822,spinner:#a1efe4,hl:#66d9ef"\
" --color=fg:#a59f85,header:#66d9ef,info:#f4bf75,pointer:#a1efe4"\
" --color=marker:#a1efe4,fg+:#f5f4f1,prompt:#f4bf75,hl+:#66d9ef"

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for listing path candidates.
_fzf_compgen_path() {  fd --hidden --exclude .git . "$1"}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {  fd --type=d --hidden --exclude .git . "$1"}

# Fzf-Git
if [ -f ~/scripts/fzf-git.sh ]; then
    source ~/scripts/fzf-git.sh
fi

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

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

# ╒════════════════════════════════════════════════════════════╕
# │                        Zoxide                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(zoxide init zsh)"

# ╒════════════════════════════════════════════════════════════╕
# │                        Aliases                             │
# ╘════════════════════════════════════════════════════════════╛
alias cat='bat'
alias cd='z'
alias v='nvim'
alias c='clear'
alias mkdir='mkdir -pv'
alias update='brew update && brew upgrade'
alias reload='source ~/.zshrc'

alias yt="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo+bestaudio'"
alias yt1080="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=1080]+bestaudio'"
alias yt720="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=720]+bestaudio'"
alias yt480="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=480]+bestaudio'"
alias yt360="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=360]+bestaudio'"
alias yt144="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=144]+bestaudio'"
alias ytm="yt-dlp -o '~/Music/%(title)s.%(ext)s' -f bestaudio"

alias ls="EXA_ICON_SPACING=2 eza --color=always --group-directories-first --long --icons=always --no-user --no-permissions --no-time"
alias ll="ls -la"
alias tree='EXA_ICON_SPACING=2 eza --tree --level=2 --color=always --group-directories-first --icons'

# ╒════════════════════════════════════════════════════════════╕
# │                           YAZI                             │
# ╘════════════════════════════════════════════════════════════╛
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ╒════════════════════════════════════════════════════════════╕
# │                           FINDER                           │
# ╘════════════════════════════════════════════════════════════╛
function ofd {
  if (( ! $# )); then
    open_command $PWD
  else
    open_command $@
  fi
}
