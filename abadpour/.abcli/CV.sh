#! /usr/bin/env bash

function abcli_CV() {
    local task=$(abcli_unpack_keyword $1 help)

    abcli_generic_task \
        plugin=CV,task=$task \
        "${@:2}"
}
