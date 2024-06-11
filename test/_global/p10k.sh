#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'color' feature with "greeting": "hello" option.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "zsh is installed" zsh --version
check "zsh is default shell" echo $SHELL | grep zsh
check "oh-my-zsh is installed" echo ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
check "powerlevel10k is installed" test -e ~/.oh-my-zsh/custom/themes/powerlevel10k
check "zsh-autosuggestions is installed" test -e ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
check "using p10k theme" cat ~/.zshrc | grep "ZSH_THEME=\"powerlevel10k/powerlevel10k\""
check "plugins are configured" cat ~/.zshrc | grep "plugins=(aws git)"
check "powerlevel10k is configured" test -f ~/.p10k.zsh

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
