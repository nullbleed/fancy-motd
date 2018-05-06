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


# pretty print the hostname with
# figlet and indent the ascii art
# with two spaces
print_hostname() {
    # print the hostname with figlet
    print_indented echo "$HOSTNAME" | figlet
}
