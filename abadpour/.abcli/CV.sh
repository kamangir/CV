#! /usr/bin/env bash

function abcli_CV() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        CV_build "$@"
        CV_clean "$@"
        return
    fi

    abcli_generic_task \
        plugin=CV,task=$task \
        "${@:2}"
}

abcli_source_path \
    $abcli_path_git/CV/.abcli/tests
