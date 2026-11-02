a docker build for own dev/nas environment

with:

- supervisor
- nginx
- nodejs 26
- php
- postgresql 18 with pgroonga
- ffmpeg


# usage

## docker:
```bash
docker pull 0xee/my_docker_aio:latest

docker rm -f my_docker_aio

docker run -dit \
--name my_docker_aio \
-p 40080:80 \
-p 40081:5432 \
-v /opt/project:/var/www/html \
0xee/my_docker_aio:latest

docker exec -it my_docker_aio /bin/bash 
```



## compose
```bash
docker compose up -d


docker exec -it my_docker_aio_compose /bin/bash 

```

### build mark

| type | path |
|--|--|
| compose_initialized | /.compose_initialized |
| postgresql | /var/lib/postgresql/18/main/.postgres_password_initialized |
| crontab | /.crontab.works |
|  |  |

