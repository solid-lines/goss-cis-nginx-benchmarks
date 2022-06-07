#!/bin/bash

set -e

function check_goss() {
  which goss | grep -o goss > /dev/null && return 0 || return 1
}
if check_goss == 0 ; then
  echo "Goss already installed"
else
  curl -L https://github.com/aelsabbahy/goss/releases/latest/download/goss-linux-amd64 -o /usr/local/bin/goss
  chmod +rx /usr/local/bin/goss
  echo "Goss has been installed!"
fi
