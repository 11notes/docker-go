# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
  # GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      APP_VERSION=0

  # :: FOREIGN IMAGES
  FROM 11notes/util:bin AS util

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM golang:${APP_VERSION}-alpine

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: app specific environment
    ENV CGO_ENABLED=0

  # :: multi-stage
    COPY --from=util / /
    COPY ./rootfs/ /

# :: RUN
  USER root

  # :: install dependencies
    RUN set -eux; \
      apk --update --no-cache add \
        git;

  # :: update alpine
    RUN set -eux; \
      apk update; \
      apk add --upgrade apk-tools; \
      apk upgrade --available;