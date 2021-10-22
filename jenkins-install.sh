#!/bin/bash
yum install java-1.8.0-openjdk
java -version
yum install -y vim && alias vi=vim
mkdir ~/.bash_profile
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/" >> ~/.bash_profile
echo "export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre" >> ~/.bash_profile
source ~/.bash_profile
source /root/.bash_profile
echo $JAVA_HOME
yum install wget -y
yum -y install epel-release
yum -y install daemonize
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins

yum -y install nginx