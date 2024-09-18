# info:(bash)Bash_Startup_Files
# man:bash(1)

# This script is sourced by Bash when invoked as a login shell.


# Bash ignores `~/.profile` if it finds `~/.bash_profile`.
# By loading `~/.profile` manually, initialization for all sh-derived shells may be kept in `~/.profile`.
if [[ -f ~/.profile ]]
then
	source -- ~/.profile
fi


# Bash sources `~/.bashrc` only when invoked as a non-login shell and ignores the script when started as a login shell.
# Source `~/.bashrc` on Bash login shells too
if [[ -f ~/.bashrc ]]
then
	source -- ~/.bashrc
fi
