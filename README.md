# A Stationeers Docker Image

This repository attempts to build a _working_ stationeers server image every 24 hours so should track the latest released version of the game.

It does occasionally fail to build, as the SteamCMD process just explodes with no warning mid-build with no discernable reason, but if the build succeeds it does result in a pretty rock-solid server image.

I've been using this for my multiplayer world(s) for some time now with no issues.

If you find my work useful, consider tipping me via Ko-fi, every little helps and is greatly appreciated!

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K8L32E3)

## Running via `docker compose`

Either clone this repository, or create a new folder with the `docker-compose.yml` file and `data` folder present, then from the same path as the `docker-compose.yml` file just
run `docker compose up` (or `docker compose up -d` to run this in the background) and you should, after a little wait while the server builds have a full stationeers server instance.

Save data will be saved in `data/saves` and scripts can be placed in `data/scripts`

Note that to connect to the server you'll need to have ports 27015/udp, 27016/udp, 8081/tcp open on your docker host too.
