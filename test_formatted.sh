#/bin/bash

RED='\033[1;91m'
BLUE='\033[1;94m'
HI='\033[1;97m'
NC='\033[0m' # No Color

TOTAL_FAILED_COUNT="0"
TOTAL_COUNT="0"

for f in $(ls ./tests/nginx_scored*.yml); do
    status="0"
    echo ""
    echo -e "${HI}Running: goss --gossfile ${f} validate -f json -o pretty${NC}"
    echo ""
    OUTPUT=$(goss --gossfile ${f} validate -f json -o pretty)
	FAILED_COUNT=$(echo $OUTPUT | jq -r '.summary."failed-count"')
	TOTAL_FAILED_COUNT=$(( TOTAL_FAILED_COUNT + $FAILED_COUNT ))
	COUNT=$(echo $OUTPUT | jq -r '.summary."test-count"')
	TOTAL_COUNT=$(( $TOTAL_COUNT + $COUNT ))
	SUMMARY=$(echo $OUTPUT | jq -r '.summary."summary-line"')
	if [[ "${FAILED_COUNT}" == "0" ]]; then
		echo -e "${BLUE}SUMMARY -> $SUMMARY${NC}\n"
	else
		echo $OUTPUT | jq -r '.results[] | select(.successful==false) | (.title) + "  FAILED!!\n\nSUGGESTED REMEDIATION: " + (.meta.Remediation) + "\n\n"'
		echo -e "${RED}SUMMARY -> $SUMMARY${NC}\n"
	fi
done

echo -e "${HI}FINAL SUMMARY -> Count: $TOTAL_COUNT, Failed: $TOTAL_FAILED_COUNT${NC}"
