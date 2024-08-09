#!/bin/bash
##########################################################################
##### install script for hirflPS (PowerSupply) support module ############
##########################################################################

# ARGUMENTS:
#  $1 VERSION to install (must match repo tag)
VERSION=${1}
NAME=hirflPS
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

ibek support git-clone ${NAME} ${VERSION}  --org https://github.com/anshi/

# get the source and fix up the configure/RELEASE files
ibek support register ${NAME}

# declare the libs and DBDs that are required in ioc/iocApp/src/Makefile
ibek support add-libs PSSupport
ibek support add-dbds psSupport.dbd

# global config settings
${FOLDER}/../_global/install.sh

# comment out the test directories from the Makefile
sed -i -E 's/(^[^#].*+= test.*$)/# \1/' ${SUPPORT}/${NAME}/Makefile

# compile the support module
ibek support compile ${NAME}

# prepare *.bob, *.pvi, *.ibek.support.yaml for access outside the container.
ibek support generate-links ${FOLDER}
