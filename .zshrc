# === Environment Variables ===
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export PATH="/opt/homebrew/bin:$PATH"
export C_INCLUDE_PATH="/opt/homebrew/include/SDL2"
export LIBRARY_PATH="/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export MANPAGER="nvim +Man!"

# === History Settings ===
export HISTSIZE=10000
export SAVEHIST=9999
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE

# === Appearance & Style ===
ZSH_THEME="dst"
export BAT_STYLE="plain"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# === Plugins ===
plugins=(zsh-autocomplete zsh-syntax-highlighting web-search macos)

# === Oh-My-Zsh ===
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# === External Tools ===
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# === Aliases ===
alias cat='bat'
alias cd='z'
alias v='nvim'
alias python='python3'
alias update='brew update && brew upgrade'

# yt-dlp presets
alias yt="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo+bestaudio'"
alias yt1080="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo[height<=1080]+bestaudio'"
alias yt720="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo[height<=720]+bestaudio'"
alias yt480="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo[height<=480]+bestaudio'"
alias yt360="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo[height<=360]+bestaudio'"
alias yt144="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f 'bestvideo[height<=144]+bestaudio'"
alias ytm="yt-dlp -o '~/Desktop/%(title)s.%(ext)s' -f bestaudio"

# eza presets
alias ls="EXA_ICON_SPACING=2 eza --color=always --group-directories-first --long --icons=always --no-user --no-permissions --no-time"
alias tree='EXA_ICON_SPACING=2 eza --tree --level=2 --color=always --group-directories-first --icons'
alias treee='EXA_ICON_SPACING=2 eza --tree --level=3 --color=always --group-directories-first --icons'

# yazi file manager wrapper with directory persistence
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# === Conda Initialization ===
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
