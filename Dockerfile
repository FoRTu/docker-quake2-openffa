FROM debian:stable-slim

LABEL maintainer="FoRTu" \
maintainet.email="mikelfortuna@gmail.com" \
maintainer.website="https://fortu.io/"

WORKDIR /opt/quake2-openffa-server/

# Install Updates + Quake2 & OpenFFA MOD:
RUN apt update && \
apt upgrade -y && \
apt -y install curl apt-transport-https gnupg && \
curl -L "https://apt.fortu.io/repo.key" | apt-key add - && \
echo "deb https://apt.fortu.io/ stretch main contrib non-free" | tee -a /etc/apt/sources.list && \
apt update && \
apt install -y quake2-openffa-server && \
apt purge -y curl apt-transport-https gnupg && \
apt-get -y autoclean && \
apt-get -y autoremove && \
rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/* \
        /var/cache/debconf/*-old \
        /var/lib/apt/lists/* \
        /usr/share/doc/*

# Add server configuration file
COPY AddFiles/server.cfg /opt/quake2-openffa-server/openffa/

# Define the user
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser

EXPOSE 27910/tcp
EXPOSE 27910/udp

# Command to run on container startup
CMD ["/opt/quake2-openffa-server/r1q2ded","+set","game","openffa","+exec","server.cfg"]
