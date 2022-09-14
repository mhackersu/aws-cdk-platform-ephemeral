PID=$!

# Location of Creds File Relative to this Script
CRED_FILE='../../mike-creds.csv'

echo "*** START AWS CREDSTACK ***"

export USER_NAME=$(mlr --c2j --jlistwrap cat $CRED_FILE | jq '.[0] | ."User name"')
echo "User name: "$USER_NAME

export PASSWORD=$(mlr --c2j --jlistwrap cat $CRED_FILE | jq '.[0] | ."Password"')
echo "Password: ******** PASSWORD REDACTED ********"

export ACCESS_KEY_ID=$(mlr --c2j --jlistwrap cat $CRED_FILE | jq '.[0] | ."Password"')
echo "Access Key ID: ******** ACCESS KEY ID REDACTED ********"

export SECRET_ACCESS_KEY=$(mlr --c2j --jlistwrap cat $CRED_FILE | jq '.[0] | ."Secret access key"')
echo "Secret Access Key: ******** SECRET ACCESS KEY REDACTED ********"

echo "*** END AWS CREDSTACK ***"

echo "*** NO USE IN PRD / FOR DEV ONLY ***"

#/usr/bin/env bash

if which xdg-open > /dev/null; then
  xdg-open http://gitpod.io/#/un=$USER_NAME,pw=$PASSWORD,aki=$ACCESS_KEY_ID,sak=$SECRET_ACCESS_KEY/https://github.com/mhackersu/aws-platform-assessment
elif which gnome-open > /dev/null; then
  gnome-open http://gitpod.io/#/un=$USER_NAME,pw=$PASSWORD,aki=$ACCESS_KEY_ID,sak=$SECRET_ACCESS_KEY/https://github.com/mhackersu/aws-platform-assessment
elif which sensible-browser > /dev/null; then
  sensible-browser http://gitpod.io/#/un=$USER_NAME,pw=$PASSWORD,aki=$ACCESS_KEY_ID,sak=$SECRET_ACCESS_KEY/https://github.com/mhackersu/aws-platform-assessment
else
  echo "Could not detect the web browser to use."
fi

# ***

# xdg-open http://gitpod.io/#/un=$USER_NAME,pw=$PASSWORD,aki=$ACCESS_KEY_ID,sak=$SECRET_ACCESS_KEY/https://github.com/mhackersu/aws-platform-assessment

sleep 5

echo $PID

kill $PID
