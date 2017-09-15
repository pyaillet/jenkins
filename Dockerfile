FROM jenkins/jenkins:lts

RUN /usr/local/bin/install-plugins.sh docker-workflow