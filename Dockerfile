FROM        aemdesign/centos-tini:latest

MAINTAINER  devops <devops@aem.design>

LABEL   os="centos" \
        container.description="oracle jdk 8" \
        version="1.0-jdk8" \
        imagename="oracle-jdk"

ARG JAVA_VERSION="8"
ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html"
ARG ORACLE_PASSWORD="xxx"
ARG ORACLE_USERNAME="devops.aemdesign@gmail.com"

COPY oracle-download.sh .

RUN chmod +x oracle-download.sh && \
    AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)",".*/\1/g' )  && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    echo ./oracle-download.sh --cookie=accept-securebackup-cookie --output=${AUTO_JDKFILE} --password=${ORACLE_PASSWORD} --username=${ORACLE_USERNAME} ${AUTO_JDKURL} && \
    echo "${AUTO_JDKMD5}  ${AUTO_JDKFILE}" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh $AUTO_JDKFILE && \
    rm -f $AUTO_JDKFILE MD5SUM
