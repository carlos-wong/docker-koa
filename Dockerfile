FROM ubuntu:18.04
# The FROM command specifies a local or pull-able image
# to use as a "base" for the new image. Subsequent commands
# will add "layers" to the final image

MAINTAINER carlos<huaixian.huang@gmail.com>
# It is good practice to sign your images like this

RUN apt-get update
# Apt-get update almost always has to be run. Because you
# are starting with a very basic system, you must populate
# the source lists for your package manager in order to be 
# able to download and install packages

RUN apt-get install -y curl grep
# We'll use the unix utility curl to download the node.js
# binaries

RUN mkdir -p /scripts

# We're going to put our app's code in the /app folder

RUN apt-get install -y nodejs npm 

ADD . /scripts
# The ADD command copies the contents of the current 
# directory (.) into the specified folder in the image

RUN npm i -g supervisor
# The node tool supervisor is a little too squirrely for
# production use, but can effectively crash and restart our
# node process on file changes during development

ENTRYPOINT /scripts/boot.sh
# A container's ENTRYPOINT is the command that will be 
# executed when a container instance of the image is 
# started. Since we mounted an executable shell script
# into the /app folder, we can use it to "boot" our container
