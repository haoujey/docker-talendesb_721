FROM java:8-jdk

MAINTAINER haoujey

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Download Talend Open Studio for ESB
RUN curl -sSo /opt/TOS_ESB-20170623_1246-V6.4.1.zip https://download-mirror2.talend.com/esb/release/V6.4.1/TOS_ESB-20170623_1246-V6.4.1.zip > /dev/null

# Install Talend Open Studio for ESB

RUN unzip /opt/TOS_ESB-20170623_1246-V6.4.1.zip -d /opt/TOS_ESB-20170623_1246-V6.4.1 && \
	rm /opt/TOS_ESB-20170623_1246-V6.4.1.zip && \
	rm -rf /opt/TOS_ESB-20170623_1246-V6.4.1/Studio && \
	chmod 777 /opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/bin/trun

VOLUME ["/opt/TOS_ESB-20170623_1246-V6.4.1/Runtime_ESBSE/container/deploy"]

EXPOSE 1099 8040 8101 8181 44444
