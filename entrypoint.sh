#!/bin/sh
set -e

echo "Executing entrypoint"


if [ -z "$PLUGIN_USERNAME" ]; then
    echo "username not set!";
    exit 1;
fi

if [ -z "$PLUGIN_PASSWORD" ]; then
    echo "password not set!";
    exit 1;
fi

if [ -z "$PLUGIN_HOST" ]; then
    echo "host not set!";
    exit 1;
fi

if [ -z "$PLUGIN_PROJECT_ORGANIZATION" ]; then
    echo "project_organization not set!";
    exit 1;
fi

if [ -z "$PLUGIN_PROJECT_NAME" ]; then
    echo "project_name not set!";
    exit 1;
fi


response=$(curl -s -u $PLUGIN_USERNAME:$PLUGIN_PASSWORD $PLUGIN_HOST/api/qualitygates/project_status?projectKey=$PLUGIN_PROJECT_ORGANIZATION:$PLUGIN_PROJECT_NAME | jq '.projectStatus.status')

case "$response" in
  *ERROR*)
    echo "Quality gate not passed";
  	exit 1;
  ;;
esac

echo "Quality gate passed !";