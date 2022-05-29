# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/astro/.zshrc'

# auto tab complete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# End of lines added by compinstall

########### PATH setting ##########
export PATH=~/.local/bin:~/llvm/bin:~/scripts:${PATH}

########### XDG standards to organize HOME dot files ##########
export XDG_DATA_HOME=~/.local/share
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache

########## library and builf flags ##########
export LD_LIBRARY_PATH=~/.local/lib
# export C_INCLUDE_PATH=~/.local/include
# export CPLUS_INCLUDE_PATH=~/.local/include
# export LIBRARY_PATH=~/.local/lib

########## Editor ##########
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

########## alias and functions to be loaded ###########
[[ -f ~/.zsh/functions ]] && source ~/.zsh/functions
[[ -f ~/.zsh/alias ]] && source ~/.zsh/alias

########## ZSH plugins ###########
export ADOTDIR='/home/astro/.zsh/antigen'
source ~/.zsh/antigen.zsh
antigen bundle git
antigen bundle extract
antigen bundle tmux
antigen bundle z
antigen bundle voronkovich/gitignore.plugin.zsh
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

########### software specific ##########
# nnn
export NNN_BMS="h:$HOME;c:$HOME/.config;l:$HOME/.local/;w:$HOME/work;d:/mnt/f/Downloads/"
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='P:preview-tui;f:finder;x:!chmod +x $nnn;g:-!git diff;p:-!less -iR $nnn*'
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v fd >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
