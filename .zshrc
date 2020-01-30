# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ ! -d $HOME/.zgen ]]; then
  git clone git@github.com:tarjoilija/zgen.git "$HOME/.zgen"
fi

export ZGEN_RESET_ON_CHANGE=($HOME/.zshrc)
export ZGEN_PLUGIN_UPDATE_DAYS=30
export ZGEN_SYSTEM_UPDATE_DAYS=30
export NVM_LAZY_LOAD=true

source "$HOME/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/autojump
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/shrink-path
  zgen oh-my-zsh plugins/kubectl
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/terraform

  zgen load romkatv/powerlevel10k powerlevel10k

  zgen loadall <<EOPLUGINS
    lukechilds/zsh-nvm
    johanhaleby/kubetail
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
EOPLUGINS

  # generate the init script from plugins above
  zgen save
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git shrink-path kubectl kubetail)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias kx="kubectx"

DEFAULT_USER=`whoami`

source ~/dotfiles/secret-keys.sh

export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.local/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#[ -s "$ZSH/custom/plugins/kubetail/completion/kubetail.bash" ] && source "$ZSH/custom/plugins/kubetail/completion/kubetail.bash"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
