#Imagen base del container
FROM debian:stable-slim

# Etiquetas con informacion adicional de la imagen
LABEL maintainer="FoRTu" \
maintainet.email="mikelfortuna@gmail.com" \
maintainer.website="https://fortu.io/"

# Carpeta de trabajo dentro del container
WORKDIR /opt/quake2-openffa-server/

# Ejecutar los comandos de instalacion de software
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

# Agregar archivos a la imagen
COPY AddFiles/server.cfg /opt/quake2-openffa-server/openffa/

# crear usuario raso para la ejecucion del comando CMD
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser

# Puestos susceptibles de se exppuestos en l arranque de container
EXPOSE 27910/tcp
EXPOSE 27910/udp

# Ejecutar el comando al arrancar imagen, no a la hora de crearla
CMD ["/opt/quake2-openffa-server/r1q2ded","+set","game","openffa","+exec","server.cfg"]
