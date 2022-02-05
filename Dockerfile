  FROM        aemdesign/tini:debian-arm

LABEL   os="debian 8 arm" \
        container.description="oracle jdk" \
        version="jdk11" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="11."


ARG JDK_DRIVEID="xxx"

ENV JAVA_HOME=/opt/jdk-11.0.14/

COPY gdrive.sh .

RUN \
    echo "DOWNLOAD JDK DONE" && \
    bash ./gdrive.sh "download" "${JDK_DRIVEID}" "/opt/jdk.tar.gz" && \
    echo "INSTALL JDK" && \
    cd /opt/ && \
    tar -xvzf jdk.tar.gz && \
    export JAVA_HOME=${JAVA_HOME}  && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 1 && \
    update-alternatives --config java && \
    rm -rf /opt/jdk.tar.gz
