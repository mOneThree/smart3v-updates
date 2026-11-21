ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM ${BUILD_FROM}

# curl and jq come with the Home Assistant base image; make sure they are there
RUN apk add --no-cache curl jq coreutils tzdata

COPY rootfs /
RUN chmod a+x /etc/services.d/smart3v-updater/run /etc/services.d/smart3v-updater/finish

LABEL \
    org.opencontainers.image.title="Home Assistant App: Smart 3V Updater" \
    org.opencontainers.image.description="Fetches Smart 3V firmware updates for the Matter Server." \
    org.opencontainers.image.source="https://github.com/mOneThree/smart3v-updates" \
    org.opencontainers.image.licenses="MIT"
