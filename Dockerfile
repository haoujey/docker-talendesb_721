FROM ubuntu:18.04

USER root

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y \
		software-properties-common unzip \
                ca-certificates \
                openssh-client \
                curl

# Java installation
RUN apt-add-repository -y ppa:webupd8team/java && \
	apt-get -y update && \
	yes | apt-get install -y oracle-java8-installer

#RUN apt-add-repository -y ppa:linuxuprising/java && \
#	apt-get -y update && \
#	yes | apt-get install -y oracle-java11-installer-local

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Download Talend Open Studio for ESB
RUN curl -sSo /opt/TOS_ESB-20190620_1446-V7.2.1.zip https://download-mirror2.talend.com/esb/release/V7.2.1/TOS_ESB-20190620_1446-V7.2.1.zip > /dev/null

# Install Talend Open Studio for ESB

RUN unzip /opt/TOS_ESB-20190620_1446-V7.2.1.zip -d /opt/TOS_ESB && \
	rm /opt/TOS_ESB-20190620_1446-V7.2.1.zip && \
	rm -rf /opt/TOS_ESB/Studio && \	
	chmod 777 /opt/TOS_ESB/Runtime_ESBSE/container/bin/trun && \
 	chmod 777 /opt/TOS_ESB/Runtime_ESBSE/container/bin/start

VOLUME ["/opt/TOS_ESB/Runtime_ESBSE/container/deploy"]

EXPOSE 1099 8040/tcp 8080 8101 8181 8443 9001 44444
