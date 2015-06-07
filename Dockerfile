FROM danillosl/oracle_java 

MAINTAINER Danillo Lisboa <danillosl@gmail.com>

ENV SONARQUBE_HOME /opt/sonarqube

# Http port
EXPOSE 9000

# H2 Database port
EXPOSE 9092

# Database configuration
# Defaults to using H2
ENV SONARQUBE_JDBC_USERNAME sonar
ENV SONARQUBE_JDBC_PASSWORD sonar
ENV SONARQUBE_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar

ENV SONAR_VERSION 5.1

RUN yum install unzip -y
RUN cd /opt \
&& curl  http://downloads.sonarsource.com/sonarqube/sonarqube-5.1.zip > sonarqube.zip \
&& unzip sonarqube.zip \
&& mv sonarqube-5.1 sonarqube \
&& rm sonarqube.zip \
&& yum remove unzip -y \
&& yum clean all -y

WORKDIR $SONARQUBE_HOME/
ENTRYPOINT ["./bin/linux-x86-64/sonar.sh", "console"]
