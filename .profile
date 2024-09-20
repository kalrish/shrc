# This script is meant to be executed by POSIX shells when invoked as login shells unless they execute a script specific to them, like GNU Bash does with `~/.bash_profile`.
# Such shells are:
#
# - the Debian Almquist Shell (dash); and
# - the KornShell (ksh).
#
# man:dash(1)
# man:ksh(1)


# Execute startup script for POSIX shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
. \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/startup.sh" \
	#
