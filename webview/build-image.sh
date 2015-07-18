#!/bin/sh

errors=false
INTROSCOPE_VERSION=10.0.0.12
INTROSCOPE_BUILD=10.0.0-ISCP/build-990010\(${INTROSCOPE_VERSION}\)
TRUSS_URL=http://truss.ca.com/builds/InternalBuilds
INTROSCOPE_TAR=introscope${INTROSCOPE_VERSION}other.tar
INTROSCOPE_BIN=introscope${INTROSCOPE_VERSION}otherUnix.jar
INTROSCOPE_OSGI=osgiPackages.v${INTROSCOPE_VERSION}.unix.tar
SUDO=

if [ ! -e $INTROSCOPE_BIN ] ; then
	if [ -e ../enterprise-manager/$INTROSCOPE_BIN ]; then
		cp ../enterprise-manager/$INTROSCOPE_BIN .
	else
		wget ${TRUSS_URL}/${INTROSCOPE_BUILD}/introscope${INTROSCOPE_VERSION}/introscope${INTROSCOPE_VERSION}other.tar
  	tar xvopf introscope${INTROSCOPE_VERSION}other.tar ${INTROSCOPE_BIN}
  fi
fi

if [ ! -e $INTROSCOPE_OSGI ] ; then
	if [ -e ../enterprise-manager/$INTROSCOPE_OSGI ]; then
		cp ../enterprise-manager/$INTROSCOPE_OSGI .
	else
  	wget ${TRUSS_URL}/${INTROSCOPE_BUILD}/opensource/${INTROSCOPE_OSGI}
	fi
fi

if [ "$errors" = false ] ; then
	echo "Starting the build"
	if [ "$(id -u)" != "0" ]; then
		if [ "$(uname)" != "Darwin" ]; then
	    SUDO=sudo
	  fi
	fi
	$SUDO docker build -t apm-webview .
fi
