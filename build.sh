#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

set -ue

image_name="localhost/vagrant-disksize-builder"
container_name="vagrant-disksize-builder"

(cd "$DIR" && \
    docker build \
        -t $image_name \
        ".")

docker run \
    --rm \
    --workdir /app \
    -v $DIR:/app \
    --name $container_name \
    $image_name rake build


