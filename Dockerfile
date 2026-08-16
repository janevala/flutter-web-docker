FROM ubuntu:26.04

ARG FLUTTER_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        make \
        htop \
        curl \
        git \
        unzip \
        zip \
        xz-utils \
        libglu1-mesa \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL \
        "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
        -o /tmp/flutter.tar.xz \
    && tar -xJf /tmp/flutter.tar.xz -C /opt \
    && rm /tmp/flutter.tar.xz

RUN git config --global --add safe.directory /opt/flutter \
    && flutter --version \
    && flutter config --enable-web \
    && flutter precache --web

WORKDIR /app