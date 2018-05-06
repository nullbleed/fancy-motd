#!/bin/bash
#
# motd
#
# Fancy motd status inspired
# by /r/unixporn
#
# (c) 2018 Daniel Jankowski


# import the utils module
source modules/utils.bash


# print the filesystem usage of different
# defined mount points from the FILESYSTEMS
# array
#
# it prints a status line and a bar that
# depicts the current usage
print_filesystems() {
    # print the headline from df
    printf "Filesystems              total   used  free  free mount point\n"

    local df_output=$( df -h  )

    # split the temperatures string at the newline
    readarray -t filesystem_lines <<<"$df_output"
 
    for filesystem in "${FILESYSTEMS[@]}"; do
        # print everything after the headline, but indented
        print_indented df -h "$filesystem" | tail -n 1

        # save the used percentage of the root partition
        local disk_usage_percent=$( df -h "$filesystem" | grep -oP '(?<= )\d+(?=%)' )

        # print and indented bar
        print_indented draw_bar "$disk_usage_percent"
    done

}
