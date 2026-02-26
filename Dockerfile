FROM        aemdesign/tini:ubuntu-focal

LABEL   os="ubuntu focal" \
        container.description="oracle jdk" \
        version="jdk21" \
        maintainer="devops <devops@aem.design>" \
        imagename="oracle-jdk" \
        test.command=" java --version" \
        test.command.verify="21."

ARG FILE_NAME="jdk-21_linux-x64_bin.tar.gz"

ENV JAVA_HOME="/opt/jdk-21/"

ADD packages/${FILE_NAME} /opt/

RUN \
    echo "CONFIG JDK" && \
    JDK_DIR="$(find /opt -maxdepth 1 -type d -name 'jdk-21*' | head -n 1)" && \
    test -n "${JDK_DIR}" && \
    ln -sfn "${JDK_DIR}" "${JAVA_HOME%/}" && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 1 && \
    update-alternatives --set java ${JAVA_HOME%*/}/bin/java && \
    rm -f /opt/${FILE_NAME}
