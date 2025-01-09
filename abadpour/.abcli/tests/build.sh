#! /usr/bin/env bash

function test_CV_build() {
    local options=$1

    abcli_eval ,$options \
        "abcli_CV build \
        ${@:2}"
}
