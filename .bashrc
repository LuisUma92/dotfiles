# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

. "$HOME/.local/share/../bin/env"

export PATH=/usr/local/texlive/2025/bin/x86_64-linux:/home/luis/.spack/bin:$PATH
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH

alias set432fm="sh /home/luis/.local/share/umas/set432fm.sh"
alias config='/usr/bin/git --git-dir=/home/luis/.cfg/ --work-tree=/home/luis'
alias inittexp='/home/luis/.config/mytex/inittex.sh'

# Start the SSH agent
# eval "$(ssh-agent -s)"

# Add SSH keys
# ssh-add ~/.ssh/lenovo_id
