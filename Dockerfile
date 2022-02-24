FROM        aemdesign/tini:ubuntu-focal

LABEL   os="ubuntu focal" \
        container.description="oracle jdk" \
        version="jdk11" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java --version" \
        test.command.verify="11."

ARG FILE_NAME="jdk-11.0.14_linux-x64_bin.tar.gz"

ENV JAVA_HOME=/opt/jdk1.8.0_321/

COPY packages/ /opt

RUN \
    echo "INSTALL JDK" && \
    cd /opt/ && \
    tar -xvzf ${FILE_NAME} && \
    export JAVA_HOME=${JAVA_HOME}  && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 1 && \
    update-alternatives --config java && \
    rm -rf /opt/${FILE_NAME}
