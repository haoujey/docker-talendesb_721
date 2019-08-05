FROM ubuntu:18.04

USER root

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y \
		software-properties-common unzip \
                ca-certificates \
                openssh-client \
                curl \
		openssl \
		wget \
		gnupg2

# install JDK
RUN echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
RUN apt-get update
RUN echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections
RUN apt -y install oracle-java11-set-default
RUN java -version

# remove download archive files
RUN apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-11-oracle

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
