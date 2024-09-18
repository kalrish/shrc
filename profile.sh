# This script is sourced by sh-derived shells like Bash invoked as a login shell.


# User locale preferences are best set as environment variables in [JSON user records](https://systemd.io/USER_RECORD).
# A different solution is required for users defined in `/etc/passwd`.
# Arch Linux has sh-derived login shells source `${XDG_CONFIG_HOME}/locale.conf` and export the locale variables set therein.
# The code below extends that mechanism to other distros.
if test -f "${XDG_CONFIG_HOME:-${HOME}/.config}/locale.conf"
then
	. -- "${XDG_CONFIG_HOME:-${HOME}/.config}/locale.conf"
	export \
		-- \
		LANG \
		LANGUAGE \
		LC_ADDRESS \
		LC_COLLATE \
		LC_CTYPE \
		LC_IDENTIFICATION \
		LC_MEASUREMENT \
		LC_MESSAGES \
		LC_MONETARY \
		LC_NAME \
		LC_NUMERIC \
		LC_PAPER \
		LC_TELEPHONE \
		LC_TIME \
		#
fi
