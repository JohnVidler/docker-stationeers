FROM --platform=linux/amd64 cm2network/steamcmd:latest

ARG STEAM_APP_ID="600760"
ARG STEAM_APP_PATH="/home/steam/stationeers"
RUN ./steamcmd.sh +force_install_dir "$STEAM_APP_PATH" +login anonymous +force_install_dir /data +app_update $STEAM_APP_ID +quit

# Stationeers requires an different version of libstdc++ and libc to actually work, so we roll this back
USER root
RUN sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y libc6 libstdc++6 && \
    sed -i 's/bookworm/bullseye/g' /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

USER steam
WORKDIR "$STEAM_APP_PATH"
ENV PATH="$STEAM_APP_PATH:$PATH"

# Meta Server port (TCP).
EXPOSE 8081/tcp

# Steam update port (UDP)
EXPOSE 27015/udp

# Game port (UDP) <-- connect to this one!
EXPOSE 27016/udp

ENTRYPOINT [ "rocketstation_DedicatedServer.x86_64" ]
CMD [ "-settingspath", "/home/steam/stationeers/saves/server_settings.xml", $APP_FLAGS ]
