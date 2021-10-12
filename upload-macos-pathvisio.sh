#!/bin/bash

set -e
set -u
set -o pipefail

version=`cat version.txt`
echo Releasing PharmCAT $version

if [[ $version != $1 ]]
then
  echo "Specified version ($1) does not match version.txt ($version)!"
  exit 1
fi


cd PharmGKB

tag=$(git describe --abbrev=0 --tags)
if [[ $tag != $version ]]
then
  echo "Expecting checkout @ $version but got ${tag}!"
  exit 1
fi

github-release upload --security-token $GH_TOKEN \
   --user PharmGKB \
   --repo PharmGKB \
   --tag $version \
   --name "pathvisio.app.full.zip" \
   --file build/dist/pgkb-pathvisio.app.full.zip
