#!/usr/bin/env bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -e environment"
   echo -e "\t-e The environment to deploy osfooler to (dev/staging/production)"
   exit 1 # Exit script after printing help
}

while getopts "e:" opt
do
   case "$opt" in
      e ) environment="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$environment" ]
then
   echo "Environment is not set";
   helpFunction
fi

case $environment in
"dev")
  bucket_name="file-seed-templates"
  profile="seedata-dev"
  ;;
"staging")
  bucket_name="file-seed-templates-staging"
  profile="seedata-staging"
  ;;
"production")
  bucket_name="file-seed-templates-prod"
  profile="seedata-production"
  ;;

"*")
  echo "Invalid environment set. Please make sure you are running this command with the correct AWS credentials for seedata's dev/staging/production account."
  exit 1
  ;;
esac

echo "Building OS fooler"

sudo pyinstaller --onefile setup-exe.py --windowed --name osfooler

AWS_PROFILE=${profile} aws s3 cp dist/osfooler "s3://${bucket_name}/templates/osfooler" > /dev/null

echo "OS fooler uploaded to S3 - ${bucket_name}/templates/osfooler"


