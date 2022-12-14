#! /bin/sh
#
# entrypoint.sh

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" openjdk
usermod -o -u "$PUID" openjdk

su openjdk -c "java -jar ${JAR_PATH}"
