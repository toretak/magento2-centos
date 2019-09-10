FROM registry.centos.org/centos:latest

ENV INSTALL_PKGS="git wget curl unzip rpm-build rpmdevtools php71u-cli php71u-bcmath php71u-intl php71u-gd php71u-mbstring php71u-opcache php71u-soap php71u-xml php71u-json php71u-pdo php71u-mysqlnd MariaDB-client"

RUN echo $'[mariadb]\nname = MariaDB\nbaseurl = http://yum.mariadb.org/10.2/centos7-amd64\nenabled = 1\ngpgcheck = 1' > /etc/yum.repos.d/MariaDB.repo && \
    rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
    yum -y install --setopt=tsflags=nodocs https://centos7.iuscommunity.org/ius-release.rpm epel-release && \
    yum -y update --setopt=tsflags=nodocs && \
    yum -y install --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum -y clean all

RUN - curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs && \
    npm install -g grunt && \
    npm install -g imagemagick
