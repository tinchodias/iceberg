#!/bin/bash
set -x
set -e

wget -O - get.pharo.org/80+vm | bash
./pharo Pharo.image st --save --quit scripts/updateIceberg.st 