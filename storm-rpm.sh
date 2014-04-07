#!/usr/bin/env bash
#
# This script packages a Storm release tarball as RHEL6/CentOS6 RPM using fpm.
#
# NOTE: To simplify switching JDK versions for use with Storm WE DO NOT ADD A DEPENDENCY ON A
#       SPECIFIC JDK VERSION to the Storm RPM.  You must manage the installation of JDK manually!
#
#       Before this decision we specified the JDK dependency e.g. via the fpm option:
#           -d "java-1.6.0-openjdk"

### CONFIGURATION BEGINS ###

INSTALL_ROOT_DIR=/opt/storm
MAINTAINER="<michael@michael-noll.com>"

### CONFIGURATION ENDS ###

function print_usage() {
    myself=`basename $0`
    echo "Usage: $myself <storm-zipball-download-url>"
    echo
    echo "Examples:"
    echo "  \$ $myself http://www.eu.apache.org/dist/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip"
}

if [ $# -ne 1 ]; then
    print_usage
    exit 1
fi

STORM_DOWNLOAD_URL="$1"
STORM_ZIPFILE=`basename $1`
STORM_VERSION=`echo $STORM_ZIPFILE | sed -r 's/^apache-storm-(.*).zip$/\1/'`
echo "Building an RPM for Storm release version $STORM_VERSION..."

# Prepare environment
OLD_PWD=`pwd`
BUILD_DIR=`mktemp -d /tmp/storm-build.XXXXXXXXXX`
cd $BUILD_DIR

cleanup_and_exit() {
  local exitCode=$1
  rm -rf $BUILD_DIR
  cd $OLD_PWD
  exit $exitCode
}

# Download and extract the requested Storm release zipfile
wget $STORM_DOWNLOAD_URL || cleanup_and_exit $?
unzip $STORM_ZIPFILE || cleanup_and_exit $?

# Build the RPM
cd apache-storm-$STORM_VERSION
fpm -s dir -t rpm -a all \
    -n storm \
    -v $STORM_VERSION \
    --iteration "1.miguno" \
    --maintainer "$MAINTAINER" \
    --vendor "Storm Project" \
    --url http://storm-project.net \
    --description "Distributed real-time computation system" \
    -p $OLD_PWD/storm-VERSION.el6.ARCH.rpm \
    -a "x86_64" \
    --prefix $INSTALL_ROOT_DIR \
    * || cleanup_and_exit $?

echo "You can verify the proper creation of the RPM file with:"
echo "  \$ rpm -qpi storm-*.rpm    # show package info"
echo "  \$ rpm -qpR storm-*.rpm    # show package dependencies"
echo "  \$ rpm -qpl storm-*.rpm    # show contents of package"

# Clean up
cleanup_and_exit 0
