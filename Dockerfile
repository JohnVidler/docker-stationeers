FROM --platform=linux/amd64 cm2network/steamcmd:latest

ARG STEAM_APP_ID="600760"
ENV STEAM_APP_ID="${STEAM_APP_ID}"
ARG STEAM_APP_PATH="/home/steam/stationeers"
ENV STEAM_APP_PATH="${STEAM_APP_PATH}"
#RUN ./steamcmd.sh +force_install_dir "${STEAM_APP_PATH}" +login anonymous +app_update ${STEAM_APP_ID} validate +quit

# BepInEx Mod Extra Stuff! Do not include the preceeding 'v' in the version
ARG MOD_BEPINEX_VERSION="5.4.23.2"
ENV MOD_BEPINEX_VERSION="${MOD_BEPINEX_VERSION}"

# Stationeers requires a different version of libstdc++ and libc to actually work, so we roll this back
USER root
RUN touch /etc/apt/sources.list && sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y utils locales unzip libc6 libstdc++6 locales && locale-gen en_GB.UTF-8 && \
    sed -i 's/bookworm/bullseye/g' /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i '/en_GB.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB:en
ENV LC_ALL=en_GB.UTF-8    

WORKDIR "/opt/launch"

RUN mkdir -p /opt/launch/launch.d
COPY launch.d /opt/launch/launch.d
COPY launch.sh /opt/launch/launch.sh
RUN chmod +rx /opt/launch/launch.sh
RUN chmod +rx /opt/launch/launch.d/*

USER steam
ENV PATH="${STEAM_APP_PATH}:${PATH}"

RUN mkdir -p "${STEAM_APP_PATH}"

ENV SV_AUTH_SECRET=""
ENV SV_VISIBLE="True"
ENV SV_PORT="27016"
ENV SV_NAME="Docker Stationeers"
ENV SV_SAVE_NAME="multiplayer"
ENV SV_DEFAULT_WORLD="Moon"
ENV SV_PASSWORD=""
ENV SV_AUTOSAVE="True"
ENV SV_SAVE_INTERVAL="300"
ENV SV_MAX_PLAYERS="10"
ENV SV_UPNP_ON="True"
ENV SV_DIFFICULTY="normal"

# Meta Server port (TCP).
EXPOSE 8081/tcp

# Steam update port (UDP)
EXPOSE 27015/udp
EXPOSE 27015

# Game port (UDP) <-- connect to this one!
EXPOSE 27016/udp
EXPOSE 27016

ENTRYPOINT [ "/opt/launch/launch.sh" ]
