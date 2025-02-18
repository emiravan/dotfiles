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
export HISTSIZE=10000
export SAVEHIST=9999
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE

# ╒════════════════════════════════════════════════════════════╕
# │                           APPEARANCE                       │
# ╘════════════════════════════════════════════════════════════╛
ZSH_THEME="dst"
export BAT_STYLE="plain"
export BAT_THEME="OneHalfDark"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ╒════════════════════════════════════════════════════════════╕
# │                          PLUGINS                           │
# ╘════════════════════════════════════════════════════════════╛
plugins=(zsh-syntax-highlighting zsh-autocomplete web-search macos)

# OMZ
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# ╒════════════════════════════════════════════════════════════╕
# │                           FZF                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#353b45,bg:#282C34,spinner:#56b6c2,hl:#61afef"\
" --color=fg:#565c64,header:#61afef,info:#e5c07b,pointer:#56b6c2"\
" --color=marker:#56b6c2,fg+:#b6bdca,prompt:#e5c07b,hl+:#61afef"

# ╒════════════════════════════════════════════════════════════╕
# │                        Zoxide                              │
# ╘════════════════════════════════════════════════════════════╛
eval "$(zoxide init zsh)"

# ╒════════════════════════════════════════════════════════════╕
# │                        Aliases                             │
# ╘════════════════════════════════════════════════════════════╛
alias cat='bat'
alias cd='z'

alias yt="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo+bestaudio'"
alias yt1080="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=1080]+bestaudio'"
alias yt720="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=720]+bestaudio'"
alias yt480="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=480]+bestaudio'"
alias yt360="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=360]+bestaudio'"
alias yt144="yt-dlp -o '~/Videos/%(title)s.%(ext)s' -f 'bestvideo[height<=144]+bestaudio'"
alias ytm="yt-dlp -o '~/Music/%(title)s.%(ext)s' -f bestaudio"

alias ls="EXA_ICON_SPACING=2 eza --color=always --group-directories-first --long --icons=always --no-user --no-permissions --no-time"
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
