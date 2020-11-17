#!/bin/bash
set -x
set -e

if [[ $* == *--dev* ]]
then
    BASELINE_GROUPS=development
else
    BASELINE_GROUPS=default
fi

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_DIR="$(dirname "$SCRIPTS_DIR")"

curl https://get.pharo.org/64/vm90 | bash
wget http://files.pharo.org/image/90/Pharo9.0-SNAPSHOT.build.832.sha.de1f37b.arch.64bit.zip
unzip Pharo9.0-SNAPSHOT.build.832.sha.de1f37b.arch.64bit.zip
mv Pharo9.0-SNAPSHOT-64bit-de1f37b.image Pharo.image
mv Pharo9.0-SNAPSHOT-64bit-de1f37b.changes Pharo.changes

./pharo Pharo.image st --save --quit "$REPO_DIR/scripts/preLoading.st"
./pharo Pharo.image metacello install "tonel://$REPO_DIR" BaselineOfIceberg --groups=$BASELINE_GROUPS
./pharo Pharo.image st --save --quit "$REPO_DIR/scripts/postLoading.st"
