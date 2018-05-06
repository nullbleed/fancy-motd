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


# print the recent memory and swap usage.
#
# it prints a status line and a bar that
# depicts the current usage
print_memory_status() {
    # get memory and swap readable for humns
    local memory_total=$( free -h | tail -n2 | head -n1 | gawk '{ print $2 }' )
    local memory_used=$( free -h | tail -n2 | head -n1 | gawk '{ print $3 }' )
    local swap_total=$( free -h | tail -n1 | gawk '{ print $2 }' )
    local swap_used=$( free -h | tail -n1 | gawk '{ print $3 }' )

    # get memory and swap as numbers
    local memory_num_total=$( free | tail -n2 | head -n1 | gawk '{ print $2 }' )
    local memory_num_used=$( free | tail -n2 | head -n1 | gawk '{ print $3 }' )
    local swap_num_total=$( free | tail -n1 | gawk '{ print $2 }' )
    local swap_num_used=$( free | tail -n1 | gawk '{ print $3 }' )

    # print the module headline
    printf "Memory Status:\n"

    # calculate the memory usage in percent
    local memory_percent=$( bc -l <<< "scale=2; $memory_num_used/$memory_num_total * 100" | cut -d'.' -f1 )

    # calculate the swap usage in percent if it is not zero
    if [[ -z "$swap_num_total" ]]; then
        local swap_percent=$( bc -l <<< "scale=2; $swap_num_used/$swap_num_total * 100" | cut -d'.' -f1 )
    else
        local swap_percent=0
    fi

    # print the memory status
    printf "  Memory  [ $memory_used/$memory_total ]\n"

    # print a bar indented
    print_indented draw_bar "$memory_percent"

    # print the swap status
    printf "  Swap    [ $swap_used/$swap_total ]\n"

    # print a bar indented
    print_indented draw_bar "$swap_percent"
}
