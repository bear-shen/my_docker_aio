# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

#ffmpeg 6.0才有av1_nvenc的编码
#因此至少需要ubuntu(nobel/24.04LTS)
FROM ubuntu:24.04

# Use production node environment by default.
ENV NODE_ENV=production
ENV SRC=/myDocker
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

WORKDIR ${SRC}

# Copy the rest of the source files into the image.
COPY . .


RUN chmod +x ${SRC}/init.sh && \
    ${SRC}/init.sh

USER root

#ENTRYPOINT /${SRC}/init.sh