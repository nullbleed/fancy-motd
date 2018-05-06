#!/bin/bash
#
# motd
#
# Fancy motd status inspired
# by /r/unixporn
#
# (c) 2018 Daniel Jankowski


# print the temperature of each cpu core in the form
#
#  temp1   temp2   temp3
#
# the background color is chosen by the core temperature
#
#  green:   < 60°C
#  orange:  < 80°C  and  >= 60°C
#  red:     >= 80°C
print_cpu_core_temperatures() {
    # get the cpu core temeperatures with sensors and grep it
    # to a number per line per core
    local core_temperatures=$( sensors | grep -oP '(?<=e\s\d:\s\s\s\s\s\s\s\s\+)[\d.]+.\w' )

    # split the temperatures string at the newline
    readarray -t temperature_lines <<<"$core_temperatures"

    # print the module headline
    printf "CPU Core Temperatures\n"

    # some color definitions
    #TODO: config file
    local color_high="\e[30;48;5;196m"
    local color_norm="\e[30;48;5;208m"
    local color_low="\e[30;48;5;148m"
    local color_reset="\e[0m"

    # iterate through the cpu core temperatures
    for temperature_term in "${temperature_lines[@]}" ; do
        # get the number from XX.X°X
        local temperature=$( echo -n "$temperature_term" | sed -re 's/([0-9]+)\..*/\1/g' )

        # if the temperature is higher than 80 degree...
        if [[ "$temperature" -ge 80 ]]; then
            # ...print with red background
            printf "  ${color_high} $temperature_term ${color_reset}"
        # if the temperature is between 60 and 80 degrees...
        elif [[ "$temperature" -ge 60 ]]; then
            # print the background orange
            printf "  ${color_norm} $temperature_term ${color_reset}"
        # if the temperature is lower tha 60 degress...
        else
            # ...make it green
            printf "  ${color_low} $temperature_term ${color_reset}"
        fi
    done

    #printf "$core_temperatures\n"
    printf "\n"
}
