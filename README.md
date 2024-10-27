# A Stationeers Docker Image

This repository attempts to be a _working_ and _up-do-date_ stationeers server image.

Whenever the container is started it attempts to re-download the game, along with any plugins so should always be able to run the latest published version of the game, just restart your container to update.

I've been using this for my multiplayer world(s) for some time now with no issues.

If you find my work useful, consider tipping me via Ko-fi, every little helps and is greatly appreciated!

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K8L32E3)

## Docker Images

A number of image variants can be found [on the packages page here](https://github.com/JohnVidler/docker-stationeers/pkgs/container/docker-stationeers) but currently the only recommended one to run is the vanilla server on the `main` branch, and all others should be considered BETA for the moment while the bugs are worked out.

## Running via `docker compose`

Either clone this repository and copy the `docker-compose.yml.example` file to `docker-compose.yml`, or create a new folder with the `docker-compose.yml` file and `data` folder present, then from the same path as the `docker-compose.yml` file just
run `docker compose up` (or `docker compose up -d` to run this in the background) and you should, after a little wait while the server builds have a full stationeers server instance.

Save data will be saved in `data/saves` and can be copied out periodically for backups (I recommend rsync for this on Linux hosts).

Note that to connect to the server you'll need to have ports 27015/udp, 27016/udp, 8081/tcp open on your docker host too.

## Supported Configuration via Environment Variables

- SV_AUTH_SECRET - Any string
- SV_VISIBLE - `"True"` or `"False"`, defaults to `True`
- SV_PORT - Any valid port, defaults to `27016`
- SV_NAME - Any string, defaults to `"Docker Stationeers"`
- SV_SAVE_NAME - Any string, defaults to `"multiplayer"`
- SV_DEFAULT_WORLD - One of `Moon` `Mars` `Vulcan` etc.
- SV_PASSWORD - Any string
- SV_AUTOSAVE - `"True"` or `"False"`, defaults to `True`
- SV_SAVE_INTERVAL - In seconds. Defaults to 5 minutes, aka. `"300"` seconds
- SV_MAX_PLAYERS - Maximum players connected, defaults to `"10"`
- SV_UPNP_ON - `"True"` or `"False"`, defaults to `True`, recommended
- SV_DIFFICULTY - Any valid difficulty level, defaults to `"normal"`

## Common 'Gotcha!' Fixes

If you find your server isn't coming up at all (not listed on the server list and not getting past a memory clean-up stage in the startup sequence) it might be that your `data/` mount has the wrong file permissions and the server is just freezing up when it tries to create the multiplayer save files.
This tends to happen on Windows hosts where users aren't quite the same thing as Linux users, so Docker does slightly dumb things with the mappings.

To fix this, shut down the container, copy everything from your data directory to somewhere safe, then delete the top-level data directory, restart the container briefly to let it create a new data directory, the stop it again. You can then paste your old save back into the new data directory, and restart the container.

There is a fix for this behaviour in some the development builds here, but it has't made it back to the main branch yet; but soon this won't be an issue any more.
