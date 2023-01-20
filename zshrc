# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

AGNOSTER_PROMPT_SEGMENTS=("prompt_git")
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.


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
#plugins=(git docker fd vi-mode)
plugins=(vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

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
alias ssh='TERM=xterm-color ssh'

# Config from bashrc
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

#export PROMPT_COMMAND="pwd > /tmp/whereami"
# bashrc end

_save_location() {
    pwd > /tmp/whereami
}

(( $+functions[add-zsh-hook] )) || autoload -Uz add-zsh-hook
add-zsh-hook chpwd _save_location
add-zsh-hook precmd _save_location

alias ls='ls --color=auto'
alias vim='nvim'
#alias elm-language-server='docker run --rm -it -v $(pwd)/app:/app -w /app --user 1000:1000 elm elm-language-server'

DISABLE_UNTRACKED_FILES_DIRTY="true"

# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export ANDROID_AVD_HOME=~/.android/avd
export TERMINAL=alacrity
export EDITOR=nvim
export PATH=$PATH:$HOME/.local/bin
export PIPENV_VENV_IN_PROJECT=1
#export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

# bevy
export AMD_VULKAN_ICD=RADV
export WINIT_UNIX_BACKEND=wayland

#source $HOME/dev/projects/own/quick-switch/quick-switch
progl() {
  export LD_LIBRARY_PATH="/home/$USER/.local/lib/amdgpu-pro-libgl:${LD_LIBRARY_PATH}"
  export LIBGL_DRIVERS_PATH="/home/$USER/.local/lib/amdgpu-pro-libgl/dri"
  export dri_driver="amdgpu"
}

passgen() {
    local length=${1:-14}
    < /dev/urandom tr -dc "A-Za-z0-9\-_:" | head -c${length}; echo
}

alias urlencode="python -c \"import urllib.parse;print (urllib.parse.quote(input()))\""

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export PATH=$PATH:$HOME/.local/bin:$HOME/go/bin

export SSH_CA_FILES=$HOME/dev/infra/allied/ssh-ca
export SSL_FILES=$HOME/dev/infra/allied/ssl

export PATH=$PATH:$HOME/.maestro/bin
