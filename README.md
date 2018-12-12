## CentOS 7 with Oracle JDK

[![pipeline status](https://gitlab.com/aem.design/oracle-jdk/badges/master/pipeline.svg)](https://gitlab.com/aem.design/oracle-jdk/commits/master)

This is docker image based on [aemdesign/centos-tini](https://hub.docker.com/r/aemdesign/centos-tini/) with JDK added

### Included Packages

Following is the list of packages included

* jdk                   - for java processes

### Manual JDK Download Test

```bash
export JAVA_VERSION_TIMESTAMP="2133151" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html" && \
    export AUTO_JDKURLINFO=$(curl -Ls ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-8u.*\-linux\-x64\.rpm ) && \
    echo AUTO_JDKURLINFO=$AUTO_JDKURLINFO && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(.*\)","MD5":.*/\1/g') && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)","SHA256":.*/\1/g' )  && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    echo JAVA_VERSION_TIMESTAMP=$JAVA_VERSION_TIMESTAMP && \
    echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
    echo AUTO_JDKURL=$AUTO_JDKURL && \
    echo AUTO_JDKMD5=$AUTO_JDKMD5 && \
    echo AUTO_JDKFILE=$AUTO_JDKFILE
```