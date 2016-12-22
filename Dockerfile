############################################################
# Dockerfile to build STATegraEMS container image for the eBioKit
# Based on tomcat
############################################################

# Set the base image to the official Tomcat
FROM tomcat

# File Author / Maintainer
MAINTAINER Rafael Hernandez <ebiokit@gmail.com>

################## BEGIN INSTALLATION ######################
#Install mysql client for connecting to the mysql component
RUN apt-get update && apt-get install -y mysql-client  \
    && wget https://github.com/fikipollo/stategraems/archive/feature/angular.zip -O /tmp/ems.zip \
    && mkdir /tmp/ems/ \
    && unzip /tmp/ems.zip -d /tmp/ems/ \
    && cp /tmp/ems/*/dist/stategraems.war /usr/local/tomcat/webapps/  \
    && sleep 10 \
    && rm -r /usr/local/tomcat/webapps/ROOT \
    && ln -s /usr/local/tomcat/webapps/stategraems /usr/local/tomcat/webapps/ROOT  \
    && echo "export is_docker=true" >>  /usr/local/tomcat/bin/setenv.sh \
    && chmod +x /usr/local/tomcat/bin/setenv.sh

##################### INSTALLATION END #####################

# Expose port 8080 (tomcat)
EXPOSE 8080

# Mark folders as imported from the host.
VOLUME ["/data/"]
