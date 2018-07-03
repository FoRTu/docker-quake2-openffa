![Quake 2 logo](q2logo.png)

# Quake 2 OpenFFA Dedicated Server

Dockerized version of Quake 2 dedicated server with the OpenFFA mod. Using prebuilt r1q2ded debian package of my own repository, you can easily create a server to play quake 2 multiplayer. Thanks docker's magic you can create many servers as you want by only changing the listening port.

## Customization

Editing 'AddFiles/server.cfg' you can customize the server configuration. Changing the server name, time limit, maximum players etc. 

Once changes have been done you is time to build the image. Just run the next command to create it:

```docker build -t "[IMAGE TAG]" .```

For xample:

```docker build -t "games/q2-server"```


## Usage

Now that we have the image created, just start a container using that image by executing the following command:

```docker run -d --rm --name "Quake2_OpenFFA" -p [HOST PORT]:[CONTAINER PORT]/tcp -p [HOST PORT]:[CONTAINER PORT]/udp [IMAGE ID]```

For example:

```docker run -d --rm --name "Quake2_OpenFFA" -p 27910:27910/tcp -p 27910:27910/udp 0d8cf1e41ba7```

