# Fish shell aliases and functions

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# System aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Package management
alias pacman='sudo pacman'
alias yay='yay --color=always'
alias paru='paru --color=always'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Hyprland shortcuts
alias hypr='hyprctl'
alias hypr-workspaces='hyprctl workspaces'
alias hypr-monitors='hyprctl monitors'
alias hypr-clients='hyprctl clients'

# Quick config edits
alias edit-hypr='nvim ~/.config/hypr/hyprland.conf'
alias edit-waybar='nvim ~/.config/waybar/config'
alias edit-kitty='nvim ~/.config/kitty/kitty.conf'
alias edit-nvim='nvim ~/.config/nvim/init.lua'

# System monitoring
alias htop='btop'
alias mem='free -h'
alias disk='df -h'

# Network
alias myip='curl -s https://ipinfo.io/ip'
alias ping='ping -c 3'

# Weather (if you have wttr.in)
alias weather='curl -s wttr.in'

# Functions
function mkcd
    mkdir -p $argv && cd $argv
end

function backup-config
    tar -czf ~/config-backup-$(date +%Y%m%d-%H%M%S).tar.gz ~/.config
    echo "Configuration backed up!"
end

function update-system
    sudo pacman -Syu
    yay -Sua
    sudo pacman -Sc
    yay -Sc
end 