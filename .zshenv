# This script is executed by Zsh on startup.
#
# man:zsh(1)


# Have Zsh load user startup and shutdown scripts from the directory designated by the XDG Base Directory specification for user-specific configuration files.
#
# man:zsh(1)
# https://specifications.freedesktop.org/basedir-spec/latest/
ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

# Execute startup script for POSIX shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
. \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/startup.sh" \
	#
