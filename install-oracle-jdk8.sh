#!/usr/bin/env bash

BASE_DIR=$(echo ~)
INSTALL_DIR=${BASE_DIR}/tools
TMP_DIR="/tmp/$(basename ${0%.*})-tmp"

if [[ -d ${TMP_DIR} ]]; then
    rm -rf ${TMP_DIR}
fi

# make tmp dir
mkdir -p ${TMP_DIR}

# download package
JAVA_BINARY_URL="http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz"
JAVA_BINARY_NAME="jdk-8u66-linux-x64.tar.gz"
if [ ! -f ${TMP_DIR}/${JAVA_BINARY_NAME} ]; then
    echo "downloading... ${JAVA_BINARY_URL}" 
    wget -O ${TMP_DIR}/${JAVA_BINARY_NAME} \
    --no-cookies --no-check-certificate \
    --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
    "${JAVA_BINARY_URL}"
fi

BINARY_PATH=`ls ${TMP_DIR}/*.tar.gz | grep jdk`
BINARY_NAME=`basename ${BINARY_PATH}`

tar xzf /tmp/${BINARY_NAME} -C ${HOME}/tools
DIR_NAME=`ls ${INSTALL_DIR} | grep jdk`

# make symbolic link
JAVA_HOME=${HOME}/tools/java
echo "make symbolic link"
ln -s ${INSTALL_DIR}/${DIR_NAME} ${JAVA_HOME}

# add environment variable
echo "register environment variable, add to PATH"
echo "# for java" >> ${HOME}/.bash_profile
echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME}/.bash_profile
echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> ${HOME}/.bash_profile

# clean-up tmp dir
echo "clean up"
if [[ -d ${TMP_DIR} ]]; then
    rm -rf ${TMP_DIR}
fi

echo "done"
