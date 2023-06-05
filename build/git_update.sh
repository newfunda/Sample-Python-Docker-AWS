#!/bin/bash

VERSION=""

# Get parameters
while getopts v:flag
do
    case "${flag}" in
        v) VERSION=${OPTARG};;
    esac
done

# Get highest tag number, and add v.0.1.0 if doesn't exists
git fetch --prune --unshallow 2>/dev/null
CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`

if [[ $CURRENT_VERSION == '' ]]
then
    CURRENT_VERSION='v.0.1.0'
fi
echo "Current Vesion: $CURRENT_VERSION"

# Replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })

# Get number parts
VNUM1=${CURRENT_VERSION_PARTS[1]}
VNUM2=${CURRENT_VERSION_PARTS[2]}
VNUM3=${CURRENT_VERSION_PARTS[3]}

if [[ $VERSION == 'major' ]]
then
    VNUM1=v.$((VNUM1+1))
elif [[ $VERSION == 'minor' ]]
then
    VNUM2=$((VNUM2+1))
elif [[ $VERSION == 'patch' ]]
    VNUM3=$((VNUM3+1))
else
    echo "No version type (https://semver.org/) or incorrect type specified, try -v [major, minor, patch]"
    exit 1
fi

# Create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

# Get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`

# Only tag if no tag already
if [ -z "$NEEDS_TAG" ]; then
    echo "Tagged with $NEW_TAG"
    git tag $NEW_TAG
    git push --tags
    git push
else
    echo "Already a tag on this commit"
fi

echo ::set-output name=git-tag::$NEW_TAG

exit 0