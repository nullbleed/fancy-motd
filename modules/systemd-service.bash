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


# returns whether a systemd service is
# active or not
#
# @oaram @service_name the name of the systemd service
is_service_active() {
    # save the service name argument for this function
    declare service_name="$1"

    # if systemctl prints, that it's not active return 0...
    [[ "$( systemctl is-active "$service.service" )" = "active" ]] \
        && return 0 \
        || return 1 # ...else return 1 if its active
}


# print the current systemd service status
# from services defined in the SERVICES
# array. If a service is inactive it
# is displayed red.
print_systemd_services_status() {
    # some color definitions
    #TODO: define them in a config file
    local color_active='\e[32;5;1m'
    local color_inactive='\e[38;5;1m'
    local color_reset='\e[0m'

    printf "Services Running:\n"

    # iterate through every configured service
    for service in "${SERVICES[@]}"; do
        # check if the service is active...
        if is_service_active "$service" ; then
            # ...and print the status
            printf "  $service ${color_active}● active${color_reset}\n"
        else
            # ...and print the status
            printf "  $service ${color_inactive}● inactive${color_reset}\n"
        fi
    done
}
