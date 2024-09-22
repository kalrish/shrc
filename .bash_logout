# This script is executed by GNU Bash before it exits when started as a login shell.
#
# info:(bash)Bash_Startup_Files
# man:bash(1)


# Execute logout script for POSIX shells invoked as login shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
source \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/logout.sh" \
	#
