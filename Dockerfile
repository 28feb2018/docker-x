FROM debian
RUN apt-get update && apt-get install -qqy x11-apps
ENV DISPLAY :0
CMD xclock & sh
#run, no xauth: docker run -ti -v '/tmp/.X11-unix:/tmp/.X11-unix' xcont
#patch xauth: xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f nxauth nmerge -
#patch xauth 2: echo "ffff$(xxd -p -s 2 nxauth)" | xxd -r -p > nxauth
#run, patched xauth: docker run -ti -v '/tmp/.X11-unix:/tmp/.X11-unix' -v "$(readlink -f nxauth):/xauth" -e 'XAUTHORITY=/xauth' xcont
#run, copy host: docker run -ti -v '/tmp/.X11-unix:/tmp/.X11-unix' -v "$(readlink -f .Xauthority):/xauth" -e 'XAUTHORITY=/xauth' --hostname $HOSTNAME  xcont
