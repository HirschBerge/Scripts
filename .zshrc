echo -e "Kono Hirschy da!" | lolcat
fortune |cowsay -f dragon| lolcat
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
ssh
dir
vcs
newline
status
)


 [ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'
#source  ~/powerlevel9k/powerlevel9k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

HOMEBREW_FOLDER="/usr/local/share"
source "/home/hirschy/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/home/hirschy/zsh-autosuggestions"
source "/home/linuxbrew/.linuxbrew/Cellar/zsh-history-substring-search/1.0.2"
source "/home/hirschy/zsh-git-prompt/zshrc.sh"

PROMPT='%B%m%~%b$(git_super_status) %# '
autoload -Uz compinit;
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

#History setup
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


setopt nonomatch
setopt appendhistory
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate #enable approximate matches for completion

autoload -Uz compinit;compinit -i


# Aliases



alias -g G='| grep -i'
alias -s {txt,list,log}=vim
alias -s {mp4,mkv,mp3}='mpv'
alias ifc='sudo ifconfig'
alias htop='htop | lolcat'
alias speedtest='speedtest-cli-esm'
alias watch='mpv '
alias dload='python3 /home/hirschy/downloader-cli/download.py'
alias youtube-dl='youtube-dl --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4'
#alias neofetch='neofetch | lolcat'
alias ranger='ranger | lolcat'
alias manga='cd /home/hirschy/Documents/Manga'
alias ll='ls -la | lolcat'
alias pacup='sudo pacman -Syu'
alias zshrc='editZsh'
alias dtop='cd ~/Desktop'
alias dloads='cd ~/Downloads'
alias vi='vim'
alias pacstall='yes | sudo pacman -S'
alias x='sudo chown -R hirschy:hirschy /home/hirschy/* ; exit'
alias c='clear'
alias etrash='sudo rm -rf ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
alias 775='chmod -R 775'
alias dd='dd status=progress'
alias nmap='nmap --open'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
#alias grep='grep --color'
alias c='clear'
alias find='time find'
alias mv='mv -i'
alias cp='cp -i'
alias hi='echo "Hello there $USER"| lolcat'
alias python="python3"
alias pip="pip3"

# Git aliases
alias gi="git init"
alias gs="git status -sbu"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git push"
alias gm="git merge"
alias ga="git add ."
alias gcm="git commit -m"
alias gpl="git pull"
alias gst="git stash"
alias gstl="git stash list"
alias glg='git log --graph --oneline --decorate --all'

# key bindings
bindkey '\e[OH' beginning-of-line
bindkey '\e[OF' end-of-line
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

sourceZsh(){
    source ~/.zshrc
    backupToGitHub ~/.zshrc
    echo "New .zshrc sourced."
}

editZsh(){
    vim ~/.zshrc
    source ~/.zshrc
    backupToGitHub ~/.zshrc
    echo "New .zshrc sourced."
}

backupToGitHub(){
    echo -e "yes" | cp "$1" /home/$USER/my-dotfiles
    cd /home/$USER/my-dotfiles
    git commit -am "Updated!!"
    sudo git push -u origin master
    cd -
    echo "New .zshrc backed up to Github."
}

watch(){
	mpv \"$1\"
}






# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
