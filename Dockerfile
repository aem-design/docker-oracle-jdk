FROM        aemdesign/centos-tini:centos7

MAINTAINER  devops <devops@aem.design>

LABEL   os="centos 7" \
        container.description="oracle jdk" \
        version="jdk8" \
        imagename="oracle-jdk" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="1.8"

ARG JAVA_VERSION="8"
ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html"
ARG ORACLE_PASSWORD="xxx"
ARG ORACLE_USERNAME="devops.aemdesign@gmail.com"

COPY oracle-download.sh .

RUN chmod +x oracle-download.sh && \
    echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
    AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && \
    echo AUTO_JDKURL=$AUTO_JDKURL && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)",".*/\1/g' )  && \
    echo AUTO_JDKSHA256=$AUTO_JDKSHA256 && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    echo AUTO_JDKFILE=$AUTO_JDKFILE && \
    echo ./oracle-download.sh --cookie=accept-securebackup-cookie --output=${AUTO_JDKFILE} --password=${ORACLE_PASSWORD} --username=${ORACLE_USERNAME} ${AUTO_JDKURL} && \
    echo $(./oracle-download.sh --cookie=accept-securebackup-cookie --output=${AUTO_JDKFILE} --password=${ORACLE_PASSWORD} --username=${ORACLE_USERNAME} ${AUTO_JDKURL}) && \
    echo "${AUTO_JDKMD5}  ${AUTO_JDKFILE}" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh $AUTO_JDKFILE && \
    rm -f $AUTO_JDKFILE MD5SUM
