#!/bin/bash
HOSTNAME=`hostname`
echo $HOSTNAME
STATUS_CODE="301"
#$(curl -s -o /dev/null -w "%{http_code}" http://`hostname`)
EXPECTED_CODE="301"
echo $STATUS_CODE:$EXPECTED_CODE
if [[ "${STATUSCODE}" == "${EXPECTED_CODE}" ]]; then
  LOCATION=$(curl -I http://$HOSTNAME | grep Location | awk '{print $2}');
  echo $LOCATION
  if [[ "$LOCATION" == "https://$HOSTNAME/" ]]; then
    echo "OK"
    exit 0;
  else
    echo "FAIL LOC";
    exit 1;
  fi
else
  echo "FAIL CODE";
  exit 1;
fi
