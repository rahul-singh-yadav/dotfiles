# Use Alpine as the base image
FROM FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set environment variables
ENV USERNAME=zenbox \
    USER_HOME=/home/zenbox

# Install necessary packages and create a non-root user with sudo privileges
RUN apk add --no-cache \
    zsh \
    curl \
    git \
    ansible \
    pass \
    gnupg \
    openssh \
    sudo \
    shadow && \
    # Create a non-root user named 'zenbox' and grant sudo privileges
    useradd -m -G wheel $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers && \
    chsh -s /bin/zsh $USERNAME && \
    # Cleanup unnecessary files and cache
    rm -rf /var/cache/apk/* /tmp/*

# Copy your initialization script into the container
COPY ./scripts/init.sh /usr/local/bin/

# Set permissions to execute the initialization script
RUN chmod +x /usr/local/bin/init.sh

# Set the working directory to the user's home directory
WORKDIR $USER_HOME

# Set Zsh as the default shell for the container
CMD ["zsh", "-l"]