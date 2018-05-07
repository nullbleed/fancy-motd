#!/bin/bash
#
# motd
#
# Fancy motd status inspired
# by /r/unixporn
#
# (c) 2018 Daniel Jankowski


# print the last login of the current
# user
print_last_login() {
    # print the module title
    printf "Last Login:\n"

    # get the latest login from lastlog
    login=$( lastlog -u $USER \
        | tail -n1 \
        | gawk '{print $3" "$4" "$5" "$6" "$8" on "$2}'
    )

    # print the status for the current user
    printf "  $USER at $login\n"
}
