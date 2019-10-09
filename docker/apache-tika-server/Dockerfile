FROM ubuntu:latest
MAINTAINER oksanacyrwus@gmail.com

ENV TIKA_VERSION 1.22
ENV TIKA_SERVER_URL https://www.apache.org/dist/tika/tika-server-$TIKA_VERSION.jar

COPY conf/tika-config.xml /usr/local/bin/tika-config.xml

RUN set -x \
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install gnupg openjdk-11-jre-headless curl gdal-bin tesseract-ocr \
        tesseract-ocr-eng tesseract-ocr-spa -y \
    && curl -sSL https://people.apache.org/keys/group/tika.asc -o /tmp/tika.asc \
    && gpg --import /tmp/tika.asc \
    && curl -sSL "$TIKA_SERVER_URL.asc" -o /tmp/tika-server-${TIKA_VERSION}.jar.asc \
    && NEAREST_TIKA_SERVER_URL=$(curl -sSL http://www.apache.org/dyn/closer.cgi/${TIKA_SERVER_URL#https://www.apache.org/dist/}\?asjson\=1 \
        | awk '/"path_info": / { pi=$2; }; /"preferred":/ { pref=$2; }; END { print pref " " pi; };' \
        | sed -r -e 's/^"//; s/",$//; s/" "//') \
    && echo "Nearest mirror: $NEAREST_TIKA_SERVER_URL" \
    && curl -sSL "$NEAREST_TIKA_SERVER_URL" -o /tika-server-${TIKA_VERSION}.jar \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9998

ENTRYPOINT java -jar /tika-server-${TIKA_VERSION}.jar -h 0.0.0.0 --config=/usr/local/bin/tika-config.xml