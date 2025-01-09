#! /usr/bin/env bash

function abadpour_clean() {
    pushd $abcli_path_git/abadpour/src >/dev/null
    rm *.aux
    rm *.dvi
    rm *.log
    rm *.out
    rm *.ps
    popd >/dev/null
    return
}
