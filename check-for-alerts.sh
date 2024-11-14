#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input-file>"
  exit 1
fi

# Search for the string "<Alert Name" in the input file
if grep -q '<Alert Name' "$1"; then
  echo "Alert Found"
  exit 1
else
  echo "No Alert Found"
  exit 0
fi