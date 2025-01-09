#! /usr/bin/env bash

function test_CV_version() {
    local options=$1

    abcli_eval ,$options \
        "abcli_CV version ${@:2}"

    return 0
}
