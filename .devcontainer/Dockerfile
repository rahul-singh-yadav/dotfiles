# Use Alpine as the base image
FROM alpine:latest

# Set environment variables
ENV USERNAME=zenbox \
    USER_HOME=/home/zenbox

# Install necessary packages and create a non-root user with sudo privileges
RUN apk add --no-cache \
    git \
    sudo \
    shadow \
    openssh && \
    # Create a non-root user named 'zenbox' and grant sudo privileges
    useradd -m -G wheel $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers && \
    # Cleanup unnecessary files and cache
    rm -rf /var/cache/apk/* /tmp/*

# Copy your initialization script into the container
COPY ./scripts/init.sh /usr/local/bin/

# Set permissions to execute the initialization script
RUN chmod +x /usr/local/bin/init.sh

# Set the working directory to the user's home directory
WORKDIR $USER_HOME

# Set Zsh as the default shell for the container
CMD ["/bin/zsh"]
ENTRYPOINT [ "/usr/local/bin/init.sh" ]