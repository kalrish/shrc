# This script is executed by GNU Bash when started as an interactive non-login shell or as a non-login shell by a remote shell daemon, like `sshd`.
#
# info:(bash)Bash_Startup_Files
# man:bash(1)


# Execute startup script for POSIX shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
source \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/startup.sh" \
	#

# Execute startup script for interactive Bash shells when started in interactive mode.
#
# Bash may execute the present script, `~/.bashrc`, as a non-interactive shell, as noted in the manual:
#
# > Bash attempts to determine when it is being run with its standard input connected to a network connection, as when executed by the historical remote shell daemon, usually `rshd`, or the secure shell daemon `sshd`.
# > If Bash determines it is being run non-interactively in this fashion, it reads and executes commands from `~/.bashrc`, if that file exists and is readable.
#
# The following conditional expression checks whether the current shell is interactive.
#
# info:(bash)Bash_Startup_Files
# info:(bash)Special_Parameters
# https://specifications.freedesktop.org/basedir-spec/latest/
if [[ "${-}" = *i* ]]
then
	source \
		-- \
		"${XDG_CONFIG_HOME:-${HOME}/.config}/bash/interactive.sh" \
		#
fi
