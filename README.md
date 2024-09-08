# MariaDB

![Build, scan & push](https://github.com/Polarix-Containers/mariadb/actions/workflows/build.yml/badge.svg)

### Features & usage
- Drop-in replacement for the [official image](https://hub.docker.com/_/mariadb)*
- Unprivileged image: you should check your volumes' permissions (eg `/var/lib/mysql`), default UID/GID is 3003.

### Notes
- This image uses the latest MariaDB version provided by Alpine. Alpine tends to be behind upstream MariaDB and stick to LTS branches, so you will not get the latest version of MariaDB with this image.
- Galera is only supported on `x86_64` builds.
- We try our best to maintain compatibility with upstream's UBI image, however, the MariaDB container is a quite complex image. If you run into issues, please do not hesitate to report them.

### Licensing
- Licensed under GPL 2 to comply with licensing by MariaDB.
- Any image built by Polarix Containers is provided under the combination of license terms resulting from the use of individual packages.
