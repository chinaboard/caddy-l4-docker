FROM caddy:2-builder-alpine as build

RUN xcaddy build --with github.com/mholt/caddy-l4 --output caddy-l4

FROM alpine:latest

COPY --from=build /usr/bin/caddy-l4 /usr/bin/caddy-l4
COPY examples/Caddyfile.json /etc/Caddyfile.json

LABEL org.opencontainers.image.title=caddy-l4
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source="https://github.com/ghthor/caddy-l4-docker"

ENTRYPOINT ["/usr/bin/caddy-l4"]
CMD ["run", "--config", "/etc/Caddyfile.json"]
