# Microweber CMS docker images

[![Docker Stars](https://img.shields.io/docker/stars/microweber/microweber.svg)](https://hub.docker.com/r/microweber/microweber) [![Docker Pulls](https://img.shields.io/docker/pulls/microweber/microweber.svg)](https://hub.docker.com/r/microweber/microweber) [![Docker Build Statu](https://img.shields.io/docker/build/microweber/microweber.svg)](https://hub.docker.com/r/microweber/microweber/)

There are two supported tags:
- php71-apache - aio image, built on Debian Jessie, supports SQLite and MySQL
- php71-fpm - based on Alpine linux and uses PHP-FPM, supports MySQL and PostgreSQL
 
Please, use php71-apache tag for demo/testing/developement purposes and php71-fpm for production together with docker compose or with docker swarm.

# How to use 
Below is example which allows you to run Microweber CMS from docker hub using single coomand in your console with Docker installed (using php71-apache tag):
```sh
docker run -p 80:80 microweber/microweber:php7.1-apache
```
Also you can use [docker-compose.yml](https://github.com/microweber/docker/blob/master/docker-compose.yml) example in repo. To run Microweber CMS via docker-compose you need to clone repository and run docker-compose up:
```sh
git clone https://github.com/microweber/docker.git
cd microweber
docker-compose up -d
```
After container(s) started, please, proceed and finish CMS installation using webui.

# Environmental variables:
There are several env. variables which can be used for database configuration (you can see in [docker-compose.yml](https://github.com/microweber/docker/blob/master/docker-compose.yml))
- DB_USER - database user
- DB_PASS - database password
- DB_NAME - databaase name
- DB_ENGINE - database engine (mysql, pgsql or sqlite)
- DB_HOST - database host (can be mysql, pgsql and sqlite)
- DB_PREFIX - database prefix if you need it (for example _mw)

If you have database running on non-standart port, specify it using DB_HOST variable in following format `DB_HOST=<host>:<port>` (for example `DB_HOST=mysql:3222`). If DB env. vars are not defined and php71-apache tag is used, then SQLite will be used and system will be installed with sample content.

# Volumes:
- /usr/src/microweber/config - to store config files.
- /usr/src/microweber/userfiles - to store various user files/plugins and data

### Play With Docker
you can also try Microweber CMS in PWD (Play With Docker) sandbox
[![Try in PWD](https://raw.githubusercontent.com/microweber/docker/master/pwd_badge.png)](http://play-with-docker.com/?stack=https://raw.githubusercontent.com/microweber/docker/master/stack.yml) 
