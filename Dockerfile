FROM        aemdesign/centos-tini:latest

MAINTAINER  devops <devops@aem.design>

LABEL   os.version="centos" \
        container.description="oracle jdk 8"

ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-$JAVA_VERSION_TIMESTAMP.html"

RUN AUTO_JDKURLINFO=$(curl -ls ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-8u.*\-linux\-x64\.rpm ) && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(.*\)","MD5":.*/\1/g') && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)","SHA256":.*/\1/g' )  && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    curl -L -O --header "Cookie: oraclelicense=accept-securebackup-cookie" $AUTO_JDKURL && \
    echo "${AUTO_JDKMD5}  ${AUTO_JDKFILE}" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh $AUTO_JDKFILE && \
    rm -f $AUTO_JDKFILE
