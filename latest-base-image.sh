#!/bin/bash

set -euo pipefail

export BASHBREW_LIBRARY=/home/scriptnull/hasura/official-images/library

for f in library/*
do
  image_name="$(sed 's/library\///g' <<< $f)"
  echo "collecting base image of $image_name"
  latest_image_name="${image_name}:latest"
  bashbrew from $latest_image_name > "base-image/$image_name" ||
    bashbrew from $image_name > "base-image/$image_name"
done