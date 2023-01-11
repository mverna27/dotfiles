#!usr/bin/env bash
# Need to be run as sudo

check=$(pacman -Q wireplumber pipewire-media-session 2>/dev/null | cut -d' ' -f1)

setting="[\"api.alsa.ignore-dB\"] = "
enabled="--\[\"api\.alsa\.ignore-dB\"\] = false,"
disabled="$(echo "[\"api.alsa.ignore-dB\"] = true,")"

if [[ "${check}" -eq "wireplumber" ]]
then
	echo "Found wireplumber. Applying patch ..."
	
	# Check for existing config file
	current_config=$(echo $(cat /usr/share/wireplumber/main.lua.d/50-alsa-config.lua 2>/dev/null | fgrep "${setting}"))
	if [[ $? -ne 0 ]] ; then echo "/usr/share/wireplumber/main.lua.d/50-alsa-config.lua not found. Can't apply patch." && exit ; fi

	# Check if patch is already applied
	if [[ "${current_config}" == "${disabled}" ]] ; then echo "Patch already applied, nothing to do." && exit ; fi

	# Apply patch
	sed -i "s/${enabled}/${disabled}/g" /usr/share/wireplumber/main.lua.d/50-alsa-config.lua

	echo "Done. Reboot required for changes to take effect."

elif [[ "${check}" -eq "pipewire-media-session" ]]
then
	echo "Found pipewire-media-session. Applying patch ..."

	# Check for existing config file
	current_config=$(echo $(cat /etc/pipewire/media-session.d/alsa-monitor.conf 2>/dev/null | fgrep "${setting}"))
	if [[ $? -ne 0 ]] ; then echo "/etc/pipewire/media-session.d/alsa-monitor.conf not found. Can't apply patch." && exit ; fi

	# Check if patch is already applied
	if [[ "${current_config}" == "${disabled}" ]] ; then echo "Patch already applied, nothing to do." && exit ; fi

	# Apply patch
	sed -i "s/${enabled}/${disabled}/g" /etc/pipewire/media-session.d/alsa-monitor.conf

	echo "Done. Reboot required for changes to take effect."
else
	echo "No session manager found. Make sure wireplumber or pipewire-media-session is installed."
fi
