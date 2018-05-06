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


# print packages that needs and update for
# arch based systems with pacman
print_updates_arch() {
    # get the update count with counting lines of the
    # packages that needs updtes from pacman
    local update_count=$( pacman -Qu | wc -l )

    # print the module headline
    printf "Pacman Updates\n"

    # if there are updates
    if [[ "$update_count" != 0 ]]; then
        # print and indented list of the updates
        print_indented pacman -Qu
    else
        # if there are not updates, print it either
        print_indented printf "No updates available\n"
    fi
}
