FROM centos:centos7.9.2009
LABEL Name="Frazer SADO"
LABEL email="sadofrazer@yahoo.fr"
#Install Dependencies
RUN yum update -y && yum install -y git initscripts curl java java-devel unzip which && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && yum install -y git-lfs && yum clean all
# Install heroku cli
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
    && yum -y install nodejs \
    && npm install -g heroku
#install docker
RUN curl -fsSL https://get.docker.com/ | sh

ENV container=docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ “/sys/fs/cgroup” ]

RUN mkdir /jenkins
COPY . /jenkins
RUN sh /jenkins/jenkins-install.sh
RUN cp /jenkins/jenkins.conf /etc/nginx/conf.d/jenkins.conf
EXPOSE 80
EXPOSE 8080

VOLUME /var/lib/jenkins
VOLUME /usr/local/jenkins 

RUN systemctl enable docker
RUN usermod -aG docker jenkins
RUN systemctl enable nginx.service
RUN systemctl enable jenkins
#RUN sh /jenkins/start.sh

CMD ["/usr/sbin/init"]
