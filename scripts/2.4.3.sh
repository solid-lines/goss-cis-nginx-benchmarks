#!/bin/bash
TIMEOUT=$(grep -ir keepalive_timeout /etc/nginx | awk '{print $2}' | sed 's/;//g');
if [[ "$TIMEOUT" -lt "10" && "$TIMEOUT" -gt "0" ]]; then
  echo "OK";
  exit 0;
else
  echo "FAIL";
  exit 1;
fi
