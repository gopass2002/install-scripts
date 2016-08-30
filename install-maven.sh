#!/usr/bin/env bash

BASE_DIR=$(echo ~)
INSTALL_DIR=${BASE_DIR}/tools
TMP_DIR="/tmp/$(basename ${0%.*})-tmp"

if [[ -d ${TMP_DIR} ]]; then
    rm -rf ${TMP_DIR}
fi

# make tmp dir
mkdir -p ${TMP_DIR}

# make install dir
if [[ ! -d ${INSTALL_DIR} ]]; then
    mkdir -p ${INSTALL_DIR}
fi

# download package
BINARY_URL="http://apache.tt.co.kr/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
BINARY_NAME="apache-maven-3.3.9-bin.tar.gz"
if [ ! -f ${TMP_DIR}/${BINARY_NAME} ]; then
    echo "downloading... ${BINARY_URL}" 
    wget -O ${TMP_DIR}/${BINARY_NAME} \
    "${JAVA_BINARY_URL}"
fi

BINARY_PATH=`ls ${TMP_DIR}/*.tar.gz | grep maven`
BINARY_NAME=`basename ${BINARY_PATH}`

tar xzf /tmp/${BINARY_NAME} -C ${HOME}/tools
DIR_NAME=`ls ${INSTALL_DIR} | grep maven`

# make symbolic link
MAVEN_HOME=${HOME}/tools/maven
echo "make symbolic link"
ln -s ${INSTALL_DIR}/${DIR_NAME} ${MAVEN_HOME}

# add environment variable
echo "register environment variable, add to PATH"
echo "# for maven" >> ${HOME}/.bash_profile
echo "export MAVEN_HOME=${JAVA_HOME}" >> ${HOME}/.bash_profile
echo "export PATH=\${MAVEN_HOME}/bin:\${PATH}" >> ${HOME}/.bash_profile

# clean-up tmp dir
echo "clean up"
if [[ -d ${TMP_DIR} ]]; then
    rm -rf ${TMP_DIR}
fi

echo "done"
