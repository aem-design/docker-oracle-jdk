FROM        aemdesign/tini:ubuntu-focal

LABEL   os="ubuntu focal" \
        container.description="oracle jdk" \
        version="jdk8" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="1.8"

ARG FILE_NAME="jdk-8u321-linux-x64.tar.gz"

ENV JAVA_HOME=/opt/jdk1.8.0_321/

ADD packages/${FILE_NAME} /opt/

RUN \
    echo "CONFIG JDK" && \
    export JAVA_HOME=${JAVA_HOME}  && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 1 && \
    update-alternatives --config java && \
    rm -rf /opt/${FILE_NAME}
