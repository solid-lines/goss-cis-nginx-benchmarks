#!/bin/bash
USER=$(grep '^user[^;]*;' /etc/nginx/nginx.conf | awk '{print $2}' | sed 's/;//g');
if [[ "$(groups ${USER})" == "${USER} : ${USER}" ]]; then
  echo "OK";
  exit 0;
else
  echo "FAIL";
  exit 1;
fi
