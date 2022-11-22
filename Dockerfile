FROM openjdk:17.0.2-jdk-slim

COPY root/ /

RUN \
    echo "**** install runtime packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates && \
    echo "**** create openjdk user and make our folders ****" && \
    mkdir /home/openjdk && \
    groupmod -g 1000 users && \
    useradd -u 911 -U -d /home/openjdk -s /bin/sh openjdk && \
    usermod -G users openjdk && \
    chown -R openjdk:openjdk /home/openjdk && \
    chmod +x /usr/bin/entrypoint.sh && \
    rm -rf /var/lib/apt/lists/* && \
    echo "**** install cavif ****" && \
    cd /home/openjdk && \
    curl -LO https://github.com/kornelski/cavif-rs/releases/download/v1.3.5/cavif_1.3.5_amd64.deb && \
    dpkg -i cavif_1.3.5_amd64.deb && \
    rm cavif_1.3.5_amd64.deb

ENTRYPOINT ["sh","-c","/usr/bin/entrypoint.sh"]
