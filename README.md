# hue-controller
Game of Hues is a Philips Hue light controller intended to complement the
viewing of HBO's Game of Thrones.

This is a Sinatra server that uses [soffes/hue](https://github.com/soffes/hue) library
to trigger Hue lights to change and configure groups.

## setup
To run the server you will need docker and docker compose then
simply execute the following commands.
```
#
# Manually press the "register" button on your Philips Hue base station,
# then quickly execute the following.
#
docker-compose up --build
```

For subsequent restarts of the server, you should not have to press the base
station register button and you can drop the `--build` or else it will
rebuild the image every run and be slow to start up.

## configuration
The server is configured using the [/config/westeros.yml](https://github.com/dbellotti/hue-controller/blob/master/config/westeros.yml)
file which you can modify for your home setup. To do this, you will
need to figure out what your lights are named and only include the lights
you want to be controlled during viewing.
