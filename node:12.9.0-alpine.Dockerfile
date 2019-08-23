# Current LTS Support 12.x
FROM node:12.9.0-alpine

# Maintainer Information
LABEL maintainer="ZRP Aplicações Informáticas LTDA - ME <zrp@zrp.com.br>"
LABEL vendor="ZRP Aplicações Informáticas LTDA - ME"
LABEL license="GPLv3"

# Configure where container network and pwd
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# extend path to read from local binaries and project binaries
ENV NODEJS_VERSION="12.9.0" \
    APP_PATH=/home/node/app \
    PATH=/usr/local/bin/:/home/node/app/bin/:$PATH

# install custom scripts into local binaries
COPY alpine_rootfs /usr/local/bin/
COPY shared /usr/local/bin

# run the app
ENTRYPOINT ["/usr/local/bin/docker_entrypoint_without_gosu"]
CMD ["ash"]
