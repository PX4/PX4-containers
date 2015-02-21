#!/bin/bash
#
# TODO: wiki page
# TODO: logs from px4 durign sitl tests?
# TODO: Github auth for Jenkins?
#

sudo apt-get update

# A few directories
sudo mkdir -p /build/docker
sudo mkdir -p /build/jenkins
sudo chmod 700 /build/docker

# Install Java, only headless runtime
sudo apt-get install default-jre-headless

# Install Tomcat
# > not necessary, using jenkins standalone
#sudo apt-get install tomcat7

# Install Apache (as proxy)
sudo apt-get install apache2

# Install Jenkins
# > https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins-ci.list'
sudo apt-get update
sudo apt-get install jenkins

sudo service jenkins stop
sudo chown jenkins /build/jenkins
sudo chgrp jenkins /build/jenkins
sudo sed -i.orig "s/#\?JENKINS_HOME=.*/JENKINS_HOME=\\/build\\/jenkins/" /etc/default/jenkins
sudo sh -c 'echo JAVA_ARGS=\"\$JAVA_ARGS -Xmx256m -XX:MaxPermSize=128m\" >> /etc/default/jenkins'
sudo service jenkins start
sudo rm -r /var/lib/jenkins

# Configure proxy
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2dissite 000-default
sudo cp jenkins.site /etc/apache2/sites-available/jenkins.conf
sudo a2ensite jenkins
sudo apache2ctl restart

# Install Docker
# > http://docs.docker.com/installation/ubuntulinux/#docker-maintained-package-installation
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker

sudo sh -c 'echo DOCKER_OPTS=\"\${DOCKER_OPTS} -H unix:///var/run/docker.sock -g /build/docker\" >> /etc/default/docker'
sudo service docker restart
sudo rm -r /var/lib/docker


## Manual setup steps
# Enable Jenkins security
# > Jenkins own user DB
# > logged in users can do anything
# > installing and updating plugins
	#github
	#github pull request builder
	#embeddable build status plugin
	#s3 plugin
	#notification plugin
	#collapsing console sections


