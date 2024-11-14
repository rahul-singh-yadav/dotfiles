#!/bin/bash

# Fail immediately if any command fails.
set -e

PRODUCT=terraform
VERSION=1.9.7

echo "Updating package index..."
sudo apk update

echo "Installing core system packages..."

# Install basic system utilities
sudo apk add --no-cache \
    zsh \
    wget \
    openssh-client \
    vim \
    gnupg \
    pass

# Install development tools (Python3, pip, Go, Ansible)
sudo apk add --no-cache \
    python3 \
    py3-pip \
    go \
    ansible

# Install terraform cli
RUN apk add --update --virtual .deps --no-cache gnupg && \
    cd /tmp && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
    wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
    gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS && \
    grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
    unzip /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip -d /tmp && \
    mv /tmp/${PRODUCT} /usr/local/bin/${PRODUCT} && \
    rm -f /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS ${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
    apk del .deps

echo "System packages installed successfully!"

# Zsh is installed, now set Zsh as the default shell for the current user
if [ -x "$(command -v zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s "$(which zsh)" || echo "chsh command not available, set Zsh manually."
else
    echo "Zsh installation failed. Please check the logs."
fi

echo "Alpine packages installation complete!"