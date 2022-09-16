#!/bin/bash

echo "This is the builder"

# Prep any additional shell scripts with this command
# Removes carriage return by substituting \r for an empty string
# The utiliy used here is the sed tool (stream edit command)
# sed -i -e 's/\r$//' script.sh

./.ci_aws_creds.sh