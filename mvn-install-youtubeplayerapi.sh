#!/bin/bash

set -e

if [ $# -ne 0 -a $# -ne 2 ]; then
    echo "Usage: $0 [repo-id repo-url]"
    echo ""
    echo "Installs YouTube Android Player API for Android to your local Maven repo or"
    echo "deploy it to a remote repo if 'repo-id' and 'repo-url' are specified."
    echo ""
    exit 1
fi

REPO_ID="$1"
REPO_URL="$2"

GROUP_ID=com.google.android
ARTIFACT_ID=youtube-android-player-api
VERSION=1.0.0

# download the v1.0.0 of YouTube Android Player API for Android
REMOTE_FILE=https://developers.google.com/youtube/android/player/downloads/YouTubeAndroidPlayerApi-1.0.0.zip
INTERMEDIATE_ZIP=/tmp/YouTubeAndroidPlayerApi-1.0.0.zip
INTERMEDIATE_DIR=/tmp/YouTubeAndroidPlayerApi-1.0.0/
wget -q $REMOTE_FILE -O $INTERMEDIATE_ZIP
unzip -o -q $INTERMEDIATE_ZIP -d $INTERMEDIATE_DIR

# make javadoc
cd $INTERMEDIATE_DIR/docs
JAVADOC_FILE=$ARTIFACT_ID-$VERSION-javadoc.jar
zip -q -r $INTERMEDIATE_DIR/$JAVADOC_FILE .

# install locally
mvn org.apache.maven.plugins:maven-install-plugin:2.4:install-file \
    -DgroupId=$GROUP_ID \
    -DartifactId=$ARTIFACT_ID \
    -Dversion=$VERSION \
    -Dpackaging=jar \
    -Dfile=`find $INTERMEDIATE_DIR/libs/ -name '*.jar'` \
    -Djavadoc=$INTERMEDIATE_DIR/$JAVADOC_FILE \
    -DgeneratePom=true

# install remotely if applicable
if [ ! -z "$REPO_ID" ]; then
    mvn org.apache.maven.plugins:maven-deploy-plugin:2.7:deploy-file \
        -Durl=$REPO_URL \
        -DrepositoryId=$REPO_ID \
        -DgroupId=$GROUP_ID \
        -DartifactId=$ARTIFACT_ID \
        -Dversion=$VERSION \
        -Dpackaging=jar \
        -Dfile=`find $INTERMEDIATE_DIR/libs/ -name '*.jar'` \
        -Djavadoc=$INTERMEDIATE_DIR/$JAVADOC_FILE \
        -DgeneratePom=true
fi

# cleanup
rm $INTERMEDIATE_ZIP
rm -rf $INTERMEDIATE_DIR

