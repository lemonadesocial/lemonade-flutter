#!/bin/bash

ENDCOLOR="\e[0m"

printMessage() {
    printf "${YELLOW}Lemonade : $1${ENDCOLOR}\n"
}

REPO_DIR=$(git rev-parse --show-toplevel)
echo "Home Git directory of the current repository: $REPO_DIR"

# Add the githooks directory to your git configuration
printMessage "Setting up githooks."
git config core.hooksPath $REPO_DIR/.githooks

# Install go-gitlint
printMessage "Installing go-gitlint."
GOLINT_FILENAME="go-gitlint_1.1.0_osx_x86_64.tar.gz"
curl -L https://github.com/llorllale/go-gitlint/releases/download/1.1.0/${GOLINT_FILENAME} --output ${GOLINT_FILENAME}
tar -zxv --directory $REPO_DIR/.githooks/. -f ${GOLINT_FILENAME} gitlint
rm ${GOLINT_FILENAME}

