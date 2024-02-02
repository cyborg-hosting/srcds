FROM cyborghosting/steamcmd

ARG DEBIAN_FRONTEND=noninteractive
RUN set -o errexit && \
    set -o xtrace && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        lib32z1=1:1.2.13.dfsg-1 \
        libncurses5=6.4-4 \
        libncurses5:i386=6.4-4 \
        libbz2-1.0=1.0.8-5+b1 \
        libbz2-1.0:i386=1.0.8-5+b1 \
        libcurl3-gnutls=7.88.1-10+deb12u5 \
        libcurl3-gnutls:i386=7.88.1-10+deb12u5 && \
    rm -rf /var/lib/apt/lists/*

ENV STEAMCMD_APP_ID=
ENV STEAMCMD_APP_BETA=
ENV STEAMCMD_INSTALL_DIR=/srcds
ENV STEAMCMD_SCRIPT=/tmp/steamcmd_script.txt

ENV SRCDS_RUN=srcds_run
ENV SRCDS_SECURED=1

ADD --chown=root:root --chmod=755 https://github.com/ko1nksm/shdotenv/releases/latest/download/shdotenv /usr/local/bin/shdotenv
ADD --chown=root:root --chmod=755 docker-entrypoint.d /docker-entrypoint.d
ADD --chown=root:root --chmod=755 run.sh /run.sh

CMD [ "/run.sh" ]
