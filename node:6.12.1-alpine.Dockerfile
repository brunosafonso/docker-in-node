# Current LTS Support 6.x
FROM node:6.12.1-alpine

# Maintainer Information
LABEL maintainer="ZRP Aplicações Informáticas LTDA - ME <zrp@zrp.com.br>"
LABEL vendor="ZRP Aplicações Informáticas LTDA - ME"
LABEL license="GPLv3"

# Configure where container network and pwd
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# extend path to read from local binaries and project binaries
ENV NODEJS_VERSION="6.12.1" \
    GOSU_VERSION="1.10" \
    APP_PATH=/home/node \
    PATH=/usr/local/bin/:/home/node/app/bin/:$PATH

RUN set -ex; \
    apk add --no-cache --virtual .gosu-deps dpkg gnupg openssl; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    gosu nobody true; \
    apk del .gosu-deps

# Install dependencies and yarn globally
RUN npm install -g yarn && npm upgrade -g yarn

# install custom scripts into local binaries
COPY alpine_rootfs /usr/local/bin/
COPY shared /usr/local/bin

# run the app
ENTRYPOINT ["/usr/local/bin/docker_entrypoint"]
CMD ["node"]
