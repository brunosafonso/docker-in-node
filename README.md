# Docker in Node

Docker in Node is a base image that provides a small set of features to ease developing Node.js applications using docker and docker-compose. This image is built on top of node alpine and node images.
The image can be found [here](https://hub.docker.com/r/zrpaplicacoes/docker-in-node/).

# Using the image

This image is intended to be use as a base image for your own Dockerfile. To use it, simply reference it in the `FROM` clause at the top of the dockerfile:

```
FROM zrpaplicacoes/docker-in-node:6.11.0-alpine
FROM zrpaplicacoes/docker-in-node:6.11.0
...
...
ENTRYPOINT ["mycustomentrypoint"]
CMD ["mycustomcmd"]
```

# Handling permissions on Linux

Before starting running your container, ensure to provide to docker run your user_id, thus handling the permissions problem that may arise during development. To do so you must use an environment variable USER_ID, so you can do `docker run --rm -ti -e USER_ID=$UID -v /myapplication/root:/home/app/web -w /home/app/web zrpaplicacoes/docker-in-rails:latest` to ensure that the UID used inside the container is the same as the host machine.

# Versions

*   zrpaplicacoes/docker-in-node:6.11.0-alpine
*   zrpaplicacoes/docker-in-node:6.11.0
*   zrpaplicacoes/docker-in-node:6.11.2-alpine
*   zrpaplicacoes/docker-in-node:6.11.2
*   zrpaplicacoes/docker-in-node:6.12.1-alpine
*   zrpaplicacoes/docker-in-node:6.12.1
*   zrpaplicacoes/docker-in-node:8.9.4-alpine
*   zrpaplicacoes/docker-in-node:10.15.3-alpine
*   zrpaplicacoes/docker-in-node:12.0.0-alpine
