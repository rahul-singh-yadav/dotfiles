# Use Alpine Linux base image
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Install necessary packages (shadow: chage; gnupg: for password vault)
RUN apk update && \
    apk add --no-cache shadow zsh ansible pass gnupg openssh

# Creates user & adds password expiration policy of 60 days
RUN adduser -D rahul && \
    chage -M 60 rahul

# Create .ssh directory and set permissions
RUN mkdir -p /home/rahul/.ssh && \
    chown rahul:rahul /home/rahul/.ssh && \
    chmod 700 /home/rahul/.ssh

# Copy key
# Ownsership & Permissions
COPY ~/.ssh/github_auth_key* /home/rahul/.ssh
RUN chown rahul:rahul /home/rahul/.ssh/github_auth_key* && \
    chmod 600 /home/rahul/.ssh/github_auth_key*

# Switch to user 'rahul' and set the working directory
USER rahul
WORKDIR /home/rahul

# Set zsh as the default shell
CMD [ "/bin/zsh" ]