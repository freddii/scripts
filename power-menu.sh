#!/usr/bin/env bash
#https://codeberg.org/ersen/bin
usage() {
    printf "Usage: %s [OPTION]...
    Select and perform actions about power management

    -h          print this help and exit\n" "$program"
}

die() {
    printf "%s\n" "$@"
    exit 1
} >&2

program="${0##*"/"}"
actions=( "Logout" "Poweroff" "Reboot" "Suspend" )

while getopts ":h" opt; do
    case "$opt" in
        "h" )   usage && exit                           ;;
        * )     die "$program: $OPTARG: invalid option" ;;
    esac
done

# wofi [-d|--dmenu] [-L|--lines]
selection="$(printf "%s\n" "${actions[@]}" | wofi -dL 4)"

case "$selection" in
    "Logout" )      loginctl terminate-user "$USER" ;;
    "Poweroff" )    systemctl poweroff              ;;
    "Reboot" )      systemctl reboot                ;;
    "Suspend" )     systemctl suspend               ;;
esac
