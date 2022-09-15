#!/bin/bash

echo "# Setting up AWS Credentials and Region for CLI Tooling"

mkdir ~/.aws

touch ~/.aws/config

echo "[default]" >> ~/.aws/config
echo "region=us-east-1" >> ~/.aws/config

touch ~/.aws/credentials

echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id="$aki | tr -d '"' >> ~/.aws/credentials
echo "aws_secret_access_key="$sak | tr -d '"' >> ~/.aws/credentials