#!bin/bash

# use a command with '&' after like: go build &

# this command, is used to get last proccess in bg with '&'
pid=$!

directory="bin"

green_color='\e[32m'
light_grey_color='\e[37m'


BAR="█"

inc_bar_item="$green_color█"
left_bar_item="$light_grey_color█"

total_size=100
size_value_counter=0

progress_bar() {
	percent_bar=$(("$1*100/${total_size}*100"/100))

	progress=$(("${percent_bar}*4"/10))

	remain=$((40-progress))

	completed=$(printf "%${progress}s")

	left_bar=$(printf "%${remain}s")

	echo -ne "Building... ${completed// /$inc_bar_item}${BAR:i++%${#BAR}:1}${left_bar// /$left_bar_item} (${percent_bar}%)\r"
}

# To increment data in total_size variable, you can use a while loop to increment while it's going to /dev/null
# 	while ps -p $pid &>/dev/null ; do
#		total_size=$(($total_size+1))
#	done

while [[ ${size_value_counter} -lt ${total_size} ]] ; do
	sleep .1
	size_value_counter=$(($size_value_counter+1))
	if [[ "${size_value_counter}" == "${total_size}" ]]; then
		BAR="*"
	fi

	progress_bar $size_value_counter
done

# Special thanks to:
# The Kettlemaker - https://www.youtube.com/watch?v=1j02lwBNxlw
# https://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script
