# This script is executed by the KornShell when started as an interactive non-login shell.
#
# man:ksh(1)


# Execute startup script for POSIX shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
. \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/startup.sh" \
	#
