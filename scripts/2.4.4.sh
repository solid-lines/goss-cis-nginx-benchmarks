#!/bin/bash
TIMEOUT=$(grep -ir ^send_timeout /etc/nginx | awk '{print $2}' | sed 's/;//g');
if [[ "$TIMEOUT" -lt "11" && "$TIMEOUT" -gt "0" ]]; then
  echo "OK";
  exit 0;
else
  echo "FAIL";
  exit 1;
fi

