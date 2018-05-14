#!/bin/bash
#
# motd
#
# Fancy motd status inspired
# by /r/unixporn
#
# (c) 2018 Daniel Jankowski


# print docker container status. check
# if the container is running or not and
# print it. containers are configured in
# the CONTAINER-array
print_docker_status() {
    # some color definitions
    #TODO: define them in a config file
    local color_active='\e[32;5;1m'
    local color_inactive='\e[38;5;1m'
    local color_reset='\e[0m'

    # print the module title
    printf "Docker Status:\n"

    # get all running containers
    local running_containers="$( docker ps )"
     
    # iterate through every configured container names
    for container_name in "${CONTAINER[@]}"; do
        # check if the container is running
        local status=$( echo -n "$running_containers" | grep -oP "(?<= )$container_name$" | wc -l )

        # check if the container is running...
        if [[ "$status"  = "1" ]] ; then
            # ...and print the status
            printf "  $container_name ${color_active}● running${color_reset}\n"
        else
            # ...and print the status
            printf "  $container_name ${color_inactive}● stopped${color_reset}\n"
        fi
    done
}
