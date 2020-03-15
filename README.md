# `caddy`

Docker image for [Caddy](https://caddyserver.com/), an open-source webserver with automatic HTTPS
written in Go.

This runs a "Personal" licensed version of Caddy by using their binary download service.


## Environment variables

- `ACME_AGREE`: Must be set to `"true"` to indicate that you agree to the Let's Encrypt Subscriber
  Agreement.


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

