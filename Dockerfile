FROM ubuntu:14.10
MAINTAINER David Gageot <david@gageot.net>

RUN apt-get update -qq && apt-get install -yqq \
  bzip2 \
  curl \
  phantomjs

# Install java
#
RUN (curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://www.java.net/download/jdk8u40/archive/b20/binaries/jdk-8u40-ea-bin-b20-linux-x64-31_dec_2014.tar.gz | tar xfz -)

ENV JAVA_HOME /jdk1.8.0_40
ENV PATH $PATH:$JAVA_HOME/bin

# Install maven
#
RUN curl -s http://apache.crihan.fr/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz | tar xzf - -C /

ENV MAVEN_HOME /apache-maven-3.1.1
ENV PATH $PATH:$MAVEN_HOME/bin
