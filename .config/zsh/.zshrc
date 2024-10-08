# ~/.config/zsh/.zshrc

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"
export TODO_FILE="$HOME/.todo/todo.txt"
export MANPAGER="nvim +Man!"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
eval "$(dircolors ~/.config/zsh/.dircolors)"
export BAT_THEME="Solarized (dark)"

# Plugins
plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete zsh-autopair copybuffer)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Fzf
eval "$(fzf --zsh)"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Fzf theme
export FZF_DEFAULT_OPTS='
    --color fg:-1,bg:-1,hl:#268bd2,fg+:#eee8d5,bg+:#073642,hl+:#268bd2
    --color info:#b58900,prompt:#b58900,pointer:#fdf6e3,marker:#fdf6e3,spinner:#b58900
'

# Zoxide
eval "$(zoxide init zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.config/zsh/fzf-git.sh

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

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# Aliases
if [ -f ~/.config/zsh/aliases.shrc ]; then
  source ~/.config/zsh/aliases.shrc
fi

# Functions
if [ -f ~/.config/zsh/functions.sh ]; then
  source ~/.config/zsh/functions.sh
fi
