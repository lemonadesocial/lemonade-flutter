#!/bin/bash

# Check if a build number is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <BUILD_NUMBER>"
  exit 1
fi

BUILD_NUMBER=$1

# Auto append build number into version of pubspec file
# Example: 1.20.0 become 1.20.0+35
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+)(\+\d+)?$/$1+'$BUILD_NUMBER'/' ../pubspec.yaml


