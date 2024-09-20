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
