# We pin alpine version and MariaDB version here, because they go together.

ARG VERSION=10.11
ARG ALPINE=3.20
ARG UID=3003
ARG GID=3003

FROM mariadb:${VERSION}-ubi AS extract

FROM alpine:${ALPINE}

LABEL maintainer="Thien Tran contact@tommytran.io"

ARG UID
ARG GID

# Pinning UID and GID here because the UID automatically created
# might change over time.
RUN adduser -u ${UID} -g ${GID} --disabled-password --system -h /var/lib/mysql mysql

RUN apk -U upgrade \
    && apk add --no-cache bash coreutils libstdc++ mariadb mariadb-backup mariadb-client mariadb-server-utils pwgen rsync tzdata xz zstd \
    # Alpine does not provide an aarch64 package for galera
    && if [ $(arch) = 'x86_64' ]; then apk add --no-cache galera procps-ng pv; fi \
    && rm -rf /var/cache/apk/* /etc/my.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY --from=extract --chown=mysql /etc/my.cnf /etc/my.cnf
COPY --from=extract --chown=mysql /etc/my.cnf.d /etc/my.cnf.d
COPY --from=extract --chown=mysql /etc/mysql /etc/mysql
COPY --from=extract /usr/local/bin/healthcheck.sh /usr/local/bin/healthcheck.sh
COPY --from=extract /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh 

RUN mkdir /run/mariadb
RUN mkdir /docker-entrypoint-initdb.d
RUN chown mysql:mysql /run/mariadb /docker-entrypoint-initdb.d

COPY --from=ghcr.io/polarix-containers/hardened_malloc:latest /install /usr/local/lib/
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"

USER mysql

VOLUME /var/lib/mysql

EXPOSE 3306/tcp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mariadbd"]
