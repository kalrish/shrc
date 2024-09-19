# info:(bash)Bash_Startup_Files
# man:bash(1)

# This script is read and executed by GNU Bash when
#
# - Bash is invoked as an interactive non-login shell or
# - Bash is invoked by a remote shell daemon, like `sshd`,
#
# unless Bash is given the option `--norc`.


# This is executed by all interactive bash shells on startup,
# including some (e.g. scp and rcp) that don't expect any output.
# $- expands to the current option flags, that is:
#   · those specified upon invocation;
#   · those enabled by the `set` built-in; and
#   · those set by the shell itself (e.g. -i).
if [[ $- = *i* ]]
then
	# We're on an interactive shell

	declare \
		-r \
		-- \
		_term_color_foreground_blue="$(tput setaf 4)" \
		_term_color_foreground_dicky="$(tput setaf 46)" \
		_term_color_foreground_gray="$(tput setaf 243)" \
		_term_color_foreground_green="$(tput setaf 2)" \
		_term_color_foreground_lightblue="$(tput setaf 51)" \
		_term_color_foreground_orange="$(tput setaf 208)" \
		_term_color_foreground_red="$(tput setaf 1)" \
		_term_color_foreground_white="$(tput setaf 255)" \
		_term_reset="$(tput sgr0)" \
		_term_typeface_bold="$(tput bold)" \
		#

	function _in_git_repo
	{
		git \
			rev-parse \
			--is-inside-work-tree \
			&> /dev/null \
			#
	}

	function _git_prompt
	{
		if _in_git_repo
		then
			git_branch="$(
				git \
					rev-parse \
					--symbolic-full-name \
					--abbrev-ref \
					HEAD \
					2> /dev/null \
					#
			)"

			alias \
				-- \
				mv='git_command_suggestion mv --no-clobber' \
				rm='git_command_suggestion rm --interactive=always' \
				#
		else
			unset \
				-- \
				git_branch \
				#

			alias \
				-- \
				mv='mv --no-clobber' \
				rm='rm --interactive=always' \
				#
		fi
	}

	last_cwd="${PWD}"
	declare \
		-i \
		-- \
		last_exit_code=0 \
		#

	function _prompt_command
	{
		declare \
			-r \
			-i \
			-- \
			exit_code="$?" \
			#

		if [[ ${PWD} != ${last_cwd} ]]
		then
			# We have moved into a different directory
			# and could be inside a git directory now.
			update_git_prompt=y
			last_cwd="${PWD}"
		fi

		if [[ ${update_git_prompt} = y ]]
		then
			_git_prompt
			update_git_prompt=n
		fi

		PS1='\[${_term_typeface_bold}${_term_color_foreground_green}\]\u@\h\[${_term_reset}\] \[${_term_typeface_bold}${_term_color_foreground_blue}\]\w\[${_term_reset}\]'

		if [[ -v git_branch ]]
		then
			PS1+=' \[${_term_typeface_bold}${_term_color_foreground_red}\]${git_branch}\[${_term_reset}\]'

			if jira_issue_sequence="$(gira_get_sequence "${git_branch}")"
			then
				PS1+=' \[${_term_color_foreground_white}${jira_issue_sequence}${_term_reset}\]'
			fi
		fi

		if [[ ${exit_code} -ne ${last_exit_code} || ! -v exit_code_padded ]]
		then
			last_exit_code=${exit_code}

			printf \
				-v exit_code_padded \
				'%3i' \
				${exit_code} \
				#

			if [[ ${exit_code} -eq 0 ]]
			then
				exit_code_format="${_term_color_foreground_green}"
			else
				exit_code_format="${_term_typeface_bold}${_term_color_foreground_red}"
			fi
		fi

		PS1+='\n\[${_term_typeface_bold}${_term_color_foreground_orange}\]\A\[${_term_reset}\] \[${exit_code_format}\]${exit_code_padded}\[${_term_reset}\] \[${_term_typeface_bold}${_term_color_foreground_blue}\]\$\[${_term_reset}\] '
	}

	function trap_debug
	{
		# Save
		local \
			old_BASH_REMATCH=("${BASH_REMATCH[@]}") \
			#

		# Avoid syntax issues
		local git_regex='^[[:space:]]*git[[:space:]]+([^[:space:]]+)'
		if [[ ${BASH_COMMAND} =~ ${git_regex} ]]
		then
			case "${BASH_REMATCH[1]}" in
				checkout|init)
					update_git_prompt=y
					;;
			esac
		fi

		# Restore
		BASH_REMATCH=("${old_BASH_REMATCH[@]}")
	}

	function git_command_suggestion
	{
		local command="${1}"
		local command_arguments="${2}"

		#echo "Maybe you want ${_term_typeface_bold}${_term_color_foreground_green}git ${command}${_term_reset} instead"
		echo "To use ${_term_typeface_bold}${_term_color_foreground_blue}${command}${_term_reset}, invoke it through ${_term_typeface_bold}${_term_color_foreground_blue}command${_term_reset}:"
		echo "  $ ${_term_typeface_bold}${_term_color_foreground_lightblue}command${_term_reset} ${command} ${_term_color_foreground_gray}${command_arguments}${_term_reset} ..."
		echo '    ^^^^^^^'
	}

	source \
		-- \
		~/dev/own/gira/gira.sh \
		#

	_git_prompt

	trap \
		trap_debug \
		DEBUG \
		#

	PROMPT_COMMAND=_prompt_command

	PS2='\[${_term_color_foreground_gray}\]>\[${_term_reset}\] '


	# User functions and aliases

	alias \
		-- \
		cp='cp --no-clobber' \
		grep='grep --color=auto' \
		ls='ls --color=auto' \
		#

	function ggrep
	{
		grep \
			-i \
			-R \
			--exclude-dir .git \
			--exclude-dir .tup \
			-C 3 \
			-- \
			"$1" \
			. \
			#
	}
fi
