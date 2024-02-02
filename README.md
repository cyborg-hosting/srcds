[![Docker Build Status](https://img.shields.io/docker/cloud/build/cyborghosting/srcds.svg)](https://hub.docker.com/r/cyborghosting/srcds/) [![Docker Stars](https://img.shields.io/docker/stars/cyborghosting/srcds.svg)](https://hub.docker.com/r/cyborghosting/srcds/) [![Docker Pulls](https://img.shields.io/docker/pulls/cyborghosting/srcds.svg)](https://hub.docker.com/r/cyborghosting/srcds/) [![](https://img.shields.io/docker/image-size/cyborghosting/srcds)](https://img.shields.io/docker/image-size/cyborghosting/srcds)
# Supported tags and respective `Dockerfile` links
  -	[`latest`  (*Dockerfile*)](https://github.com/cyborg-hosting/srcds/blob/master/Dockerfile)

# What is SRCDS?
The Source Dedicated Server (or SRCDS) is a tool that runs the server component of a Source game without the client component. In other words, it simulates the game without drawing it. SRCDS is chiefly used by server providers who want to serve up as many games from the same computer as they can. (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/Source_Dedicated_Server)).

# How to use this image
This container image is basically pre-installed dependency for SRCDS.
For running your game server, you must specify environment variable `STEAMCMD_APP_ID` and `SRCDS_STARTMAP`.

Running on the *host* interface: <br />
```console
$ export STEAMCMD_APP_ID={DEDICATED SERVER APP ID, ex) 232250 for TF2 dedicated server}
$ export SRCDS_STARTMAP={START MAP}
$ export SRCDS_TOKEN={YOUR TOKEN}
$ docker run --name=srcds --detach --tty --net=host --init --env STEAMCMD_APP_ID --env SRCDS_STARTMAP --env SRCDS_TOKEN cyborghosting/srcds
```

Running using a bind mount for data persistence on container recreation:
```console
$ export STEAMCMD_APP_ID={DEDICATED SERVER APP ID, ex) 232250 (not 440) for Team Fortress 2}
$ export SRCDS_STARTMAP={START MAP}
$ export SRCDS_TOKEN={YOUR TOKEN}
$ mkdir --parents "${PWD}/srcds-data"
$ chmod 777 "${pwd}/srcds-data"
$ docker run --name=srcds --detach --tty --net=host --init --env STEAMCMD_APP_ID --env SRCDS_STARTMAP --env SRCDS_TOKEN --volume "${PWD}/srcds-data:/srcds" cyborghosting/srcds
```

`SRCDS_TOKEN` **is required to be listed & reachable, Generate one here using AppID of game, ex) 440 (not 232250) for Team Fortress 2:**
[https://steamcommunity.com/dev/managegameservers](https://steamcommunity.com/dev/managegameservers)<br/><br/>
`SRCDS_WORKSHOP_AUTHKEY` **is required to use workshop features:**  
[https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey)<br/>

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Specifying these environment variables is not necessary. (except for required ones)
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
STEAMCMD_APP_ID=232250 **REQUIRED**
STEAMCMD_APP_BETA= (beta branch you want to play on)
USE_DOTENV= (if variable is not blank, then it will parse and load `.env` file in `/srcds`)
SRCDS_TOKEN="changeme" (value is is required to be listed & reachable, retrieve token here (AppID 440): https://steamcommunity.com/dev/managegameservers)
SRCDS_RCONPW="changeme" (value can be overwritten by tf/cfg/server.cfg) 
SRCDS_PW="changeme" (value can be overwritten by tf/cfg/server.cfg) 
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_IP="0" (local ip to bind)
SRCDS_FPSMAX=300
SRCDS_TICKRATE=66
SRCDS_MAXPLAYERS=14
SRCDS_REGION=3
SRCDS_STARTMAP="ctf_2fort" **REQUIRED**
SRCDS_HOSTNAME="New TF Server" (first launch only)
SRCDS_WORKSHOP_AUTHKEY="" (required to load workshop maps)
```

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/cyborg-hosting/srcds?size=50&padding=5&bots=false)](https://github.com/cyborg-hosting/srcds/graphs/contributors)
