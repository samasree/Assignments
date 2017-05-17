#The base image to use in the build
FROM centos:centos6

# File Author / Maintainer
MAINTAINER Sree

#Installing MongoDB server using epel release Repo
RUN yum -y update; yum clean all
ADD https://github.com/samasree/repofile.git  /etc/yum.repos.d/mongodb-org-3.4.repo
RUN yum install -y mongodb-org
RUN mkdir -p /data/db

#Opens a port for linked containers
EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]

#Installing python
RUN yum -y install python-pip; yum clean all

#To install Apache Tomcat 7

#Install WGET
RUN yum install -y wget

#Install tar
RUN yum install -y tar
RUN yum install -y sudo

#Install Openjdk7
RUN yum update -y && \
yum install -y wget && \
yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel && \
yum clean all

# Download Apache Tomcat 7
RUN yum install -y gzip
RUN cd /tmp;wget http://mirror.fibergrid.in/apache/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz

# untar and move to proper location
RUN cd /tmp;gunzip apache-tomcat-7.0.77.tar.gz
RUN cd /tmp;tar xvf apache-tomcat-7.0.77.tar
RUN cd /tmp;mv apache-tomcat-7.0.77 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7
RUN useradd -M -d /opt/tomcat7 tomcat7
RUN chown -R tomcat7. /opt/tomcat7
ADD https://github.com/samasree/tomcat7file.git  /etc/rc.d/init.d/tomcat7
RUN chmod 755 /etc/rc.d/init.d/tomcat7
RUN /etc/rc.d/init.d/tomcat7 start
RUN chkconfig --add tomcat7
RUN chkconfig tomcat7 on

#Sets an environment variable in the new container
ENV JAVA_HOME /opt/jdk1.7.0_79

#Opens a port for linked containers
EXPOSE 8080
RUN /opt/tomcat7/apache-tomcat-7.0.73/bin/startup.sh

#The command that runs when the container starts
#CMD ["catalina.sh", "run"]


