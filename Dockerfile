FROM        aemdesign/centos-tini:centos8

LABEL   os="centos 8" \
        container.description="oracle jdk" \
        version="jdk8" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="1.8"


ARG JAVA_VERSION="8"
ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="https://www.oracle.com/au/java/technologies/javase-jdk${JAVA_VERSION}-downloads.html"
ARG ORACLE_PASSWORD="xxx"
ARG ORACLE_USERNAME="devops.aemdesign@gmail.com"

COPY oracle-download.sh .

RUN \
    echo "GET INFO ABOUT JDK" && \
    # get download page
    echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
    AUTO_PAGE=$(curl -LsN ${JAVA_DOWNLOAD_URL}) && \
    # get checksum url from download page
    AUTO_CHECKSUM_URL=https:$(echo ${AUTO_PAGE} | sed -e 's/.*href="\(.*checksum.html\)".*/\1/g') && \
    echo AUTO_CHECKSUM_URL=${AUTO_CHECKSUM_URL} && \
    # get the checksum url
    AUTO_PAGE_CHECKSUM=$(curl -LsN ${AUTO_CHECKSUM_URL}) && \
    # find jdk reference in downlaod page
    AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
    echo AUTO_JDKURLINFO=${AUTO_JDKURLINFO} && \
    # get jdk url
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e "s/.*data-file='\(//.*.rpm\)'.*/\1/g" ) && \
    echo AUTO_JDKURL=$AUTO_JDKURL && \
    # get jdk filename
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's/.*\///' ) && \
    echo AUTO_JDKFILE=$AUTO_JDKFILE && \
    # get checksum value
    AUTO_CHECKSUM_VALUE=$(echo "${AUTO_PAGE_CHECKSUM}" | grep -m1 ${AUTO_JDKFILE}) && \
    echo AUTO_CHECKSUM_VALUE=${AUTO_CHECKSUM_VALUE} && \
    AUTO_JDKSHA256=$(echo ${AUTO_CHECKSUM_VALUE} | sed -e 's/.*sha256: \([0-9a-z]*\).*/\1/g' )  && \
    echo AUTO_JDKSHA256=$AUTO_JDKSHA256 && \
    echo "DOWNLOAD JDK" && \
    # download jdk
    echo ./oracle-download.sh -C accept-securebackup-cookie -O ${AUTO_JDKFILE} -P ${ORACLE_PASSWORD} -U ${ORACLE_USERNAME} ${AUTO_JDKURL} && \
    bash ./oracle-download.sh -C accept-securebackup-cookie -O ${AUTO_JDKFILE} -P ${ORACLE_PASSWORD} -U ${ORACLE_USERNAME} ${AUTO_JDKURL} && \
    ls -l && \
    # verify jdk signature
    echo "${AUTO_JDKSHA256} ${AUTO_JDKFILE}" >> CHECKSUM && \
    cat CHECKSUM && \
    sha256sum -c CHECKSUM && \
    echo "INSTALL JDK" && \
    # install jdk
    rpm -Uvh $AUTO_JDKFILE && \
    rm -f $AUTO_JDKFILE CHECKSUM
