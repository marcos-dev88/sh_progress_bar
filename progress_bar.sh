#!bin/bash

# use a command with '&' after like: go build &

# this command, is used to get last proccess in bg with '&'
pid=$!

directory="bin"

green_color='\e[32m'
light_grey_color='\e[37m'


BAR="█"

bar_loaded_length=4
bar_unloaded_length=$(($bar_loaded_length * 10))

inc_bar_item="$green_color█"
unloading_status_item="$light_grey_color█"

total_size=40
size_value_counter=0

progress_bar() {
	percent_bar=$(("$1*100/${total_size}*100"/100))

	loaded_bar=$(("${percent_bar}*${bar_loaded_length}"/10))
 
	unloaded_bar=$(($bar_unloaded_length-$loaded_bar))
	
	loading_status=$(printf "%${loaded_bar}s")

	unloading_status=$(printf "%${unloaded_bar}s")

	echo -ne "Building... ${loading_status// /$inc_bar_item}${BAR:i++%${#BAR}:1}${unloading_status// /$unloading_status_item} (${percent_bar}%)\r"
}

# To increment data in total_size variable, you can use a while loop to increment while it's going to /dev/null
# 	while ps -p $pid &>/dev/null ; do
#		total_size=$(($total_size+1))
#	done

while [[ ${size_value_counter} -lt ${total_size} ]] ; do
	sleep .1
	size_value_counter=$(($size_value_counter+1))
	if [[ "${size_value_counter}" == "${total_size}" ]]; then
		BAR="█"
	fi

	progress_bar $size_value_counter
done

# Special thanks to:
# The Kettlemaker - https://www.youtube.com/watch?v=1j02lwBNxlw
# https://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script
