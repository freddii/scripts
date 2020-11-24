#!/usr/bin/env bash
#
#https://codeberg.org/ersen/bin
#
    usage() {
        printf "Usage: %s [OPTION]...
        A word guessing game

        -f FILE     use FILE to pick a new word (default: /usr/share/dict/words)
        -h          print this help and exit\n" "$program"
    }

    summary() {
        printf "\n\nSUMMARY: correctly guessed %i out of %i words\n" "$won" "$rounds"
    }

    die() {
        printf "%s\n" "$@"
        exit 1
    } >&2

    program="${0##*"/"}"
    file="/usr/share/dict/words"

    while getopts ":f:h" opt; do
        case "$opt" in
            "f" )   file="$OPTARG"                              ;;
            "h" )   usage && exit                               ;;
            ":" )   die "$program: $OPTARG: missing argument"   ;;
            * )     die "$program: $OPTARG: invalid option"     ;;
        esac
    done

    if [[ ! -r "$file" ]]; then
        die "$program: $file: file not readable"
    fi

    trap 'summary' EXIT

    won="0"
    rounds="0"
    declare -l guess word

    while true; do
        # shuf [-n|--head-count]
        word="$(shuf -n 1 "$file")"
        letters=""
        steps="${#word}"
        # tr [-c|--complement]
        partial="$(tr -c "\n$letters" "_" <<<"$word")"

        printf "[ROUND %i]\n" "$(( ++rounds ))"

        while true; do
            printf "Steps from the gallows (%i): [" "$steps"

            for (( i = 0; i < steps; ++i )); do
                printf "#"
            done

            for (( i = 0; i < ${#word} - steps; ++i )); do
                printf "-"
            done

            printf "]\nThe word so far: %s\n" "$partial"

            if [[ -n "$letters" ]]; then
                printf "(Guessed: %s) " "$letters"
            fi

            read -rp "Guess a letter: " guess

            if [[ "$guess" == "$word" ]]; then
                printf "You can go now! Found the word: '%s'\n\n" "$word"
                (( ++won ))
                break
            elif (( ${#guess} != 1 )); then
                printf "Guess only one letter at a time\n"
            elif [[ "$letters" == *"$guess"* ]]; then
                printf "Tried '%s' before\n" "$guess"
            elif [[ "$word" == *"$guess"* ]]; then
                # tr [-c|--complement] [-d|--delete]
                letters="$(sed 's/./&\n/g' <<<"$letters$guess" | sort | tr -d '\n')"
                partial="$(tr -c "\n$letters" "_" <<<"$word")"

                if [[ "$partial" == "$word" ]]; then
                    printf "You can go now! Found the word: '%s'\n\n" "$word"
                    (( ++won ))
                    break
                else
                    printf "The letter '%s' is found in the word\n" "$guess"
                fi
            elif (( steps == 1 )); then
                printf "End of the line! Could not found the word '%s'\n\n" "$word"
                break
            else
                # tr [-d|--delete]
                letters="$(sed 's/./&\n/g' <<<"$letters$guess" | sort | tr -d '\n')"

                printf "Try again! The letter '%s' does not appear in the word\n" "$guess"
                (( --steps ))
            fi
        done
    done