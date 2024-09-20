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

# Execute startup script for POSIX shells invoked as login shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
. \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/login.sh" \
	#

# Execute startup script for interactive shells if the current (login) shell is in interactive mode.
#
# 1. First, `$-` is expanded to "the current option flags (the single-letter option names concatenated into a string) as specified on invocation, by the `set` special built-in command, or implicitly by the shell".
# 2. Then, if the expansion of `$-` starts with `*i`, the shortest match is removed.
# 3. Finally, the result is compared with the expansion of `$-`.
#
# https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_05_02
# https://specifications.freedesktop.org/basedir-spec/latest/
if test "${-#*i}" != "$-"
then
	. \
		"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/interactive.sh" \
		#
fi
