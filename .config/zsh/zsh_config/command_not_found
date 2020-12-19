# Search for matching packages when an unknown command is executed
command_not_found_handler() {
	local cmd="$1"
	echo 'Command not found:' "$cmd" # print command not found asap, then search for packages
	if [[ `pacman -Ss $cmd` != "" ]]; then
		echo -e "\033[1;37mThe program \033[1;35m$cmd \033[1;37mcan be installed using pacman"
		return 1
	fi
}