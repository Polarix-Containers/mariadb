ARG VERSION=11

FROM mariadb:${VERSION}-ubi

LABEL maintainer="Thien Tran contact@tommytran.io"

USER root

RUN microdnf -y upgrade \
    && rm -rf /usr/local/bin/gosu \
    && curl https://copr.fedorainfracloud.org/coprs/secureblue/hardened_malloc/repo/rhel-9/secureblue-hardened_malloc-rhel-9.repo \
        -o /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:secureblue:hardened_malloc.repo \
    && microdnf install -y crypto-policies-scripts hardened_malloc \
    && update-crypto-policies --set FUTURE \
    && echo libhardened_malloc.so > /etc/ld.so.preload

USER mysql