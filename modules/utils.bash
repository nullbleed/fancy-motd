#!/bin/bash
#
# motd
#
# Fancy motd status inspired
# by /r/unixporn
#
# (c) 2018 Daniel Jankowski


# print everything that is given as argument
# with two spaces indented
print_indented() {
    sed "s/^/  /" <($*);
}


# draws a status/progress bar with a
# character count of 50 characters
#
# @param $percent between 0 and 100
draw_bar() {
    # save the percent argument for this function
    declare percent="$1"

    # pin the bar width to 50 characters
    local bar_width=50

    # color definitions
    #TODO: config file
    local color_used='\e[32;5;1m'
    local color_free='\e[1;30;1m'
    local color_reset='\e[0m'

    # initialize the color-state:
    #
    #   0: uninitialized
    #   1: color_used
    #   2: color_free
    local used_color=0

    # print the starting bar character
    printf "["

    # iterate through every character of the bar
    for i in $( seq 0 "$bar_width" ); do
        # if the used color should be used and its not used...
        if [[ $(( $i * 2 )) -le $percent && $used_color != 1 ]]; then
            # use it
            printf "$color_used"

            # save the color state
            used_color=1
        # if the free color should be used and its not used...
        elif [[ $(( $i * 2 )) -ge $percent && $used_color != 0 ]]; then
            # ...use it
            printf "$color_free"

            # save the color state
            used_color=2
        fi

        # print the bar character
        printf "="
    done

    # reset the color and print the closing bar character
    printf "$color_reset]\n"

}
