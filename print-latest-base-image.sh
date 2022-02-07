#!/bin/bash

mode="$1"

set -euo pipefail

echo "mode = $mode"

if [ -z "$mode" ]; then
  echo "please set mode (markdown or file)"
  exit 1
fi

if [ "$mode" == "markdown" ]; then
  echo "| image name | latest tag and base image |"
  echo "|------------|---------------------------|"
fi

for f in base-image/*
do
  image_name="$(sed 's/base-image\///g' <<< $f)"
  latest_base_image="$(cat base-image/$image_name | head -n 1 | sed 's/.*: //g')"

  if [ "$mode" == "markdown" ]; then
    echo "| $image_name | $latest_base_image |"
  fi

  if [ "$mode" == "file" ]; then
    echo "$latest_base_image" > "base-image/${image_name}-latest"
  fi
done