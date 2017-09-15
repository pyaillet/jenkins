FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
        maven && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install -y docker-ce

USER jenkins

RUN /usr/local/bin/install-plugins.sh \
        git docker-workflow workflow-aggregator pipeline-maven && \
    echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
COPY tools/* /usr/share/jenkins/ref/
COPY init/* /usr/share/jenkins/ref/init.groovy.d/