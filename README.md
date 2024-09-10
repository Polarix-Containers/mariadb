# MariaDB

![Build Alpine, scan & push](https://github.com/Polarix-Containers/mariadb/actions/workflows/build.yml/badge.svg)
![Build UBI, scan & push](https://github.com/Polarix-Containers/mariadb-ubi/actions/workflows/build-latest.yml/badge.svg)

Drop-in replacement for the [official image](https://hub.docker.com/_/mariadb).

### Alpine
- Unprivileged image: you should check your volumes' permissions (eg `/var/lib/mysql`), default UID/GID is 3003. We cannot use 999 like upstream as it is already used by another user.
- Built on top of Alpine, with MariaDB provided by Alpine repositories.
- Alpine tends to be behind upstream MariaDB and stick to LTS branches, so you will not get the latest version of MariaDB with this image.
- Generally more up-to-date packages in the OS than Red Hat UBI.
- Low number of vulnerabilities.
- Galera is only supported on `x86_64` builds.
- **Tag**: `alpine`. Should Alpine start getting the latest MariaDB versions, it will get the `latest` tag.

### UBI
- Unprivileged image: you should check your volumes' permissions (eg `/var/lib/mysql`), default UID/GID is 999.
- Built on the upstream MariaDB UBI image.
- Removes unnecessary gosu SUID binary.
- Uses FUTURE crypto policy.
- Has a lot of outdated packages with *maybe* some downstream patching.
- Generates a lot of vulnerbility scanner noise - hard to tell what is a false positive and what is not.
- Source: https://github.com/Polarix-Containers/mariadb-ubi

### Sample Docker Compose config

```
  mariadb:
    container_name: mariadb
    restart: unless-stopped
    image: ghcr.io/polarix-containers/mariadb:10.11
    volumes:
      - "./mariadb:/var/lib/mysql:Z"
    environment:
      - MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}
      - MARIADB_DATABASE=${MARIADB_DATABASE}
      - MARIADB_USER=${MARIADB_USER}
      - MARIADB_PASSWORD=${MARIADB_PASSWORD}
    user: "3003:3003"
    read_only: true
    tmpfs:
      - /var/tmp
      - /run/mariadb:size=50M,mode=0770,uid=3003,gid=3003,noexec,nosuid,nodev
    security_opt:
      - "no-new-privileges=true"
    cap_drop:
      - ALL
```

### Licensing
- Licensed under GPL 2 to comply with licensing by MariaDB.
- Any image built by Polarix Containers is provided under the combination of license terms resulting from the use of individual packages.
