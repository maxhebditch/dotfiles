# Set up the prompt

# comment in to test speed
# zmodload zsh/zprof

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
fpath=(~/.zsh/completion $fpath)
fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# pipx autocomplete
eval "$(register-python-argcomplete pipx)"

# Color alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fd='fd --follow'

# Vim stiff
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim

# Atuin
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# fnm/zvm
FNM_PATH="/home/max/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/max/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
# eval "$(fnm env --use-on-cd)"

# batcat
alias bat="batcat"

# themes
GTK_THEME=Breeze-max
export GTK_THEME

# ssh
source ~/.ssh/ssh-agent-init.sh
# gpg
export GPG_TTY=$(tty)

# shred functions
shredder() {
    if [ $# -eq 0 ]; then
        echo "Error: No file or directory specified."
        echo "Usage: shredder <file1|dir1> [file2|dir2] [file3|dir3] ..."
        return 1
    fi

    for target in "$@"; do
        if [ -d "$target" ]; then
            echo "Shredding directory: $target"
            # Use -mindepth 1 to avoid trying to shred the target directory itself
            find "$target" -mindepth 1 -type f -print0 | xargs -0 shred -u -z -v -n 3
            # Check if any files couldn't be shredded
            remaining_files=$(find "$target" -type f)
            if [ -n "$remaining_files" ]; then
                echo "Warning: Some files in $target could not be shredded:"
                echo "$remaining_files"
            fi
            # Remove empty directories
            find "$target" -mindepth 1 -type d -empty -delete
            # Check if the target directory is now empty
            if [ -z "$(ls -A "$target")" ]; then
                rmdir "$target" && echo "Directory $target has been shredded and removed." || echo "Warning: Could not remove empty directory $target."
            else
                echo "Warning: Directory $target could not be fully removed. It may contain non-regular files or have permission issues."
            fi
        elif [ -f "$target" ]; then
            echo "Shredding file: $target"
            if shred -u -z -v -n 3 "$target"; then
                echo "Successfully shredded and removed: $target"
            else
                echo "Error occurred while shredding: $target"
            fi
        elif [ -e "$target" ]; then
            echo "Error: $target exists but is not a regular file or directory. It cannot be safely shredded."
        else
            echo "Error: $target does not exist."
        fi
    done
}

# comment in to test speed
# zprof


# Created by `pipx` on 2024-08-15 17:11:49
export PATH="$PATH:/home/max/.local/bin"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
