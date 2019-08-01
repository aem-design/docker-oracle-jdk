FROM        aemdesign/centos-tini:latest

MAINTAINER  devops <devops@aem.design>

LABEL   os="centos" \
        container.description="oracle jdk" \
        version="1.0-jdk11" \
        imagename="oracle-jdk"

ARG JAVA_VERSION="11"
ARG JAVA_VERSION_TIMESTAMP="5066655"
ARG JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html"
ARG ORACLE_PASSWORD="xxx"
ARG ORACLE_USERNAME="devops.aemdesign@gmail.com"

COPY oracle-download.sh .

RUN chmod +x oracle-download.sh && \
    echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
    AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && \
    echo AUTO_JDKURL=$AUTO_JDKURL && \
    AUTO_JDKSHA256=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"SHA256":"\(.*\)".*/\1/g' )  && \
    echo AUTO_JDKSHA256=$AUTO_JDKSHA256 && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    echo AUTO_JDKFILE=$AUTO_JDKFILE && \
    echo ./oracle-download.sh --cookie=accept-securebackup-cookie --output=${AUTO_JDKFILE} --password=${ORACLE_PASSWORD} --username=${ORACLE_USERNAME} ${AUTO_JDKURL} && \
    echo $(./oracle-download.sh --cookie=accept-securebackup-cookie --output=${AUTO_JDKFILE} --password=${ORACLE_PASSWORD} --username=${ORACLE_USERNAME} ${AUTO_JDKURL}) && \
    echo "${AUTO_JDKSHA256}  ${AUTO_JDKFILE}" >> CHECKSUM && \
    cat CHECKSUM && \
    sha256sum -c CHECKSUM && \
    rpm -Uvh $AUTO_JDKFILE && \
    rm -f $AUTO_JDKFILE CHECKSUM
