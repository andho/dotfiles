#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

export PROMPT_COMMAND="pwd > /tmp/whereami"

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export ANDROID_AVD_HOME=~/.android/avd
export TERMINAL=alacritty
export PATH=$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/go/bin
export PATH=$PATH:$HOME/.maestro/bin
