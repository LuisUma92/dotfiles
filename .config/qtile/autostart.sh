#!/usr/bin/env bash 

# festival --tts $HOME/.config/qtile/welcome_msg &
# lxsession &
picom &
# /usr/bin/emacs --daemon &
# conky -c $HOME/.config/conky/doomone-qtile.conkyrc
volumeicon &
nm-applet &
ulauncher &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
# xargs xwallpaper --stretch < ~/.xwallpaper &
# xwallpaper --zoom ~/Pictures/wp/nord-fox.jpg &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
nitrogen --restore &

cloudflared access smb --hostname smb.luisumana.top --url localhost:8446 &

/opt/Agente-GAUDI/Agente-GAUDI &
