#!/bin/bash
set -eu

BIN_PATH=/work/bin

# bin/setup
$BIN_PATH/setup

# rails server
server=`ps -ef | grep puma | grep -v grep | wc -l`
if [ $server = 0 ]; then
  echo "=== run server ==="
  $BIN_PATH/rails server -b 0.0.0.0
fi

