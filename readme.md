a docker build for own dev/nas environment

with:

- supervisor
- nginx
- nodejs 24
- php
- postgresql 16 with pgroonga
- ffmpeg


# usage

```bash
-----------------------------------
# docker:

docker pull 0xee/my_docker_aio:latest

docker rm -f my_docker_aio

docker run -dit \
--name my_docker_aio \
-p 40080:80 \
-p 40081:5432 \
-v /opt/project:/var/www/html \
0xee/my_docker_aio:latest

docker exec -it my_docker_aio /bin/bash 


-----------------------------------
# compose

docker compose up -d


docker exec -it my_docker_aio_compose /bin/bash 



```
