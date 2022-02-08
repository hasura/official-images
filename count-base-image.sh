#!/bin/bash

set -eo pipefail

# use it like this
# ./count-base-image.sh plain | sort -k 2n  | tac | perl markdownit.pl

mode="$1"

declare -A base_images

if [ -z "$mode" ]; then
  echo "please set mode (markdown, plain)"
  exit 1
fi

if [ "$mode" == "markdown" ]; then
  echo "| base image | number of times used in official images|"
  echo "|------------|----------------------------------------|" 
fi

for f in latest-base-image/*
do
  image_name="$(sed 's/latest-base-image\///g' <<< $f)"
  latest_base_image="$(cat latest-base-image/$image_name)"

  value="${base_images[$latest_base_image]}"
  if [ -z "$value" ]; then
    base_images[$latest_base_image]=1
  else
    base_images[$latest_base_image]=$(( $value + 1 ))
  fi
done

for key in "${!base_images[@]}"
do
value="${base_images[$key]}"

if [ "$mode" == "markdown" ]; then
  echo "| $key | $value |"
fi
if [ "$mode" == "plain" ]; then
  echo "$key $value"
fi

done