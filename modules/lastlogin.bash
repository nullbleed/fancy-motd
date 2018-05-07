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

    # print the last login for every user
    # configured in the USERS array
    for user in "${USERS[@]}"; do
        # get the latest login from lastlog
        login=$( lastlog -u $user \
            | tail -n1 
        )

        # print the status for the current user
        printf "  $login\n"
    done
}
