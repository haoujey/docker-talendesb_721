FROM alpine:latest

LABEL maintainer haoujey

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8
ENV JAVA_VERSION=8 \
    JAVA_UPDATE=161 \
    JAVA_BUILD=12 \
    JAVA_PATH=2f38c3b165be4555a1fa6e98c45e0808 \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

RUN apk add --update curl && rm -rf /var/cache/apk/*

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" && \
    unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" && \
    rm "${JAVA_HOME}/jre/lib/security/README.txt" && \
    apk del build-dependencies && \
    rm "/tmp/"*



# Download Talend Open Studio for ESB
RUN curl -sSo /opt/TOS_ESB-20170623_1246-V6.4.1.zip https://download-mirror2.talend.com/esb/release/V6.4.1/TOS_ESB-20170623_1246-V6.4.1.zip > /dev/null

# Install Talend Open Studio for ESB

RUN unzip /opt/TOS_ESB-20170623_1246-V6.4.1.zip -d /opt/TOS_ESB-20170623_1246-V6.4.1 && \
	rm /opt/TOS_ESB-20170623_1246-V6.4.1.zip && \
	rm -rf /opt/TOS_ESB-20170623_1246-V6.4.1/Studio && \
	chmod 777 /opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/bin/trun && \
	chmod 777 /opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/bin/start

VOLUME ["/opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/deploy"]

EXPOSE 1099 8040/tcp 8101 8181 44444

ENTRYPOINT ["/opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/bin"]
