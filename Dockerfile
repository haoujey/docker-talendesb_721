FROM openjdk:8-jdk

LABEL maintainer haoujey

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION=8u121
ENV JAVA_DEBIAN_VERSION=8u121-b13-1~bpo8+1
ENV CA_CERTIFICATES_JAVA_VERSION=20161107~bpo8+1

RUN set -x && apt-get update && apt-get install

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
