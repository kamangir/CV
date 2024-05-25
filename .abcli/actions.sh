#! /usr/bin/env bash

function CV_action_git_before_push() {
    CV pypi build
}
