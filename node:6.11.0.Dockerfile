# Current LTS Support 6.x
FROM node:6.11.0

# Maintainer Information
MAINTAINER ZRP Aplicações Informáticas LTDA - ME <zrp@zrp.com.br>
LABEL vendor="ZRP Aplicações Informáticas LTDA - ME"
LABEL license="GPLv3"

# Configure where container network and pwd
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

ENV NODEJS_VERSION="6.11.0" \
    GOSU_VERSION="1.10" \
    APP_PATH=/home/node \
    # extend path to read from local binaries and project binaries
    PATH=/usr/local/bin/:/home/node/app/bin/:$PATH

RUN set -ex; \
    fetchDeps='ca-certificates wget'; \
    apt-get update; \
    apt-get install -y --no-install-recommends $fetchDeps; \
    rm -rf /var/lib/apt/lists/*; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    gosu nobody true; \
    apt-get purge -y --auto-remove $fetchDeps

# Install dependencies and yarn globally
RUN npm install -g yarn && npm upgrade -g yarn

# install custom scripts into local binaries
COPY rootfs /usr/local/bin/
COPY shared /usr/local/bin

# run the app
ENTRYPOINT ["/usr/local/bin/docker_entrypoint"]
CMD ["/bin/bash"]
