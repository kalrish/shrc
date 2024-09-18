# info:(bash)Bash_Startup_Files
# man:bash(1)

# This script is sourced by Bash when invoked as a login shell.


# Bash ignores `~/.profile` if it finds `~/.bash_profile`.
# By loading `~/.profile` manually, initialization for all sh-derived shells may be kept in `~/.profile`.
if [[ -f ~/.profile ]]
then
	source -- ~/.profile
fi
