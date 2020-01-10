FROM registry.centos.org/centos:latest

ENV INSTALL_PKGS="git wget curl unzip rpm-build rpmdevtools php72u-cli php72u-fpm php72u-pdo php72u-mysqlnd php72u-opcache php72u-xml php72u-gd php72u-intl php72u-mbstring php72u-process php72u-bcmath php72u-json php72u-soap php72u-pecl-redis php72u-sodium libsodium MariaDB-client"


RUN echo $'[mariadb]\nname = MariaDB\nbaseurl = http://yum.mariadb.org/10.2/centos7-amd64\nenabled = 1\ngpgcheck = 1' > /etc/yum.repos.d/MariaDB.repo && \
    rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
    yum -y install --setopt=tsflags=nodocs https://centos7.iuscommunity.org/ius-release.rpm epel-release && \
    yum -y update --setopt=tsflags=nodocs && \
    yum -y install --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum -y clean all

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer global require hirak/prestissimo
