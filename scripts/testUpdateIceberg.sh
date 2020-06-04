#!/bin/bash
set -x
set -e

REPO_ROOT="$(dirname "$(dirname "$(readlink -fm "$0")")")"

wget -O - get.pharo.org/90+vm | bash
./pharo Pharo.image st --save --quit "$REPO_ROOT/scripts/preLoading.st"
./pharo Pharo.image metacello install "tonel://$REPO_ROOT" BaselineOfIceberg --groups=development
./pharo Pharo.image st --save --quit "$REPO_ROOT/scripts/postLoading.st"
