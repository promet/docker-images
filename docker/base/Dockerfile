FROM ubuntu:16.04

COPY bin/ /opt/local/bin/

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install ca-certificates apt-transport-https curl wget zip unzip bzip2 p7zip rsync git lsb-release \
 ## Add other packages here, but the following two lines need to run last after adding packages
 ## to reduce the size of the container.
 && rm -rf /var/lib/apt/lists/* \
 && apt autoremove -y \
 ## Add gosu and go-replace
 && mkdir -p \
        /usr/local/bin \
    ## Install go-replace
    && wget -O "/usr/local/bin/go-replace" "https://github.com/webdevops/goreplace/releases/download/1.1.2/gr-64-linux" \
    && chmod +x "/usr/local/bin/go-replace" \
    && "/usr/local/bin/go-replace" --version \
    # Install gosu
    && wget -O "/sbin/gosu" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" \
    && wget -O "/tmp/gosu.asc" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /tmp/gosu.asc "/sbin/gosu" \
    && rm -rf "$GNUPGHOME" /tmp/gosu.asc \
    && chmod +x "/sbin/gosu" \
    && "/sbin/gosu" nobody true

CMD ["/bin/bash"]
