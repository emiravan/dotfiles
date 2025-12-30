export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"
export C_INCLUDE_PATH="/opt/homebrew/include/SDL2"
export LIBRARY_PATH="/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="code"

ZSH_THEME="peepcode"

zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'show-group' no
zstyle ':omz:update' mode auto

plugins=(eza zoxide fzf macos)

source $ZSH/oh-my-zsh.sh

alias cd='z'
alias update='brew update && brew upgrade'
alias yt="yt-dlp -o '~/Downloads/%(title)s.%(ext)s' -f 'bestvideo+bestaudio'"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}