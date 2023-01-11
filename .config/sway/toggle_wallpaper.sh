#!/usr/bin/env bash
#
if ( readlink $HOME/.config/sway/active_wallpaper | grep private &>/dev/null )
then
	ln -sf $HOME/.config/sway/wallpaper_profiles/work $HOME/.config/sway/active_wallpaper
elif ( readlink $HOME/.config/sway/active_wallpaper | grep work &>/dev/null )
then
	ln -sf $HOME/.config/sway/wallpaper_profiles/private $HOME/.config/sway/active_wallpaper
fi

swaymsg 'output * bg $HOME/.config/sway/active_wallpaper fill'
