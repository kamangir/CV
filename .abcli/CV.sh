#! /usr/bin/env bash

function CV() {
    abcli_CV $@
}

function abcli_CV() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        CV_build "$@"
        CV_clean "$@"

        [[ "$(abcli_keyword_is $2 verbose)" == true ]] &&
            python3 -m CV --help

        return
    fi

    local function_name=CV_$task
    if [[ $(type -t $function_name) == "function" ]]; then
        $function_name "${@:2}"
        return
    fi

    if [[ "|pylint|pytest|test|" == *"|$task|"* ]]; then
        abcli_${task} plugin=CV,$2 \
            "${@:3}"
        return
    fi

    abcli_log_error "-CV: $task: command not found."
}
