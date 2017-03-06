#!/bin/sh
set -e

echo "Executing entrypoint"


if [ -z "$SONAR_LOGIN" ]; then
    echo "SONAR_LOGIN NOT FOUND";
    exit 1;
fi

if [ -z "$SONAR_PASSWORD" ]; then
    echo "SONAR_PASSWORD NOT FOUND";
    exit 1;
fi

if [ -z "$SONAR_HOST" ]; then
    echo "SONAR_HOST NOT FOUND";
    exit 1;
fi

if [ -z "$PROJECT_ORG" ]; then
    echo "PROJECT_ORG NOT FOUND";
    exit 1;
fi

if [ -z "$PROJECT_NAME" ]; then
    echo "PROJECT_NAME NOT FOUND";
    exit 1;
fi


response=$(curl -s -u $SONAR_LOGIN:$SONAR_PASSWORD $SONAR_HOST/api/qualitygates/project_status?projectKey=$PROJECT_ORG:$PROJECT_NAME | jq '.projectStatus.status')

case "$response" in
  *ERROR*)
    echo "Quality gate not passed";
  	exit 1;
  ;;
esac

echo "Quality gate passed !";