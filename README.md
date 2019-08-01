## CentOS 7 with Oracle JDK

[![build_status](https://travis-ci.org/aem-design/oracle-jdk.svg?branch=master)](https://travis-ci.org/aem-design/oracle-jdk)
[![github license](https://img.shields.io/github/license/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk) 
[![github issues](https://img.shields.io/github/issues/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk) 
[![github last commit](https://img.shields.io/github/last-commit/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk) 
[![github repo size](https://img.shields.io/github/repo-size/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk) 
[![docker stars](https://img.shields.io/docker/stars/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk) 
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk) 
[![github release](https://img.shields.io/github/release/aem-design/centos-tini)](https://github.com/aem-design/centos-tini)

This is docker image based on [aemdesign/centos-tini](https://hub.docker.com/r/aemdesign/centos-tini/) with Oracle JDK added.

### Included Packages

Following is the list of packages included

* jdk                   - for java processes

### Manual JDK Download Test

Following script finds latest version of java package.

JDK8

```bash
export JAVA_VERSION="8" && \
export JAVA_VERSION_TIMESTAMP="2133151" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html" && \
export AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
echo AUTO_JDKURLINFO=$AUTO_JDKURLINFO && \
AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && \
AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)",".*/\1/g' )  && \
AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
echo JAVA_VERSION_TIMESTAMP=$JAVA_VERSION_TIMESTAMP && \
echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
echo AUTO_JDKURL=$AUTO_JDKURL && \
echo AUTO_JDKMD5=$AUTO_JDKMD5 && \
echo AUTO_JDKFILE=$AUTO_JDKFILE
```

JDK11

```bash
export JAVA_VERSION="11" && \
export JAVA_VERSION_TIMESTAMP="5066655" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html" && \
export AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}\.*linux\.*x64.*.rpm ) && \
echo AUTO_JDKURLINFO=$AUTO_JDKURLINFO && \
AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && \
AUTO_JDKSHA256=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"SHA256":"\(.*\)".*/\1/g' )  && \
export AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
echo JAVA_VERSION_TIMESTAMP=$JAVA_VERSION_TIMESTAMP && \
echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
echo AUTO_JDKURL=$AUTO_JDKURL && \
echo AUTO_JDKSHA256=$AUTO_JDKSHA256 && \
echo AUTO_JDKFILE=$AUTO_JDKFILE
```


### Test

Following is used to test if container version matches whats is expected.


Get build number for JDK8

```bash
export JAVA_VERSION="8" && \
export JAVA_VERSION_TIMESTAMP="2133151" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html" && \
export AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && echo $AUTO_JDKURL | sed -e "s/.*jdk-${JAVA_VERSION}u\(.*\)[-_]linux.*/\1/g"
```

Get version number for JDK11

```bash
export JAVA_VERSION="11" && \
export JAVA_VERSION_TIMESTAMP="5066655" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk${JAVA_VERSION}-downloads-${JAVA_VERSION_TIMESTAMP}.html" && \
export AUTO_JDKURLINFO=$(curl -LsN ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-${JAVA_VERSION}.*linux.*x64.*.rpm ) && \
AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(http.*.rpm\)".*/\1/g' ) && echo $AUTO_JDKURL | sed -e "s/.*jdk-\(.*\)[-_]linux.*/\1/g"
```
