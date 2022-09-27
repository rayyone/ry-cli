#!/bin/bash
# shellcheck disable=SC2046

RY_ROOT="${BASH_SOURCE%/*}"
source $RY_ROOT/utils/util

info "Run these commands to add cli PATH to your shell (~/.zshrc, ~/.bashrc,...)"
log_step "echo 'export PATH=\"$(pwd):\$PATH\"' >> ~/.zshrc"
log_step "source ~/.zshrc"