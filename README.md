# caddy

Docker image for [Caddy](https://caddyserver.com/), an open-source webserver with automatic HTTPS
written in Go.

This runs a "Personal" licensed version of Caddy by using their binary download service.

It's designed to run in a fully locked-down configuration, with

- `read-only` enabled (requires all volumes listed below to have mounts or `tmpfs` attached);
- `cap-drop` set to `all`;
- `user` set to run as a non-root user in the container (this will only work with volume mounts
  when using a pod manager which supports rootless execution, such as
  [Podman](https://podman.io/))


## Let's Encrypt Subscriber Agreement

The default configuration does not accept the agreement. To do so, set the container `CMD` to
`-agree` to pass the argument to caddy.


## Ports

- `8080`: HTTP
- `8443`: HTTPS


## Volumes

- `/etc/Caddyfile`: The server config file
- `/etc/ssl/certs`: Contains auto-generated SSL certs
- `/srv`: The webserver root
- `/var/log/caddy`: Contains logs

It's recommended to mount all of these volumes, since that makes it possible to run the container
as an unprivileged user (via the `user` flag) and with a read-only filesystem (via the `read-only`
flag).

