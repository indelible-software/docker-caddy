FROM alpine:latest
LABEL maintainer="Paul Hendry <paul@ijj.li>"

# Expose ports/volumes
EXPOSE 8080
EXPOSE 8443
VOLUME ["/etc/ssl/caddy", "/srv", "/var/log/caddy"]

# Install dependencies and configure system
RUN apk add --no-cache ca-certificates git mailcap shadow tzdata && \
    echo "* soft nofile 16384" >> /etc/security/limits.conf && \
    echo "* hard nofile 16384" >> /etc/security/limits.conf && \

# Download and install Caddy
ADD https://caddyserver.com/download/linux/amd64?plugins=http.cache,http.cors,http.git,http.realip&license=personal&telemetry=off /tmp/caddy.tar.gz
RUN tar -C /tmp -xzf /tmp/caddy.tar.gz && \
    mv /tmp/caddy /usr/local/bin/caddy && \
    chmod 755 /usr/local/bin/caddy && \
    rm -rf /tmp/*

# Set up files and mountpoints
COPY ./Caddyfile /etc/

# Configure entrypoint
ENV CADDYPATH /etc/ssl/caddy
WORKDIR /srv
ENTRYPOINT [\
    "/usr/local/bin/caddy", \
    "-conf", "/etc/Caddyfile", \
    "-log", "stdout", \
    "-http-port", "8080", \
    "-https-port", "8443"]

