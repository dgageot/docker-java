FROM ubuntu:14.10
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -yqq \
  bzip2 \
  curl \
  phantomjs

# Install java
#
RUN curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz | tar xfz -

ENV JAVA_HOME /jdk1.8.0_40
ENV PATH $PATH:$JAVA_HOME/bin

# Install maven
#
RUN curl -s http://apache.crihan.fr/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz | tar xzf -

ENV MAVEN_HOME /apache-maven-3.1.1
ENV PATH $PATH:$MAVEN_HOME/bin

# Minimal warmup of maven
#
RUN mkdir /tmp/warmup \
	&& cd /tmp/warmup \
	&& echo "<project><modelVersion>4.0.0</modelVersion><groupId>warmup</groupId><artifactId>warmup</artifactId><version>0.1-SNAPSHOT</version><properties><project.build.sourceEncoding>UTF-8</project.build.sourceEncoding></properties></project>" > pom.xml \
	&& mvn clean install dependency:go-offline \
	&& rm -Rf /tmp/warmup

