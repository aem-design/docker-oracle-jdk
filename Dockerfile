  FROM        aemdesign/tini:ubuntu-focal-arm

LABEL   os="ubuntu 8 arm" \
        container.description="oracle jdk" \
        version="jdk8" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="1.8"


ARG JAVA_VERSION="8"
ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="https://www.oracle.com/au/java/technologies/javase-jdk${JAVA_VERSION}-downloads.html"
ARG JDK_DRIVEID="xxx"

COPY oracle-download.sh .

RUN \
    bash ./gdrive.sh "download" "${JDK_DRIVEID}" "jdk.rpm" && \
    echo "DOWNLOAD JDK DONE" && \
    ls -l && \
    echo "INSTALL JDK" && \
    # install jdk
    rpm -Uvh jdk.rpm
